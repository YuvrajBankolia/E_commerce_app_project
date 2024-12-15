// import 'dart:async';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> attachments = [];

  sendEmail(String subject, String body, String recientemail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recientemail],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController email = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Plugin example app'),
          actions: <Widget>[
            // IconButton(
            //   onPressed: send,
            //   icon: Icon(Icons.send),
            // )
          ],
        ),
        // body:
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your registered email address. We will send an OTP to reset your password.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: subject,
                decoration: InputDecoration(
                  labelText: 'subject',
                  border: OutlineInputBorder(),
                ),
                // keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: body,
                decoration: const InputDecoration(
                  labelText: 'body',
                  border: OutlineInputBorder(),
                ),
                // keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // _scaffoldKey.currentState!.save();
                  print('${email.text}');
                  sendEmail(subject.text, body.text, email.text);
                },
                child: Text('Send Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
