import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CangeProfileService {
  bool readOnly = true;
  bool isChangeNumber = false;
  String? nameController;
  String? photo;
  String? photoUrl;
  String? phone;

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

  void sendCodeToFirebaseChangeNumber() async {
    try {
      if (verificationCode != '' && smsCode.length == 6) {
        var credential = PhoneAuthProvider.credential(
            verificationId: verificationCode, smsCode: smsCode);

        await auth.currentUser?.updatePhoneNumber(credential).then((value) {
          // print(value);
          // isNewUser = value.additionalUserInfo?.isNewUser;
          // print('4'+value. .toString());
          // Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          //   YouSuperPage.routeName,
          //   (_) => false,
          // );
          // print('user logged in');
        });
      }
    } catch (_) {
      // print('wrong pass');
      e = "wrong pass";
      throw Exception('wrong pass');
    }
  }
}
