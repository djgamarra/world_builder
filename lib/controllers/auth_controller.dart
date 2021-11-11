import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum AuthStatus { withError, loading, loggedIn, loggedOut }

class AuthController {
  static const errorDelay = Duration(seconds: 4);
  final currentStatus = Rx<AuthStatus>(AuthStatus.loading);
  final currentUser = Rx<User?>(null);
  final errorCode = Rx<String?>(null);

  FirebaseAuth get auth => FirebaseAuth.instance;

  void init() async {
    await Firebase.initializeApp();
    auth.userChanges().listen((user) {
      if (user == null) {
        currentStatus.value = AuthStatus.loggedOut;
      } else {
        currentStatus.value = AuthStatus.loggedIn;
        currentUser.value = user;
      }
    });
  }

  void login(String email, String password) async {
    try {
      _resetErrorCode();
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (_) {
      errorCode.value = 'Usuario o contraseña incorrectos';
      Future.delayed(errorDelay, _resetErrorCode);
    } catch (_) {
      errorCode.value = 'Error de conexión';
      Future.delayed(errorDelay, _resetErrorCode);
    }
  }

  void register() {}

  void logout() {}

  void _resetErrorCode() {
    errorCode.value = null;
  }
}
