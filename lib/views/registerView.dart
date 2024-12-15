import 'package:ecommerce_app/views/loginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

// import 'package:mynotes/constant/routes.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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

  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.purple);
    // return const Placeholder(color: Colors.purple);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.lime,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: '  Enter your email address')),
          TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: '  Enter your password')),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);

                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  devtools.log('weak password');
                } else if (e.code == 'email-alreadi-in-use') {
                  devtools.log('email already in use');
                } else if (e.code == 'invalid-email') {
                  devtools.log('invalid email entered');
                }
              }
              {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Loginview()),
                );
              }
            },
            child: const Text('Register'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Loginview()),
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //   loginRoute,
                //   (_) => false,
                // );
              );
            },
            child: const Text('Already Register ? Login Here'),
          )
        ],
      ),
    );
  }
}


// import 'package:ecommerce_app/views/loginView.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;

// class Registerview extends StatefulWidget {
//   const Registerview({super.key});

//   @override
//   State<Registerview> createState() => _RegisterviewState();
// }

// class _RegisterviewState extends State<Registerview> {
//   late final TextEditingController _email;
//   late final TextEditingController _password;
//   @override
//   void initState() {
//     _email = TextEditingController();
//     _password = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register View'),
//         backgroundColor: Colors.lime,
//       ),
//       body: Column(
//         children: [
//           const TextField(
//             decoration: InputDecoration(hintText: '  Enter your email here !'),
//           ),
//           const TextField(
//             decoration: InputDecoration(hintText: '  Enter your password here'),
//           ),
//           TextButton(
//             onPressed: () async {
//               final email = _email.text;
//               final password = _password.text;
//               try {
//                 final userCredential = await FirebaseAuth.instance
//                     .createUserWithEmailAndPassword(
//                         email: email, password: password);

//                 devtools.log(userCredential.toString());
//               } on FirebaseAuthException catch (e) {
//                 if (e.code == 'weak-password') {
//                   devtools.log('weak password');
//                 } else if (e.code == 'email-alreadi-in-use') {
//                   devtools.log('email already in use');
//                 } else if (e.code == 'invalid-email') {
//                   devtools.log('invalid email entered');
//                 }
//               }
//             },
//             child: const Text('Register'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Loginview()),
//               );
//             },
//             child: const Text('Already Register'),
//           )
//         ],
//       ),
//     );
//   }
// }
