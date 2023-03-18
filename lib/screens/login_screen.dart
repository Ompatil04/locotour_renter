import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _phoneEdtTxtController = TextEditingController();
//   final _otpEdtTxtController = TextEditingController();

//   String? _numberError;
//   String? _otpError;
//   final _phoneRegEx = RegExp('\\d{10}');
//   bool _isValidNum = false;
//   void _sendOtp(String text) {
//     if (_phoneRegEx.hasMatch(text)) {
//       setState(() {
//         _isValidNum = true;
//         _numberError = null;
//       });
//     } else {
//       setState(() {
//         _numberError = "Invalid Number";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Authentication"),
//       ),
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.all(12),
//           padding: const EdgeInsets.all(8.0),
//           child: AnimatedSwitcher(
//             duration: const Duration(seconds: 1),
//             child: !_isValidNum
//                 ? TextField(
//                     controller: _phoneEdtTxtController,
//                     onSubmitted: _sendOtp,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                         errorText: _numberError, label: Text("Phone")),
//                   )
//                 : TextField(
//                     controller: _otpEdtTxtController,
//                     onSubmitted: _checkOtp,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(errorText: _otpError),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _checkOtp(String value) async {
//     //TODO:Check Otp
//     Navigator.of(context).pushNamed('/dashboard');
//   }
// }

class MyLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FirebaseUIActions(
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  if (!state.user!.emailVerified) {
                    Navigator.pushNamed(context, '/verify-email');
                  } else {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }
                }),
              ],
              child: LoginView(
                action: AuthAction.signUp,
                providers: FirebaseUIAuth.providersFor(
                  FirebaseAuth.instance.app,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
