import 'package:ecommerce_app/views/loginView.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
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
      // Supabase signup
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // User successfully registered
        devtools.log("User registered: ${response.user!.email}");

        // Navigate to login view
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        // Unexpected response
        _showErrorDialog("An unknown error occurred. Please try again.");
      }
    } catch (e) {
      // Handle unexpected errors
      devtools.log("Error: $e");
      _showErrorDialog("An unexpected error occurred. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
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
                      'when you tap on register we send a email verfication on your entered email to verify ',
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
                if (email.isEmpty || password.isEmpty) {
                  _showErrorDialog("Email and password cannot be empty.");
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
