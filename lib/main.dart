import 'package:ecommerce_app/views/loginView.dart';
import 'package:ecommerce_app/views/productListedTo_SB.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://nfgveiyfvzjjkbzwkawq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5mZ3ZlaXlmdnpqamtiendrYXdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQxNTc1ODUsImV4cCI6MjA0OTczMzU4NX0.rMWOwFvyNOwS8F45bcf1zz3G7gx65mq03zGhnnxvUy4', // Replace with your Supabase anon key
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
/*

import 'package:ecommerce_app/main.dart';
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
  String? _errorMessage;

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
      // Check if the email is already registered
      final response = await supabase
          .from('profile')
          .select('email')
          .eq('email', email)
          .maybeSingle(); // Use maybeSingle to return null if no match is found

      if (response == null) {
        // No match found, proceed with registration
        final result = await supabase.auth.signUp(
          email: email,
          password: password,
        );

        if (result.error != null) {
          setState(() {
            _errorMessage = result.error!.message;
          });
        } else if (result.user != null) {
          // Successful registration
          setState(() {
            _errorMessage = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
        } else {
          setState(() {
            _errorMessage = result.error?.message ?? 'Registration failed.';
          });
        }
      } else {
        // Email is already registered
        setState(() {
          _errorMessage = "This email is already registered.";
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
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
                    Navigator.pop(context, value);
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedOptions = [result];
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
                if (_errorMessage != null) {
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  );
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

extension on AuthResponse {
  get error => null;
}

 */