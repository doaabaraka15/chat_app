import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/helper.dart';

class FBAuthController with Helper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

   void _controlErrorCodes(
       BuildContext context, FirebaseAuthException exception) {
     showSnackBar(
         context: context, content: exception.message ?? '', error: true);
     switch (exception.code) {
       case 'email_already-in-use':
         break;
       case 'invalid-email':
         break;
       case 'operation-not-allowed':
         break;
       case 'weak-password':
         break;
       case 'user-not-found':
         break;
       case 'requires-recent-login':
         break;
     }
   }

   String? get email{
     return _firebaseAuth.currentUser!.email;
   }

  Future<bool> createAccount(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _emailValidation(context, userCredential: userCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      _controlErrorCodes(context, e);
    } catch (e) {
      print('Exception: $e');
    }
    return false;
  }

  Future<bool> _emailValidation(BuildContext context,
      {required UserCredential userCredential}) async {
    if (!userCredential.user!.emailVerified) {
      await userCredential.user!.sendEmailVerification();
      await signOut();
      showSnackBar(
          context: context,
          content:
              'Verification email sent!. please check your email and confirm');
      return false;
    }
    return true;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


  Future<bool> signIn(BuildContext context ,{required String email , required String password}) async{
  try{
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    await _emailValidation(context, userCredential: userCredential);
    return true ;
   } on FirebaseAuthException catch (e) {
  _controlErrorCodes(context, e);
  } catch (e) {
  print('Exception: $e');
  }
  return false;
  }
}
