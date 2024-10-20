import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb check

// FirestoreService Class
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Product with Image URL
  Future<void> addProduct(String name, String type, double price, String? imageUrl) {
    return _firestore.collection('products').add({
      'name': name,
      'type': type,
      'price': price,
      'imageUrl': imageUrl, // Save image URL in Firestore
    });
  }

  // Update Product with Image URL
  Future<void> updateProduct(String docID, String name, String type, double price, String? imageUrl) {
    return _firestore.collection('products').doc(docID).update({
      'name': name,
      'type': type,
      'price': price,
      'imageUrl': imageUrl, // Update image URL if present
    });
  }

  // Delete Product
  Future<void> deleteProduct(String docID) {
    return _firestore.collection('products').doc(docID).delete();
  }

  // Get Stream of Products
  Stream<QuerySnapshot> getProductsStream() {
    return _firestore.collection('products').snapshots();
  }
}

// StorageService Class
class StorageService with ChangeNotifier {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Unified method to upload image for both web and mobile platforms
  Future<String?> uploadImage() async {
    if (kIsWeb) {
      return await _uploadImageWeb();
    } else {
      return await _uploadImageMobile();
    }
  }

  // Method for uploading image on mobile platforms
  Future<String?> _uploadImageMobile() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      File file = File(image.path);
      String filePath = 'uploaded_images/${DateTime.now()}.png';

      await _firebaseStorage.ref(filePath).putFile(file);
      return await _firebaseStorage.ref(filePath).getDownloadURL();
    } catch (e) {
      print('Error uploading image on mobile: $e');
      return null;
    }
  }

  // Method for uploading image on web platforms
  // Method for uploading image on web platforms
  Future<String?> _uploadImageWeb() async {
  try {
    // Create file input element for picking image
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    // Wait for the user to select a file
    await uploadInput.onChange.first;

    if (uploadInput.files == null || uploadInput.files!.isEmpty) {
      return null;
    }

    // Get the selected file
    final file = uploadInput.files!.first;
    
    // Use FileReader to read the file as an ArrayBuffer (Uint8List)
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    // Wait until file is fully loaded
    await reader.onLoad.first;

    // Cast the result to Uint8List
    final Uint8List fileBytes = reader.result as Uint8List;

    // Create a unique file path for Firebase Storage
    String filePath = 'uploaded_images/${DateTime.now()}.png';

    // Create a reference to the Firebase Storage location
    final storageRef = _firebaseStorage.ref().child(filePath);

    // Upload the file to Firebase Storage
    final uploadTask = storageRef.putData(fileBytes);
    await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded file
    return await storageRef.getDownloadURL();
  } catch (e) {
    print('Error uploading image on web: $e');
    return null;
  }
}


}
