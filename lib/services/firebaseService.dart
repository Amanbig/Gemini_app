import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gemini_app/firebase_options.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  }

  // Authentication methods
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  Future<User?> registerWithEmailPassword(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        // Update the user's display name
        await user.updateDisplayName(username);
        await user.reload();
        user = _auth.currentUser;

        // Optionally, you can still save other user data in Firestore
        await _firestore.collection('users').doc(user?.uid).set({
          'email': email,
        });
      }

      return user;
    } catch (e) {
      print("Error registering: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Firestore methods
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      print("Error adding document: $e");
    }
  }

  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(collection).doc(docId).get();
      return doc;
    } catch (e) {
      print("Error getting document: $e");
      return Future.error(e);
    }
  }

  // Add this method in your FirebaseService class

  Future<List<DocumentSnapshot>> getGeneratedContents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('generatedContents')
          .orderBy('timestamp', descending: true)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching documents: $e");
      return [];
    }
  }

  Stream<QuerySnapshot> getCollectionStream(String collection) {
    return _firestore.collection(collection).snapshots();
  }

  Stream<QuerySnapshot> getChatMessagesStream(String collection) {
    return _firestore.collection(collection).orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> addChatMessage(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      print("Error adding chat message: $e");
    }
  }
}
