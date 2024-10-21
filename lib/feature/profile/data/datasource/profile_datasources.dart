import 'package:astronacci/feature/profile/data/model/edit_profile_resp_model.dart';

import 'package:astronacci/feature/auth/data/model/login_resp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'i_profile_datasources.dart';

class ProfileDataSources implements IProfileDataSources {
  @override
  Future<LoginRespModel> updateProfile(EditProfileParameterPost params) async {
    String downloadUrl = "";
    try {
      if (params.imageUrl != "" || params.fileData.path != "") {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('uploads/${DateTime.now().millisecondsSinceEpoch}.jpg');

        await ref.putFile(params.fileData);
        downloadUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('users').doc(params.uid).set({
        'firstName': params.firstName,
        'lastName': params.lastName,
        'bornPlace': params.bornPlace,
        'bornDate': params.bornDate,
        'gender': params.gender,
        'address': params.address,
        'imageUrl': downloadUrl,
      }, SetOptions(merge: true));

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(params.uid)
          .get();
      if (snapshot.exists) {
        return LoginRespModel.fromMap(
            snapshot.data() as Map<String, dynamic>, params.uid ?? "");
      }
      return LoginRespModel();
    } catch (e) {
      debugPrint("update Profile Error $e");
      return LoginRespModel(msg: "Something Wrong error !");
    }
  }
}
