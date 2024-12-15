// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();

//   bool isOtpSent = false; // To toggle between sending OTP and verifying OTP

//   /// Function to send OTP to the user's email
//   Future<void> sendOtp() async {
//     try {
//       final HttpsCallable callable =
//           FirebaseFunctions.instance.httpsCallable('sendOtpEmail');
//       final response =
//           await callable.call({'email': emailController.text.trim()});

//       if (response.data['success']) {
//         setState(() {
//           isOtpSent = true;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('OTP sent to your email!')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   /// Function to verify the OTP entered by the user
//   Future<void> verifyOtp() async {
//     try {
//       final email = emailController.text.trim();
//       final doc =
//           await FirebaseFirestore.instance.collection('otps').doc(email).get();

//       if (doc.exists) {
//         final storedOtp = doc['otp'];
//         final expiresAt = (doc['expiresAt'] as Timestamp).toDate();

//         if (DateTime.now().isBefore(expiresAt) &&
//             otpController.text.trim() == storedOtp.toString()) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('OTP verified successfully!')),
//           );
//           // Proceed to reset password or other action
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Invalid or expired OTP')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No OTP found for this email')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Forgot Password')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Registered Email',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 20),
//             if (!isOtpSent) ...[
//               ElevatedButton(
//                 onPressed: sendOtp,
//                 child: const Text('Send OTP'),
//               ),
//             ] else ...[
//               TextField(
//                 controller: otpController,
//                 decoration: const InputDecoration(
//                   labelText: 'Enter OTP',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: verifyOtp,
//                 child: const Text('Verify OTP'),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:ecommerce_app/views/smpt_config.dart';
// import 'package:e/commerce_app/views/verify_Otp.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
// import 'package:email_otp/email_otp.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    // Initialize the EmailAuth instance
    emailAuth = EmailAuth(sessionName: "OTP Verification");
  }

  /// Sends OTP to the provided email
  void sendOtpToEmail() async {
    try {
      bool result = await emailAuth.sendOtp(
        recipientMail: _emailController.text.trim(),
      );

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP sent to your email!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP. Please try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    }
  }

  /// Verifies the entered OTP
  void verifyOtp() {
    bool isValid = emailAuth.validateOtp(
      recipientMail: _emailController.text.trim(),
      userOtp: _otpController.text.trim(),
    );

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP verified successfully!")),
      );
      // Navigate to next page or reset password screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.lime,
      ),
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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_emailController.text.isNotEmpty) {
                  sendOtpToEmail();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your email address")),
                  );
                }
              },
              child: const Text('Send OTP'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_otpController.text.isNotEmpty) {
                  verifyOtp();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter the OTP")),
                  );
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
// // // import 'package:ecommerce_app/views/verify_Otp.dart';
// // // import 'package:flutter/material.dart';

// // // class ForgotPasswordView extends StatefulWidget {
// // //   const ForgotPasswordView({super.key});

// // //   @override
// // //   State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
// // // }

// // // class _ForgotPasswordViewState extends State<ForgotPasswordView> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.lime,
// // //         title: Text('Forgot Password'),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Padding(
// // //             padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
// // //             child: Container(
// // //               height: 60,
// // //               child: RichText(
// // //                 text: const TextSpan(
// // //                   text:
// // //                       'You can retrive your data by verifying your registered mail ',
// // //                   style: TextStyle(
// // //                     color: Colors.black,
// // //                     fontSize: 15.5,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           const TextField(
// // //             // controller: _password,
// // //             // obscureText: true,
// // //             // enableSuggestions: false,
// // //             // autocorrect: false,
// // //             decoration: InputDecoration(
// // //               hintText: 'Enter your registered Email',
// // //             ),
// // //           ),
// // //           ElevatedButton(
// // //             onPressed: () {
// // //               // MaterialPageRoute(builder: (context) => const VerifyOtp());
// // //             },
// // //             child: Text('Verify'),
// // //           ),
// // //           // Padding(
// // //           //   padding: EdgeInsets.all(16),
// // //           //   child: Container(
// // //           //     height: 80,
// // //           //     width: 400,
// // //           //     decoration: BoxDecoration(
// // //           //       // color: Colors.white, // Background color of the box
// // //           //       border: Border.all(
// // //           //         color: Colors.black, // Border color
// // //           //         width: 2.0,
// // //           //       ),
// // //           //       borderRadius: BorderRadius.circular(15.0),
// // //           //     ),
// // //           //     child: Text(''),
// // //           //   ),
// // //           // ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:ecommerce_app/views/verify_Otp.dart';
// // import 'package:email_auth/email_auth.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:email_auth/email_auth.dart';

// // class ForgotPasswordView extends StatelessWidget {
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _otpController = TextEditingController();
// //   import 'package:email_auth/email_auth.dart';

// // void sendOtpToEmail() async {
// //   try {
// //     // Set session name
// //     EmailAuth.sessionName = "OTP Verification";

// //     // Attempt to send the OTP
// //     var res = await EmailAuth.sendOtp(receiverMail: _emailController.text.trim());

// //     // Handle the response
// //     if (res) {
// //       print("OTP sent successfully!");
// //       // Add further logic, e.g., navigate to the OTP verification page
// //     } else {
// //       print("Failed to send OTP. Please try again.");
// //     }
// //   } catch (e) {
// //     print("Error occurred: $e");
// //   }
// // }

// //   void VerifyOtp(){

// //     // EmailAuth.sessionName = "Otp verify ";
// //      EmailAuth.validate(receiveMail : _emailController.text , userOTP: _otpController);
// //    if (!_emailController.text.contains('@')) {
// //   print("Invalid email address");
// //   return;
// // }

// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Forgot Password'),
// //         backgroundColor: Colors.lime,
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'Enter your registered email address. We will send an OTP to login your account.',
// //               style: TextStyle(fontSize: 16.0),
// //             ),
// //             const SizedBox(height: 20.0),
// //             TextField(
// //               controller: _emailController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Email Address',
// //                 border: OutlineInputBorder(),
// //               ),
// //               keyboardType: TextInputType.emailAddress,
// //             ),
// //             const SizedBox(height: 20.0),
// //             TextField(
// //               controller: _otpController,
// //               decoration: const InputDecoration(
// //                 labelText: 'OTP',
// //                 border: OutlineInputBorder(),
// //               ),
// //               keyboardType: TextInputType.number,
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 String email = _emailController.text.trim();
// //                 if (email.isNotEmpty) {
// //                   sendOtpToEmail();
// //                 }
// //               },
// //               child: const Text('Send OTP'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // void sendOtpToEmail(String email) {
// //   //   print('OTP sent to $email');
// //   // }
// // }