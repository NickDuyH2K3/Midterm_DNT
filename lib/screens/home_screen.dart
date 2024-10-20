
import 'package:flutter/material.dart';
import 'package:MIDTERM_CRUD/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final StorageService storageService = StorageService(); // Add StorageService here
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? imageUrl; // To store uploaded image URL
  File? _imageFile; // Store image file locally if needed

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void openProductBox({
    String? docID,
    String? currentName,
    String? currentType,
    double? currentPrice,
    String? currentImage,
  }) {
    if (currentName != null) nameController.text = currentName;
    if (currentType != null) typeController.text = currentType;
    if (currentPrice != null) priceController.text = currentPrice.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Product Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _uploadImage, // Call the method to upload image
              icon: const Icon(Icons.image),
              label: const Text("Upload Image"),
            ),
            if (imageUrl != null)
              const SizedBox(height: 10),
            if (imageUrl != null)
              Image.network(imageUrl!, height: 100), // Display uploaded image if available
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (docID == null) {
                // Add new product with image URL
                await firestoreService.addProduct(
                  nameController.text,
                  typeController.text,
                  double.parse(priceController.text),
                  imageUrl,
                );
              } else {
                // Update existing product with image URL
                await firestoreService.updateProduct(
                  docID,
                  nameController.text,
                  typeController.text,
                  double.parse(priceController.text),
                  imageUrl ?? currentImage, // Keep the current image if no new image is uploaded
                );
              }

              nameController.clear();
              typeController.clear();
              priceController.clear();
              imageUrl = null; // Clear imageUrl after saving
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // Method to upload an image using the StorageService
  Future<void> _uploadImage() async {
    String? uploadedImageUrl = await storageService.uploadImage(); // Use StorageService to upload
    if (uploadedImageUrl != null) {
      setState(() {
        imageUrl = uploadedImageUrl; // Store the uploaded image URL
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openProductBox(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List productList = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = productList[index];
                String docID = document.id;

                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String name = data['name'];
                String type = data['type'];
                double price = data['price'];
                String? imageUrl = data['imageUrl'];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    title: Text(
                      "$name - $type",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text("Price: \$${price.toStringAsFixed(2)}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => openProductBox(
                            docID: docID,
                            currentName: name,
                            currentType: type,
                            currentPrice: price,
                            currentImage: imageUrl,
                          ),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () => firestoreService.deleteProduct(docID),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                    leading: data['imageUrl'] != null
                              ? Image.network(
                                  Uri.decodeFull(data['imageUrl']),  // Decode the URL before using it
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                )
                              : const Icon(Icons.image, size: 50),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
