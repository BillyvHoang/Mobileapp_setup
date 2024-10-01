import 'package:mobileapp_setup/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  Future<bool> signIn(String email, String password) async {
    final userCredential = await FirebaseService.signInWithEmailAndPassword(email, password);
    return userCredential != null;
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      // Create user with email and password using Firebase Auth directly
      UserCredential userCredential = await FirebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      
      if (userCredential.user != null) {
        // If user creation is successful, store additional user data
        await createUser(userCredential.user!.uid, {
          'name': name,
          'email': email,
          'createdAt': DateTime.now().toIso8601String(),
          // Add any other user data you want to store
        });
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print('Error during sign up: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected error during sign up: $e');
      return false;
    }
  }

  Future<void> createUser(String uid, Map<String, dynamic> userData) async {
    await FirebaseService.firestore.collection('users').doc(uid).set(userData);
  }

  Stream<Map<String, dynamic>?> getUserStream(String uid) {
    return FirebaseService.firestore.collection('users').doc(uid).snapshots().map((snapshot) => snapshot.data());
  }
}