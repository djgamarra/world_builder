import 'package:firebase_auth/firebase_auth.dart';

class ExternalUserData {
  final String uid, username, taste, interests, writerOf, region;

  const ExternalUserData({
    required this.uid,
    required this.username,
    required this.taste,
    required this.interests,
    required this.writerOf,
    required this.region,
  });

  Map<String, bool> get usernameIndexMap {
    final map = <String, bool>{};
    username.split('').toSet().forEach((element) {
      map[element] = true;
    });
    return map;
  }

  Map<String, dynamic> toFirestoreMapPublic() => {
        'username': username,
        'region': region,
        'taste': taste,
        'interests': interests,
        'writerOf': writerOf,
        'usernameIndex': usernameIndexMap,
      };
}

class UserData extends ExternalUserData {
  final String email, fullName;
  final User user;

  const UserData({
    required this.email,
    required this.fullName,
    required this.user,
    required String uid,
    required String username,
    required String region,
    required String taste,
    required String interests,
    required String writerOf,
  }) : super(
          uid: uid,
          region: region,
          writerOf: writerOf,
          interests: interests,
          taste: taste,
          username: username,
        );

  static UserData fromFirebase({
    required User user,
    required Map<String, dynamic> data,
  }) =>
      UserData(
        user: user,
        uid: user.uid,
        email: user.email!,
        username: data['username'] ?? '',
        fullName: data['fullName'] ?? '',
        region: data['region'] ?? '',
        taste: data['taste'] ?? '',
        interests: data['interests'] ?? '',
        writerOf: data['writerOf'] ?? '',
      );

  Map<String, dynamic> toFirestoreMapPrivate() => {
        'email': email,
        'fullName': fullName,
      };
}
