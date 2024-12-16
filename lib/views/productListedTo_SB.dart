import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductlistedtoSb extends StatefulWidget {
  const ProductlistedtoSb({super.key});

  @override
  State<ProductlistedtoSb> createState() => _ProductlistedtoSbState();
}

class _ProductlistedtoSbState extends State<ProductlistedtoSb> {
  File? _image; // Image file to store selected image
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image =
            File(pickedFile.path); // Convert XFile to File and update state
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected!')),
      );
    }
  }

  Future uploadImage() async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';
    await Supabase.instance.client.storage
        .from('product-images')
        .upload(path, _image!)
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Image Upload Successfully"),
            ),
          ),
        );
  }

  // Function to add product to Supabase
  Future<void> addProduct(String name, String description, double price) async {
    final response =
        await Supabase.instance.client.from('product_data').insert({
      'name': name,
      'description': description,
      'price': price,
    });
    if (response.error != null) {
      print('Error inserting product: ${response.error!.message}');
    } else {
      print('Product added successfully');
    }
  }

  // Controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: const Text('Send Product Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Image selection with GestureDetector
          GestureDetector(
            onTap: _pickImageFromGallery,
            child: _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                  )
                : Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          // Input fields
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32),
          // Submit button
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final description = descriptionController.text.trim();
              final price = double.tryParse(priceController.text) ?? 0;

              if (name.isEmpty || price <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please enter valid product details!'),
                  backgroundColor: Colors.red,
                ));
                return;
              }

              addProduct(name, description, price);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Product data sent!'),
                backgroundColor: Colors.green,
              ));
            },
            child: const Text('Add Product'),
          ),
          ElevatedButton(
            onPressed: uploadImage,
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
