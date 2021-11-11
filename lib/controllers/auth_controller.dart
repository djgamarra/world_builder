import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum AuthStatus { loading, loggedIn, loggedOut }

class AuthController {
  final _currentStatus = Rx<AuthStatus>(AuthStatus.loading);
  final _currentUser = Rx<User?>(null);

  AuthStatus get currentStatus => _currentStatus.value;

  User? get currentUser => _currentUser.value;

  FirebaseAuth get auth => FirebaseAuth.instance;

  void init() async {
    await Firebase.initializeApp();
    auth.userChanges().listen((user) {
      if (user == null) {
        _currentStatus.value = AuthStatus.loggedOut;
      } else {
        _currentStatus.value = AuthStatus.loggedIn;
        _currentUser.value = user;
        print(currentUser);
      }
    });
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  void register() {}

  void logout() {}
}
