import 'package:ecommerce_app/views/homepage.dart';
import 'package:ecommerce_app/views/smpt_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

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
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isSending = false;
  String? _generatedOtp;

  String generateOtp({int length = 6}) {
    final random = Random();
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  Future<void> _handleSendOtp() async {
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      _showSnackbar('Please enter a valid email address.');
      return;
    }

    _generatedOtp = generateOtp();
    print('Generated OTP: $_generatedOtp');

    setState(() => _isSending = true);

    try {
      await SendOtp().sendOtp(email, _generatedOtp!);
      _showSnackbar('OTP sent successfully to $email');
    }
    //  catch (e) {
    //   _showSnackbar('Failed to send OTP: $e');
    // }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        _showSnackbar('NO account found for this email');
      } else {
        _showSnackbar('Error: ${e.message}');
      }
    } finally {
      setState(() => _isSending = false);
    }
  }

  void _verifyOtp() {
    final enteredOtp = _otpController.text.trim();

    if (enteredOtp == _generatedOtp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else {
      _showSnackbar('Invalid OTP. Please try again.');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send OTP and Verify'),
        backgroundColor: Colors.lime,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your registered email address. We will send an OTP to reset your password.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter recipient email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSending ? null : _handleSendOtp,
                child: _isSending
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Send OTP'),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
