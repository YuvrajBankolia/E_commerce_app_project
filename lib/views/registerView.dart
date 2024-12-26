import 'package:ecommerce_app/views/loginView.dart';
import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final List<String> _options = ['Vendor', 'Customer'];
  List<String> _selectedOptions = [];

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _registerUser(String email, String password) async {
    try {
      final AuthResponse authResponse =
          await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user != null) {
        final profileResponse = await Supabase.instance.client
            .from('profile')
            .select()
            .eq('email', email)
            .maybeSingle();

        // if (profileResponse.error?.message != null && profileResponse.data?.message == null) {
        //   _showErrorDialog("This email is already registered in the profile.");
        //   return;
        // }

        final insertResponse =
            await Supabase.instance.client.from('profile').insert({
          'email': email,
          'role': _selectedOptions.isNotEmpty,
          //_selectedOptions.first : 'Customer',
        }).maybeSingle();

        // if (insertResponse.error != null) {
        //   _showErrorDialog(
        //       'Error inserting data into profile: ${insertResponse.error!.message}');
        //   return;
        // }

        // Navigate to login view on successful registration and profile insertion
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        _showErrorDialog(
            "An unknown error occurred during sign-up. Please try again.");
      }
    } on AuthException catch (e) {
      // Handle specific authentication errors
      if (e.message.contains("User already registered")) {
        _showErrorDialog(
            "This email is already registered. Please log in or try another email.");
      } else {
        _showErrorDialog("Authentication Error: ${e.message}");
      }
    } catch (e) {
      // Handle any other unexpected errors
      _showErrorDialog("An unexpected error occurred: $e");
    }
  }
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSingleSelectDialog() async {
    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? selectedOption =
            _selectedOptions.isNotEmpty ? _selectedOptions.first : null;

        return AlertDialog(
          title: const Text('Select Login Option'),
          content: SingleChildScrollView(
            child: Column(
              children: _options.map((option) {
                return RadioListTile<String>(
                  value: option,
                  groupValue: selectedOption,
                  title: Text(option),
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value;
                    });
                    Navigator.pop(
                        context, value); // Close dialog with selected value
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, null), // Dismiss without selecting
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedOptions = [result]; // Keep only the selected option
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.lime,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
              text: const TextSpan(
                  text:
                      'When you tap on the register button, we send an email verification to your entered email to verify.',
                  style: TextStyle(fontSize: 15, color: Colors.black87)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email address',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _showSingleSelectDialog,
              child: const Text('Select Login Options'),
            ),
            const SizedBox(height: 10),
            Text('Selected Options: ${_selectedOptions.join(", ")}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final email = _email.text.trim();
                final password = _password.text.trim();
                if (email.isEmpty ||
                    password.isEmpty ||
                    _selectedOptions.isEmpty) {
                  _showErrorDialog(
                      "Email, password, and login option cannot be empty.");
                  return;
                }
                _registerUser(email, password);
              },
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const Text('Already Registered? Login Here'),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:ecommerce_app/views/loginView.dart';
// import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;
// import 'package:supabase_flutter/supabase_flutter.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   late final TextEditingController _email;
//   late final TextEditingController _password;
//   // late final TextEditingController _selectedOptions;
//   final List<String> _options = ['Vendor', 'Customer'];
//   List<String> _selectedOptions = [];

//   @override
//   void initState() {
//     _email = TextEditingController();
//     _password = TextEditingController();
//     // _selectedOptions = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     // _selectedOptions.dispose();
//     super.dispose();
//   }

//   Future<void> _registerUser(String email, String password) async {
//     try {
//       // Attempt to sign up the user
//       final AuthResponse response = await Supabase.instance.client.auth.signUp(
//         email: email,
//         password: password,
//       );

//       // Check if the user was successfully registered
//       if (response.user != null) {
//         final insertResponse =
//             await Supabase.instance.client.from('profile').insert({
//           'email': email,
//           'role': _selectedOptions.isNotEmpty ? _selectedOptions.first : null,
//         });
//         // .execute();

//         // Handle data insertion response
//         if (insertResponse.error != null) {
//           _showErrorDialog(
//               'Error inserting data into profile: ${insertResponse.error!.message}');
//           return;
//         }

//         // Navigate to login view on success
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const LoginView()),
//         );
//       } else {
//         _showErrorDialog("An unknown error occurred. Please try again.");
//       }
//     } on AuthException catch (e) {
//       if (e.message.contains("User already registered")) {
//         _showErrorDialog(
//             "This email is already registered. Please log in or try another email.");
//       } else {
//         _showErrorDialog("Auth Error: ${e.message}");
//       }
//     }
    
//   }


//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Error"),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showSingleSelectDialog() async {
//     final String? result = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         String? selectedOption =
//             _selectedOptions.isNotEmpty ? _selectedOptions.first : null;

//         return AlertDialog(
//           title: const Text('Select Login Option'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: _options.map((option) {
//                 return RadioListTile<String>(
//                   value: option,
//                   groupValue: selectedOption,
//                   title: Text(option),
//                   onChanged: (String? value) {
//                     setState(() {
//                       selectedOption = value;
//                     });
//                     Navigator.pop(
//                         context, value); // Close dialog with selected value
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () =>
//                   Navigator.pop(context, null), // Dismiss without selecting
//               child: const Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );

//     if (result != null) {
//       setState(() {
//         _selectedOptions = [result]; // Keep only the selected option
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//         backgroundColor: Colors.lime,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             RichText(
//               text: const TextSpan(
//                   text:
//                       'when you tap on register button we send a email verfication on your entered email to verify ',
//                   style: TextStyle(fontSize: 15, color: Colors.black87)),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _email,
//               enableSuggestions: false,
//               autocorrect: false,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your email address',
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _password,
//               obscureText: true,
//               enableSuggestions: false,
//               autocorrect: false,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your password',
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _showSingleSelectDialog,
//               child: const Text('Select Login Options'),
//             ),
//             const SizedBox(height: 10),
//             Text('Selected Options: ${_selectedOptions.join(", ")}'),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final email = _email.text.trim();
//                 final password = _password.text.trim();
//                 if (email.isEmpty ||
//                     password.isEmpty ||
//                     _selectedOptions.isEmpty) {
//                   _showErrorDialog(
//                       "Email , password and Login option cannot be empty.");
//                   return;
//                 }
//                 _registerUser(email, password);
//               },
//               child: const Text('Register'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const LoginView()),
//                 );
//               },
//               child: const Text('Already Registered? Login Here'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
