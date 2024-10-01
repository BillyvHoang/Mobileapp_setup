import 'package:mobileapp_setup/service/firebase_service.dart';

class UserRepository {
  Future<bool> signIn(String email, String password) async {
    final userCredential = await FirebaseService.signInWithEmailAndPassword(email, password);
    return userCredential != null;
  }

  Future<void> createUser(String uid, Map<String, dynamic> userData) async {
    await FirebaseService.firestore.collection('users').doc(uid).set(userData);
  }

  Stream<Map<String, dynamic>?> getUserStream(String uid) {
    return FirebaseService.firestore.collection('users').doc(uid).snapshots().map((snapshot) => snapshot.data());
  }

  // Add more methods as needed
}