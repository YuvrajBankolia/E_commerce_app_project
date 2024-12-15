// // import 'package:ecommerce_app/navigationScreens/cart_screen.dart';
// // import 'package:ecommerce_app/navigationScreens/settingScrren.dart';
// // import 'package:ecommerce_app/navigationScreens/wishlistScreen.dart';
// // import 'package:ecommerce_app/views/loginView.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class Homepage extends StatefulWidget {
// //   const Homepage({super.key});

// //   @override
// //   State<Homepage> createState() => _HomepageState();
// // }

// // class _HomepageState extends State<Homepage> {
// //   Future<void> _logout(BuildContext context) async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     await prefs.clear();
// //     Navigator.of(context).pushReplacement(
// //       MaterialPageRoute(
// //         builder: (context) => const Loginview(),
// //       ),
// //     );
// //   }

// //   int _currentIndex = 0;
// //   final List<Widget> _pages = [
// //     const Homepage(),
// //     const Wishlistscreen(),
// //     const CartScreen(),
// //     const Settingscrren(),
// //   ];
// //   void _onTabChanged(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         leading: const Icon(
// //           Icons.menu,
// //           color: Colors.black,
// //         ),
// //         elevation: 0,
// //         actions: const [
// //           Icon(Icons.search, color: Colors.black),
// //           SizedBox(width: 20),
// //           Icon(Icons.wallet, color: Colors.black),
// //           SizedBox(width: 20),
// //         ],
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: _onTabChanged,
// //         items: [
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.grey,
// //             icon: Icon(Icons.home),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.red,
// //             icon: Icon(Icons.favorite_border),
// //             label: 'Wishlist',
// //           ),
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.pink,
// //             icon: Icon(Icons.shopping_cart),
// //             label: 'Cart',
// //           ),
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.purple,
// //             icon: Icon(Icons.settings),
// //             label: 'Settings',
// //           ),
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.grey,
// //             icon: Icon(Icons.info),
// //             label: 'Info', // Updated from empty string to a valid label
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.only(left: 50),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'Categories',
// //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 20),
// //             const Row(
// //               children: [
// //                 Text(
// //                   'All',
// //                   style: TextStyle(color: Colors.red),
// //                 ),
// //                 SizedBox(width: 20),
// //                 Text('Pesticides'),
// //                 SizedBox(width: 20),
// //                 Text('Fertilizers'),
// //               ],
// //             ),
// //             const SizedBox(height: 20),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Container(
// //                 height: 210,
// //                 width: 280,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(10),
// //                   image: const DecorationImage(
// //                     image: AssetImage('assets/images/vermicompost.png'),
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:ecommerce_app/navigationScreens/cart_screen.dart';
// import 'package:ecommerce_app/navigationScreens/settingScrren.dart';
// import 'package:ecommerce_app/navigationScreens/wishlistScreen.dart';
// import 'package:ecommerce_app/views/loginView.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => const Loginview(),
//       ),
//     );
//   }

//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const CategoriesScreen(), // Replaced duplicate Homepage with CategoriesScreen
//     const Wishlistscreen(),
//     const CartScreen(),
//     const Settingscrren(),
//     // const InfoScreen(), // Added a placeholder InfoScreen
//   ];

//   void _onTabChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: const Icon(
//           Icons.menu,
//           color: Colors.black,
//         ),
//         elevation: 0,
//         actions: const [
//           Icon(Icons.search, color: Colors.black),
//           SizedBox(width: 20),
//           Icon(Icons.wallet, color: Colors.black),
//           SizedBox(width: 20),
//         ],
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTabChanged,
//         items: const [
//           BottomNavigationBarItem(
//             backgroundColor: Colors.grey,
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.red,
//             icon: Icon(Icons.favorite_border),
//             label: 'Wishlist',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.pink,
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.purple,
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.grey,
//             icon: Icon(Icons.info),
//             label: 'Info',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Categories Screen Widget (Extracted from `Homepage`)
// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 50),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Categories',
//             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           const Row(
//             children: [
//               Text(
//                 'All',
//                 style: TextStyle(color: Colors.red),
//               ),
//               SizedBox(width: 20),
//               Text('Pesticides'),
//               SizedBox(width: 20),
//               Text('Fertilizers'),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 210,
//               width: 280,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: const DecorationImage(
//                   image: AssetImage('assets/images/vermicompost.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Placeholder Info Screen
// // class InfoScreen extends StatelessWidget {
// //   const InfoScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Center(
// //       child: Text(
// //         'Info Screen',
// //         style: TextStyle(fontSize: 24),
// //       ),
// //     );
// //   }
// // }
import 'package:ecommerce_app/navigationScreens/cart_screen.dart';
import 'package:ecommerce_app/navigationScreens/profile_screen.dart';
import 'package:ecommerce_app/navigationScreens/settingScrren.dart';
import 'package:ecommerce_app/navigationScreens/wishlistScreen.dart';
import 'package:ecommerce_app/views/loginView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Logout method to clear preferences and navigate to LoginView
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Loginview(),
      ),
    );
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CategoriesScreen(),
    const Wishlistscreen(),
    const CartScreen(),
    const Settingscrren(),
    const ProfileScreen(),
  ];

  // through this tab changes
  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        elevation: 0,
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 20),
          Icon(Icons.wallet, color: Colors.black),
          SizedBox(width: 20),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.grey,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.purple,
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey,
            icon: Icon(Icons.info),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}

// Categories Screen Widget (Displays Categories of Products)
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text(
                'All',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(width: 20),
              Text('Pesticides'),
              SizedBox(width: 20),
              Text('Fertilizers'),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 210,
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/vermicompost.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 210,
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/potMix.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Wishlist Screen
// class Wishlistscreen extends StatelessWidget {
//   const Wishlistscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Wishlist Screen', style: TextStyle(fontSize: 24)),
//     );
//   }
// }

// // Placeholder for Cart Screen
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Cart Screen', style: TextStyle(fontSize: 24)),
//     );
//   }
// }

// // Placeholder for Settings Screen
// class Settingscrren extends StatelessWidget {
//   const Settingscrren({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Settings Screen', style: TextStyle(fontSize: 24)),
//     );
//   }
// }

// // Placeholder Info Screen
// class InfoScreen extends StatelessWidget {
//   const InfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Info Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }