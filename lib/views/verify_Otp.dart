import 'package:flutter/material.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text('Verify your OTP'),
      ),
    );
  }
}
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ProductlistedtoSb extends StatefulWidget {
//   const ProductlistedtoSb({super.key});

//   @override
//   State<ProductlistedtoSb> createState() => _ProductlistedtoSbState();
// }

// class _ProductlistedtoSbState extends State<ProductlistedtoSb> {
//   File? _image; // Image file to store selected image
//   final ImagePicker _picker = ImagePicker(); // Image picker instance

//   Future<void> _pickImageFromGallery() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image =
//             File(pickedFile.path); // Convert XFile to File and update state
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No image selected!')),
//       );
//     }
//   }

//   Future uploadImage() async {
//     final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     final path = 'uploads/$fileName';
//     await Supabase.instance.client.storage
//         .from('product-images')
//         .upload(path, _image!)
//         .then(
//           (value) => ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Image Upload Successfully"),
//             ),
//           ),
//         );
//   }

//   // Function to add product to Supabase
//   Future<void> addProduct(String name, String description, double price) async {
//     final response =
//         await Supabase.instance.client.from('product_data').insert({
//       'name': name,
//       'description': description,
//       'price': price,
//     });
//     if (response.error != null) {
//       print('Error inserting product: ${response.error!.message}');
//     } else {
//       print('Product added successfully');
//     }
//   }

//   // Controllers for input fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lime,
//         title: const Text('Send Product Details'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Image selection with GestureDetector
//           GestureDetector(
//             onTap: _pickImageFromGallery,
//             child: _image != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.file(
//                       _image!,
//                       fit: BoxFit.cover,
//                       height: 150,
//                       width: double.infinity,
//                     ),
//                   )
//                 : Container(
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(
//                       Icons.image,
//                       color: Colors.grey,
//                       size: 50,
//                     ),
//                   ),
//           ),
//           const SizedBox(height: 20),
//           // Input fields
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(
//               labelText: 'Product Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: descriptionController,
//             decoration: const InputDecoration(
//               labelText: 'Description',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: priceController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               labelText: 'Price',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 32),
//           // Submit button
//           ElevatedButton(
//             onPressed: () {
//               final name = nameController.text.trim();
//               final description = descriptionController.text.trim();
//               final price = double.tryParse(priceController.text) ?? 0;

//               if (name.isEmpty || price <= 0) {
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                   content: Text('Please enter valid product details!'),
//                   backgroundColor: Colors.red,
//                 ));
//                 return;
//               }

//               addProduct(name, description, price);
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 content: Text('Product data sent!'),
//                 backgroundColor: Colors.green,
//               ));
//             },
//             child: const Text('Add Product'),
//           ),
//           ElevatedButton(
//             onPressed: uploadImage,
//             child: Text('Upload Image'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// Future<void> uploadImage(File file) async {
//   try {
//     final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

//     // Replace 'product-images' with your exact bucket name
//     await Supabase.instance.client.storage
//         .from('product-images') // Bucket name here
//         .upload(fileName, file);

//     // Get the public URL
//     final imageUrl = Supabase.instance.client.storage
//         .from('product-images')
//         .getPublicUrl(fileName);

//     print('Image uploaded successfully! Public URL: $imageUrl');
//   } catch (e) {
//     print('Error: $e');
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ProductPage extends StatefulWidget {
//   const ProductPage({super.key});

//   @override
//   State<ProductPage> createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   // Variables for adding a product
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();

//   // List to hold fetched products
//   List<dynamic> products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts(); // Fetch products on app launch
//   }

//   // Function to pick an image from the gallery
//   Future<void> _pickImageFromGallery() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   // Function to upload image and save product details
//   Future<void> addProduct(
//       String name, String description, double price, File? imageFile) async {
//     if (imageFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please select an image')));
//       return;
//     }

//     try {
//       // Upload image to Supabase Storage
//       final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
//       await Supabase.instance.client.storage
//           .from('product-images')
//           .upload(fileName, imageFile);

//       // Get public URL of uploaded image
//       final imageUrl = Supabase.instance.client.storage
//           .from('product-images')
//           .getPublicUrl(fileName);

//       // Insert product details into Supabase table
//       await Supabase.instance.client.from('product_data').insert({
//         'name': name,
//         'description': description,
//         'price': price,
//         'image_url': imageUrl,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Product added successfully!')));

//       // Refresh product list
//       fetchProducts();
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Failed to add product')));
//     }
//   }

//   // Function to fetch products from Supabase
//   Future<void> fetchProducts() async {
//     try {
//       final response =
//           await Supabase.instance.client.from('product_data').select('*');
//       setState(() {
//         products = response;
//       });
//     } catch (e) {
//       print('Error fetching products: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//         backgroundColor: Colors.lime,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: _pickImageFromGallery,
//                     child: _image != null
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.file(
//                               _image!,
//                               height: 150,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : Container(
//                             height: 200,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             alignment: const AlignmentDirectional(0, 0),
//                             child: const Text(
//                               'Tap to Upload Image',
//                               style: TextStyle(
//                                   color: Colors.blueGrey, fontSize: 25),
//                             ),
//                           ),
//                   ),
//                   // ElevatedButton(
//                   //   onPressed: () {
//                   //     if (_image != null) {
//                   //       uploadImage(_image!); // Call uploadImage
//                   //     } else {
//                   //       ScaffoldMessenger.of(context).showSnackBar(
//                   //         const SnackBar(
//                   //             content: Text('Please select an image first!')),
//                   //       );
//                   //     }
//                   //   },
//                   //   style:
//                   //       ElevatedButton.styleFrom(backgroundColor: Colors.lime),
//                   //   child: const Text('Upload Image'),
//                   // ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Product Name',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: descriptionController,
//                     decoration: const InputDecoration(
//                       labelText: 'Description',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: priceController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       labelText: 'Price',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       final name = nameController.text.trim();
//                       final description = descriptionController.text.trim();
//                       final price =
//                           double.tryParse(priceController.text) ?? 0.0;

//                       if (name.isEmpty ||
//                           description.isEmpty ||
//                           price <= 0.0 ||
//                           _image == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text('Enter all details properly')));
//                         return;
//                       }

//                       addProduct(name, description, price, _image);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.lime,
//                     ),
//                     child: const Text('Add Product'),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(thickness: 2),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Product List',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return Card(
//                   elevation: 10,
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: ListTile(
//                     leading: SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: product['image_url'] != null
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.network(
//                                 product['image_url'],
//                                 width: 50,
//                                 height: 50,
//                                 fit: BoxFit.cover,
//                               ),
//                             )
//                           : const Icon(
//                               Icons.image,
//                               size: 50,
//                             ),
//                     ),
//                     title: Text(product['name'] ?? 'No Name'),
//                     subtitle: Text(
//                         '${product['description'] ?? ''}\nPrice: \$${product['price'] ?? '0'}'),
//                     isThreeLine: true,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
