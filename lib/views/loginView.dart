import 'package:ecommerce_app/views/forgot_password_view.dart';
import 'package:ecommerce_app/views/registerView.dart';
import 'package:ecommerce_app/utilities/show_error_dialogue.dart';
import 'package:ecommerce_app/views/send_OTP.dart';
import 'package:ecommerce_app/views/smpt_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart'; // Ensure Homepage is correctly implemented

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = _email.text.trim();
    final password = _password.text.trim();

    try {
      // Firebase login
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User signed in: ${userCredential.user?.email}');

      // Save login state in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);

      // Navigate to Homepage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      if (e.code == 'user-not-found') {
        await showErrorDialog(context, 'No user found for this email.');
      } else if (e.code == 'wrong-password') {
        await showErrorDialog(context, 'Incorrect password.');
      } else {
        await showErrorDialog(context, 'Error: ${e.code}');
      }
    } catch (e) {
      // Handle other errors
      await showErrorDialog(context, 'Error: ${e.toString()}');
    }
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status on app start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.lime,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email address',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyWidget()),
                );
              },
              child: const Text('Forgot your password?'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterView()),
                );
              },
              child: const Text('Not Registered Yet? Register Here!'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:ecommerce_app/views/registerView.dart';
// import 'package:ecommerce_app/views/show_error_dialogue.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'homepage.dart'; // Replace with your homepage file

// class Loginview extends StatefulWidget {
//   const Loginview({super.key});

//   @override
//   State<Loginview> createState() => _LoginviewState();
// }

// class _LoginviewState extends State<Loginview> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }

//   Future<void> _login() async {
//     final email = _email.text;
//     final password = _password.text;

//     try {
//       // Firebase login
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Save login state and email in SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('email', email);

//       // Navigate to Homepage
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const Homepage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         _showErrorDialog('User not found');
//       } else if (e.code == 'wrong-password') {
//         _showErrorDialog('Wrong password');
//       } else {
//         _showErrorDialog('Error: ${e.code}');
//       }
//     } catch (e) {
//       _showErrorDialog('Error: ${e.toString()}');
//     }
//   }

//   Future<void> _signIn() async {
//     final email = _email.text;
//     final password = _password.text;

//     try {
//       // Sign in the user
//       final userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       print('User signed in: ${userCredential.user?.email}');

//       // Navigate to Homepage
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => const Homepage(), // Ensure Homepage is defined
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       // Handle Firebase-specific errors
//       if (e.code == 'user-not-found') {
//         await showErrorDialog(context, 'No user found for this email.');
//       } else if (e.code == 'wrong-password') {
//         await showErrorDialog(context, 'Incorrect password.');
//       } else {
//         await showErrorDialog(context, 'Error: ${e.code}');
//       }
//     } catch (e) {
//       // Handle other errors
//       await showErrorDialog(context, 'Error: ${e.toString()}');
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {

//       },
//     );
//   }

//   Future<void> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     if (isLoggedIn) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const Homepage()),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus(); // Check login status on app start
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar: AppBar(
//             title: const Text('Login'),
//             backgroundColor: Colors.lime,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextField(
//                   controller: _email,
//                   enableSuggestions: false,
//                   autocorrect: false,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter your email address',
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   controller: _password,
//                   obscureText: true,
//                   enableSuggestions: false,
//                   autocorrect: false,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter your password',
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _signIn,
//                   child: const Text('Login'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const RegisterView(),
//                       ),
//                     );
//                   },
//                   child: const Text('Forgot your password?'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const RegisterView(),
//                       ),
//                     );
//                   },
//                   child: const Text('Not Registered Yet? Register Here!'),
//                 ),
//               ],
//             ),
//           ),
//         );
//   }
// }
