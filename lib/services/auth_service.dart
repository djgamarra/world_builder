import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth get auth => FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  void subscribeToChanges(Function(User?) func) =>
      auth.userChanges().listen(func);

  Future<UserCredential> login(String email, String password) =>
      auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<UserCredential> createUser(String email, String password) =>
      auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<void> setUsername(User user, String username) =>
      user.updateDisplayName(username);

  Future<void> logout() => auth.signOut();
}
