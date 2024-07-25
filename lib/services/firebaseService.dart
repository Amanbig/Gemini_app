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
        // Save username in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
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

  Stream<QuerySnapshot> getCollectionStream(String collection) {
    return _firestore.collection(collection).snapshots();
  }

  // Storage methods
  // Future<String?> uploadFile(String path, String filePath) async {
  //   try {
  //     File file = File(filePath);
  //     TaskSnapshot taskSnapshot = await _storage.ref(path).putFile(file);
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //     return downloadUrl;
  //   } catch (e) {
  //     print("Error uploading file: $e");
  //     return null;
  //   }
  // }
  //
  // Future<void> deleteFile(String path) async {
  //   try {
  //     await _storage.ref(path).delete();
  //   } catch (e) {
  //     print("Error deleting file: $e");
  //   }
  // }
  //
  // Future<String> getDownloadUrl(String path) async {
  //   try {
  //     String downloadUrl = await _storage.ref(path).getDownloadURL();
  //     return downloadUrl;
  //   } catch (e) {
  //     print("Error getting download URL: $e");
  //     return Future.error(e);
  //   }
  // }
}
