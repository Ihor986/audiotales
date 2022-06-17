import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../data_base/data/local_data_base.dart';
import '../data_base/data_base.dart';
import '../models/user.dart';

class CangeProfileService {
  bool readOnly = true;
  bool isChangeNumber = false;
  String? nameController;
  String? photo;
  String? photoUrl;
  String? phone;
  File? imageFile;

  // String phoneNumber = '';
  String verificationCode = '';
  String smsCode = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  String? e;
  // bool? isNewUser;

  void dispouse() {
    readOnly = true;
    isChangeNumber = false;
    nameController = null;
    photo = null;
    photoUrl = null;
    phone = null;
    e = null;
    verificationCode = '';
    smsCode = '';
  }

  Future saveImage(LocalUser localUser) async {
    if (photo == null) return;
    localUser.photo = photo;
    imageFile = File(photo!);
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('${LocalDB.instance.getUser().id}/images/avatar')
          .child('${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(imageFile!);
      localUser.photoUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print(e);
    }
    print('to fs');
    DataBase.instance.saveUser(localUser);
    print('to fs');
  }

///////////////////////////

  void changePhoneNumber() async {
    if (phone == null) {
      return;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.currentUser
            ?.updatePhoneNumber(credential)
            .then((value) async {
          // if (value.user != null) {}
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // throw Exception(e.code);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationCode = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) async {
        verificationCode = verificationId;
      },
    );
  }

  void sendCodeToFirebaseChangeNumber() async {
    try {
      if (verificationCode != '' && smsCode.length == 6) {
        var credential = PhoneAuthProvider.credential(
            verificationId: verificationCode, smsCode: smsCode);

        await auth.currentUser?.updatePhoneNumber(credential).then((value) {});
      }
    } catch (_) {
      e = "wrong pass";
      throw Exception('wrong pass');
    }
  }
}
