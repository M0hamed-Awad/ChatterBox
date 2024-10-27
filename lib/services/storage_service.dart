import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

class StorageService {
  StorageService();

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageFromDevice({
    required String imagePath,
    required String uid,
  }) async {
    try {
      // Convert path to File object
      File imageFile = File(imagePath);

      // Create a folder in firebase storage called "users", inside this folder another folder called "users_profile_images".
      Reference fileRef = _firebaseStorage
          .ref("users/users_profile_images")
          .child("$uid${p.extension(imageFile.path)}");

      // To ensure that all the files names are unique we named them by the user Unique ID (UID).
      // We used the Path package to extract the file extension properly and add it to the file name.

      UploadTask uploadTask = fileRef.putFile(imageFile);

      // Await for the upload task to complete
      TaskSnapshot snapshot = await uploadTask;

      // Check if the task completed successfully
      if (snapshot.state == TaskState.success) {
        // Get the download URL after successful upload
        String downloadUrl = await fileRef.getDownloadURL();
        debugPrint('Uploaded: $downloadUrl');
        return downloadUrl; // Return the download URL
      }
      // Handle upload failure
      else {
        throw Exception("Upload failed.");
      }
    }
    // Handle error
    catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  Future<String> uploadImageFromAssets({
    required String assetPath,
    required String uid,
  }) async {
    try {
      // Load the asset as byte data
      ByteData byteData = await rootBundle.load(assetPath);

      // Convert ByteData to Uint8List (byte array)
      Uint8List imageBytesData = byteData.buffer.asUint8List();

      // Create a reference to the storage bucket
      Reference fileRef = FirebaseStorage.instance
          .ref('users/users_profile_images')
          .child("$uid.png");

      // Upload the byte data to Firebase Storage
      UploadTask uploadTask = fileRef.putData(imageBytesData);

      // Await for the upload task to complete
      TaskSnapshot snapshot = await uploadTask;

      // Check if upload was successful
      if (snapshot.state == TaskState.success) {
        // Get the download URL of the uploaded image
        String downloadUrl = await fileRef.getDownloadURL();
        debugPrint('Uploaded: $downloadUrl');
        return downloadUrl; // Return the download URL
      }
      // Handle upload failure
      else {
        throw Exception("Upload failed.");
      }
    }
    // Handle errors
    catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }
}
