import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t_task_manager/src/feature/authentication/data/model/user_model.dart';
import 'package:t_task_manager/src/service/local_database_helper.dart';

class AuthenticationRepository {
  // Create Firebase Auth Instance
  final _auth = FirebaseAuth.instance;

  // Create User with Email and Password
  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return await storeUserData(user);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code}');
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      throw ex.message;
    } 
   
    catch (e) {
      throw SignUpWithEmailAndPasswordFailure();
    }
  }

  // Store User Data in Local Storage (SQLite)
  Future<bool> storeUserData(UserCredential user) async {
    try {
      Database? db = await DatabaseHelper.instance.database();
      debugPrint('User: ${user.user}');
      final userModel = UserModel(
        firstName: user.user?.displayName ?? '',
        lastName: user.user?.displayName ?? '',
        email: user.user?.email ?? '',
        password: user.user!.uid,
        phoneNumber: user.user?.phoneNumber ?? '',
        photoUrl: user.user?.photoURL ?? '',
        uid: user.user!.uid,
        accessToken: user.credential?.accessToken ?? '',
      );
      final result =
          await db!.insert(DatabaseHelper.userTable, userModel.toMap());
      return result > 0;
    } catch (e) {
      debugPrint('StoreUserDataError: $e');
      return false;
    }
  }
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  SignUpWithEmailAndPasswordFailure(
      [this.message = 'An unknown error occurred.']);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure('Email already in use');
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure('Invalid email address');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
            'Server error, please try again later');
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure('Password is too weak');
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}
