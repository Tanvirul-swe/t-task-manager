import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t_task_manager/src/constant/app_constant.dart';
import 'package:t_task_manager/src/exception/firebase_auth_exceptions.dart';
import 'package:t_task_manager/src/exception/firebase_exceptions.dart';
import 'package:t_task_manager/src/exception/formate_exceptions.dart';
import 'package:t_task_manager/src/exception/platform_exceptions.dart';
import 'package:t_task_manager/src/feature/authentication/data/model/user_model.dart';
import 'package:t_task_manager/src/service/local_database_helper.dart';

class AuthenticationRepository {
  // Create Firebase Auth Instance
  final _auth = FirebaseAuth.instance;

  ///[EmailAndPasswordAuthentication] - REGISTER
  // Create User with Email and Password
  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return await storeUserData(user);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code, e.message ?? "").message;
    } catch (e) {
      throw AppConstant.somethingWantWrrong;
    }
  }

  /// [EmailVerification] - SEND EMAIL VERIFICATION
  // Send Email Verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code, e.message ?? "").message;
    } catch (e) {
      throw AppConstant.somethingWantWrrong;
    }
  }

  ///[Logout] - LOGOUT
  /// Sign Out
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code, e.message ?? "").message;
    } catch (e) {
      throw AppConstant.somethingWantWrrong;
    }
  }

  /// [StoreUserData] - STORE USER DATA
  // Store User Data in Local Storage (SQLite)
  Future<UserCredential?> storeUserData(UserCredential user) async {
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

      await db?.delete(DatabaseHelper.userTable);

      final result =
          await db!.insert(DatabaseHelper.userTable, userModel.toMap());
      db.close();
      return result > 0 ? user : null;
    } catch (e) {
      debugPrint('StoreUserDataError: $e');
      return null;
    }
  }
}
