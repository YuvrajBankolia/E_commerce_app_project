import 'package:flutter/material.dart';

class Settingscrren extends StatefulWidget {
  const Settingscrren({super.key});

  @override
  State<Settingscrren> createState() => _SettingscrrenState();
}

class _SettingscrrenState extends State<Settingscrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.lime,
      ),
    );
  }
}
