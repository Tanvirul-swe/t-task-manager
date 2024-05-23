import 'package:t_task_manager/src/service/local_database_helper.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  final String accessToken;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uid,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      photoUrl: json['photoUrl'],
      uid: json['uid'],
      accessToken: json['accessToken'],
    );
  }

  factory UserModel.fromLocalDB(Map<String, dynamic> json) {
    return UserModel(
      firstName: json[DatabaseHelper.columnFirstName],
      lastName: json[DatabaseHelper.columnLastName],
      email: json[DatabaseHelper.columnEmail],
      password: json[DatabaseHelper.columnPassword],
      phoneNumber: json[DatabaseHelper.columnPhoneNumber],
      photoUrl: json[DatabaseHelper.columnPhotoUrl],
      uid: json[DatabaseHelper.columnUid],
      accessToken: json[DatabaseHelper.columnAccessToken],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnFirstName: firstName,
      DatabaseHelper.columnLastName: lastName,
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnPassword: password,
      DatabaseHelper.columnPhoneNumber: phoneNumber,
      DatabaseHelper.columnPhotoUrl: photoUrl,
      DatabaseHelper.columnUid: uid,
      DatabaseHelper.columnAccessToken: accessToken,
    };
  }
}
