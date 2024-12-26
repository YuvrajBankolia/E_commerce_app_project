import 'dart:io';
import 'package:ecommerce_app/views/loginView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Variables for adding a product
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  List<dynamic> products = [];
  final List<bool> _favorites = List.generate(3, (index) => false);

  // Toggle the favorite status
  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index];
    });
  }

  // List to hold fetched products

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch products on app launch
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to upload image and save product details
  Future<void> addProduct(
      String name, String description, double price, File? imageFile) async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')));
      return;
    }

    try {
      // Upload image to Supabase Storage
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      await Supabase.instance.client.storage
          .from('product-images')
          .upload(fileName, imageFile);

      // Get public URL of uploaded image
      final imageUrl = Supabase.instance.client.storage
          .from('product-images')
          .getPublicUrl(fileName);

      // Insert product details into Supabase table
      await Supabase.instance.client.from('product_data').insert({
        'name': name,
        'description': description,
        'price': price,
        'image_url': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully!')));

      // Refresh product list
      fetchProducts();
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to add product')));
    }
  }

  // Function to fetch products from Supabase
  Future<void> fetchProducts() async {
    try {
      final response =
          await Supabase.instance.client.from('product_data').select('*');
      setState(() {
        products = response;
      });
    } catch (e) {
      print('Error fetching products: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error fetching data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Products'),
          backgroundColor: Colors.lime,
          actions: [
            IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
            ),
            const Icon(Icons.search, color: Colors.black),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImageFromGallery,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _image!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Tap to Upload Image',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 25),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final description = descriptionController.text.trim();
                      final price =
                          double.tryParse(priceController.text) ?? 0.0;

                      if (name.isEmpty ||
                          description.isEmpty ||
                          price <= 0.0 ||
                          _image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Enter all details properly')));
                        return;
                      }

                      addProduct(name, description, price, _image);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lime,
                    ),
                    child: const Text('Add Product'),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Product List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 10,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: product['image_url'] != null
                            ? Image.network(
                                product['image_url'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.broken_image,
                                  color: Colors.red,
                                  size: 50,
                                ),
                              )
                            : const Icon(
                                Icons.image,
                                size: 50,
                              ),
                      ),
                    ),
                    title: Text(product['name'] ?? 'No Name'),
                    subtitle: Text(
                        '${product['description'] ?? ''}\nPrice: \$${product['price'] ?? '0'}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(
                        _favorites[index]
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _favorites[index] ? Colors.red : Colors.grey,
                      ),
                      onPressed: () =>
                          _toggleFavorite(index), // Toggle favorite on tap
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
