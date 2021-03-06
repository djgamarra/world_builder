import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/services/auth_service.dart';
import 'package:world_builder/services/users_service.dart';

abstract class AuthStatus {
  const AuthStatus();
}

class NotAuthStatus extends AuthStatus {
  const NotAuthStatus();
}

class AuthInProgressStatus extends AuthStatus {
  const AuthInProgressStatus();
}

class AuthOkStatus extends AuthStatus {
  final UserData userData;

  const AuthOkStatus({required this.userData});
}

class AuthCurrentUserUpdateStatus extends AuthOkStatus {
  AuthCurrentUserUpdateStatus({required UserData userData})
      : super(userData: userData);
}

class AuthErrorStatus extends AuthStatus {
  final String errorMessage;

  const AuthErrorStatus({required this.errorMessage});
}

class AuthController {
  final _auth = Get.find<AuthService>();
  final _users = Get.find<UsersService>();

  final currentStatus = Rx<AuthStatus>(const NotAuthStatus());

  Future<bool> updateCurrentUserData(
    String fullName,
    String taste,
    String interests,
    String writerOf,
  ) async {
    final status = currentStatus.value as AuthOkStatus;
    currentStatus.value =
        AuthCurrentUserUpdateStatus(userData: status.userData);
    final newUserData = await _users.updateProfile(
      fullName,
      taste,
      interests,
      writerOf,
      status.userData,
    );
    currentStatus.value = AuthOkStatus(userData: newUserData);
    return newUserData != status.userData;
  }

  Future<bool> reLogin() async {
    currentStatus.value = const AuthInProgressStatus();
    final user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> data;
      try {
        final storeData = await _users.getUserData(user.uid);
        data = storeData[0].data() ?? {};
        data.addAll(storeData[1].data() ?? {});
      } catch (_) {
        data = {};
      }
      currentStatus.value = AuthOkStatus(
        userData: UserData.fromFirebase(
          user: user,
          data: data,
        ),
      );
      return true;
    }
    currentStatus.value = const NotAuthStatus();
    return false;
  }

  Future<bool> login(String email, String password) async {
    currentStatus.value = const AuthInProgressStatus();
    String errorMessage;
    try {
      final credentials = await _auth.login(email, password);
      final user = credentials.user!;
      Map<String, dynamic> data;
      try {
        final storeData = await _users.getUserData(user.uid);
        data = storeData[0].data() ?? {};
        data.addAll(storeData[1].data() ?? {});
      } catch (_) {
        data = {};
      }
      currentStatus.value = AuthOkStatus(
        userData: UserData.fromFirebase(
          user: user,
          data: data,
        ),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
        case 'user-not-found':
        case 'wrong-password':
          errorMessage = 'Usuario y/o contrase??a incorrectos';
          break;
        case 'user-disabled':
          errorMessage = 'Usuario bloqueado';
          break;
        default:
          errorMessage = 'Error de conexi??n';
      }
    } catch (e) {
      errorMessage = 'Error de conexi??n';
    }
    currentStatus.value = AuthErrorStatus(
      errorMessage: errorMessage,
    );
    return false;
  }

  Future<bool> register(
    String email,
    String password,
    String username,
    String fullName,
    String region,
  ) async {
    currentStatus.value = const AuthInProgressStatus();
    try {
      final credentials = await _auth.createUser(email, password);
      final authUser = credentials.user!;
      final user = UserData(
        uid: authUser.uid,
        email: authUser.email!,
        username: username,
        fullName: fullName,
        region: region,
        user: authUser,
        taste: '',
        interests: '',
        writerOf: '',
      );
      await _users.setUserData(user);
      currentStatus.value = AuthOkStatus(userData: user);
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Correo ya registrado';
          break;
        case 'invalid-email':
          errorMessage = 'Correo inv??lido';
          break;
        case 'weak-password':
          errorMessage = 'Contrase??a inv??lida';
          break;
        default:
          errorMessage = 'Error de conexi??n';
      }
      currentStatus.value = AuthErrorStatus(errorMessage: errorMessage);
    } catch (e) {
      currentStatus.value = const AuthErrorStatus(
        errorMessage: 'Error de conexi??n',
      );
    }
    return false;
  }

  Future<void> logout() async {
    await _auth.logout();
    currentStatus.value = const NotAuthStatus();
  }
}
