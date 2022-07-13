import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/income_screen/new_user/you_super_page.dart';

class AuthReposytory {
  AuthReposytory(this.phoneNumberForVerification);
  String phoneNumberForVerification;
  String phoneNumber = '';
  String verificationCode = '';
  String smsCode = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  bool? isNewUser;
  // User? firebaseUser;
  // LocalUser? localUser;

  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumberForVerification,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {}
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // print(phoneNumberForVerification);
          // print('The provided phone number is not valid.');
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

  Future<void> sendCodeToFirebase(context) async {
    try {
      if (verificationCode != '' && smsCode.length == 6) {
        var credential = PhoneAuthProvider.credential(
            verificationId: verificationCode, smsCode: smsCode);

        await auth.signInWithCredential(credential).then((value) {
          isNewUser = value.additionalUserInfo?.isNewUser;
          // print('4'+value. .toString());
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
            YouSuperPage.routeName,
            (_) => false,
          );
          // print('user logged in');
        });
      }
    } catch (_) {
      // print('wrong pass');
      throw Exception('wrong pass');
    }

    // .whenComplete(() {})
    // .onError((error, stackTrace) {
    //   setState(() {
    //     _textEditingController.text = "";
    //     this._status = Status.Error;
    //   });
    // });
  }
}
