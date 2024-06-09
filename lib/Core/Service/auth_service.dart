import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<bool> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = await auth.currentUser!; 
      await user.updateProfile(
          displayName: fullName); 
          final FirebaseFirestore _firestore = FirebaseFirestore.instance;

          await _firestore.collection('users').doc(user.uid).set({
      'email': email,
      'name': fullName,
    });

      print('User created and profile updated , and data saved successfully !');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The email address is already in use by another account.');
        return false;
      } else {
        print(e.code); // Print the error code for debugging
        return false;
      }
    } catch (e) {
      print(e); // Catch any other errors
      return false;
    }
  }

  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      print('User signed in successfully!');
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('The user account does not exist.');
      } else if (e.code == 'wrong-password') {
        print('The password provided is incorrect.');
      } else {
        print(e.code);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> saveUserLogin(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn =
        prefs.getBool('isLoggedIn') ?? false; // Default to false if not found
    return isLoggedIn;
  }

  static Future<void> signOut() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      await saveUserLogin(false);
      print('User signed out successfully!');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
