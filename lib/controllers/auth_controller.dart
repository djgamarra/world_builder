import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum AuthStatus { withError, loading, loggedIn, loggedOut }

class AuthController {
  final currentStatus = Rx<AuthStatus>(AuthStatus.loading);
  final currentUser = Rx<User?>(null);
  final errorMessage = Rx<String?>(null);

  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get store => FirebaseFirestore.instance;

  void init() async {
    await Firebase.initializeApp();
    auth.userChanges().listen((user) {
      if (user == null) {
        currentStatus.value = AuthStatus.loggedOut;
      } else {
        currentStatus.value = AuthStatus.loggedIn;
        currentUser.value = user;
        print(currentUser.value);
      }
    });
  }

  void login(String email, String password) async {
    try {
      _resetErrorCode();
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
    } catch (_) {
      errorMessage.value = 'Error de conexión';
    }
  }

  void register(String email, String password, String username, String fullName, String region) async {
    try {
      _resetErrorCode();
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credentials.user!.updateDisplayName(username);
      await store.collection('users').doc(credentials.user!.uid).set({
        fullName: fullName,
        region: region,
      });
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
    } catch (_) {
      errorMessage.value = 'Error de conexión';
    }
  }

  void logout() async {
    await auth.signOut();
  }

  void _resetErrorCode() {
    errorMessage.value = null;
  }
}
