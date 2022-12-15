import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseProvider extends ChangeNotifier {
  final _users = FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  final googleSingIn = GoogleSignIn();
  late bool _signIn;

  FireBaseProvider() {
    _signIn = false;
  }
  bool get signIn => _signIn;

  set signIn(bool signIn) {
    _signIn = signIn;
    notifyListeners();
  }

  Future login({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      return null;
    } on FirebaseAuthException catch (s) {
      return s.message;
    }
  }

  Future registerMail({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      return null;
    } on FirebaseException catch (s) {
      return s.message;
    }
  }

  Future userDetail(
      {String? email,
      String? name,
      String? surname,
      String? phoneNumber,
      String? country,
      String? userId,
      String? creationDate}) async {
    try {
      await _users.doc(userId).set({
        "userId": userId,
        "creationDate": creationDate,
        "name": name,
        "surname": surname,
        "email": email,
        "countryCode": country,
        "phoneNumber": phoneNumber,
      });
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}

void logout() async {
  FirebaseAuth.instance.signOut();
}
