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

  Map<String, dynamic> toFirestoreMap() => {
        'fullName': fullName,
        'taste': taste,
        'interests': interests,
        'writerOf': writerOf,
        'region': region,
      };
}
