import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/services/authentication_service.dart';
import 'package:world_builder/services/firestore_service.dart';

enum AuthStatus { withError, loading, loggedIn, loggedOut }

class UsersController {
  late final AuthenticationService _auth;
  late final FirestoreService _store;

  final currentStatus = Rx<AuthStatus>(AuthStatus.loading);
  final currentUser = Rx<UserData?>(null);
  final errorMessage = Rx<String?>(null);
  final loading = Rx<bool>(false);

  UsersController({
    required AuthenticationService authenticationService,
    required FirestoreService firestoreService,
  }) {
    _auth = authenticationService;
    _store = firestoreService;
  }

  Future<void> init() async {
    _auth.subscribeToChanges(_handleAuthChanges);
  }

  void _handleAuthChanges(User? user) async {
    if (user == null) {
      currentUser.value = null;
      currentStatus.value = AuthStatus.loggedOut;
    } else {
      Map<String, dynamic> data = {};
      try {
        final storeData = await Future.wait([
          _store.get('users_private', user.uid),
          _store.get('users_public', user.uid),
        ]);
        data.addAll(storeData[0].data() ?? {});
        data.addAll(storeData[1].data() ?? {});
      } catch (_) {
        data = {};
      }
      currentUser.value = UserData.fromFirebase(
        user: user,
        data: data,
      );
      currentStatus.value = AuthStatus.loggedIn;
    }
    loading.value = false;
  }

  Future<List<Map<String, dynamic>>> searchUsers(String searchText) async {
    var region = 'GLOBAL';
    final user = currentUser.value;
    if (user != null) {
      region = user.region;
    }
    var query = _store.query('users_public').where('region', isEqualTo: region);
    searchText.split('').forEach((char) {
      query = query.where("usernameIndex.$char", isEqualTo: true);
    });
    return (await query.limit(10).get()).docs.map((e) => e.data()).toList();
  }

  void updateProfile(
    String fullName,
    String taste,
    String interests,
    String writerOf,
  ) async {
    final user = currentUser.value;
    if (user == null) return;
    loading.value = true;
    final newUserData = UserData(
      uid: user.uid,
      email: user.email,
      username: user.username,
      fullName: fullName,
      region: user.region,
      user: user.user,
      taste: taste,
      interests: interests,
      writerOf: writerOf,
    );
    currentUser.value = newUserData;
    try {
      await Future.wait([
        _store.set(
          'users_private',
          user.uid,
          newUserData.toFirestoreMapPrivate(),
        ),
        _store.set(
          'users_public',
          user.uid,
          newUserData.toFirestoreMapPublic(),
        ),
      ]);
    } catch (_) {
      errorMessage.value = 'Error de conexión';
    }
    loading.value = false;
  }

  void login(String email, String password) async {
    loading.value = true;
    try {
      _resetErrorCode();
      await _auth.login(email, password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
        case 'user-not-found':
        case 'wrong-password':
          errorMessage.value = 'Usuario y/o contraseña incorrectos';
          break;
        case 'user-disabled':
          errorMessage.value = 'Usuario bloqueado';
          break;
        default:
          errorMessage.value = 'Error de conexión';
      }
      loading.value = false;
    } catch (e) {
      errorMessage.value = 'Error de conexión';
      loading.value = false;
    }
  }

  void register(
    String email,
    String password,
    String username,
    String fullName,
    String region,
  ) async {
    loading.value = true;
    try {
      _resetErrorCode();
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
      await Future.wait([
        _store.set(
          'users_private',
          credentials.user!.uid,
          user.toFirestoreMapPrivate(),
        ),
        _store.set(
          'users_public',
          credentials.user!.uid,
          user.toFirestoreMapPublic(),
        ),
      ]);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage.value = 'Correo ya registrado';
          break;
        case 'invalid-email':
          errorMessage.value = 'Correo inválido';
          break;
        case 'weak-password':
          errorMessage.value = 'Contraseña inválida';
          break;
        default:
          errorMessage.value = 'Error de conexión';
      }
      loading.value = false;
    } catch (e) {
      errorMessage.value = 'Error de conexión';
      loading.value = false;
    }
  }

  void logout() async {
    await _auth.logout();
    loading.value = false;
  }

  void _resetErrorCode() {
    errorMessage.value = null;
  }
}
