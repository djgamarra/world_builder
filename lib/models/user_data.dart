import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String uid, email, username, fullName, region;
  final String taste, interests, writerOf;
  final User user;

  const UserData({
    required this.uid,
    required this.email,
    required this.username,
    required this.fullName,
    required this.region,
    required this.user,
    required this.taste,
    required this.interests,
    required this.writerOf,
  });

  static UserData fromFirebase({
    required User user,
    required Map<String, dynamic> data,
  }) =>
      UserData(
        user: user,
        uid: user.uid,
        email: user.email!,
        username: data['username'],
        fullName: data['fullName'],
        region: data['region'],
        taste: data['taste'],
        interests: data['interests'],
        writerOf: data['writerOf'],
      );

  Map<String, dynamic> toFirestoreMap() => {
        'email': email,
        'username': username,
        'fullName': fullName,
        'region': region,
        'taste': taste,
        'interests': interests,
        'writerOf': writerOf,
      };
}
