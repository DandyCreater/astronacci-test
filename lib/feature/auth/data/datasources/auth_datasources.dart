import 'package:astronacci/feature/auth/data/datasources/i_auth_datasources.dart';
import 'package:astronacci/feature/auth/data/model/login_resp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/regist_resp_model.dart';

class AuthDataSources implements IAuthDataSources {
  @override
  Future<RegistRespModel> createUser(RegisterParameterPost param) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: param.email ?? "",
        password: param.password ?? "",
      );

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': param.email ?? "",
          'password': param.password ?? "",
          'firstName': param.firstName ?? "",
          'lastName': param.lastName ?? "",
          'address': param.address ?? "",
          'bornPlace': param.bornPlace ?? "",
          'bornDate': param.bornDate ?? "",
          'gender': param.gender ?? "",
          'imageUrl': "",
        });
      }
      return RegistRespModel(true, "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return RegistRespModel(false, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        return RegistRespModel(
            false, "The account already exists for that email.");
      } else if (e.code == 'invalid-email') {
        return RegistRespModel(false, "The email address is not valid.");
      } else {
        return RegistRespModel(false, "An unknown error occurred.");
      }
    }
  }

  @override
  Future<LoginRespModel> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (snapshot.exists) {
        return LoginRespModel.fromMap(
            snapshot.data() as Map<String, dynamic>, userCredential.user!.uid);
      }
      return LoginRespModel();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        debugPrint("The password is incorrect.");
        return LoginRespModel(msg: "The password is incorrect.");
      } else if (e.code == 'user-not-found') {
        debugPrint("No user found for that email.");
        return LoginRespModel(msg: "No user found for that email.");
      } else if (e.code == 'invalid-email') {
        debugPrint("The email address is not valid.");
        return LoginRespModel(msg: "The email address is not valid.");
      } else {
        debugPrint("Error logging in: ${e.message}");
        return LoginRespModel(msg: "Error logging in: ${e.message}");
      }
    } catch (e) {
      debugPrint("An unexpected error occurred: $e");
      return LoginRespModel(msg: "An unexpected error occurred: $e");
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint("Reset Password $e");
      return false;
    }
  }

  @override
  Future<LoginRespModel> changePassword(
      String email, String oldPassword, String newPassword) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      await userCredential.user!.updatePassword(newPassword);
      return LoginRespModel();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        debugPrint("The password is incorrect.");
        return LoginRespModel(msg: "The password is incorrect.");
      } else {
        return LoginRespModel(msg: "The password is incorrect.");
      }
    } catch (e) {
      debugPrint("An unexpected error occurred: $e");
      return LoginRespModel(msg: "An unexpected error occurred: $e");
    }
  }
}
