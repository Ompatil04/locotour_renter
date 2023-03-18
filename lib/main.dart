import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cultural_renter/screens/dashboard.dart';
import 'package:home_cultural_renter/screens/login_screen.dart';
import 'package:home_cultural_renter/screens/profile_screen.dart';
import 'package:home_cultural_renter/screens/requests_screen.dart';
import 'package:home_cultural_renter/screens/upload_space_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. debug provider
  //   // 2. safety net provider
  //   // 3. play integrity provider
  //   androidProvider: AndroidProvider.debug,
  // );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomeRenterApp());
}

class HomeRenterApp extends StatefulWidget {
  const HomeRenterApp({super.key});

  @override
  State<HomeRenterApp> createState() => _HomeRenterAppState();
}

class _HomeRenterAppState extends State<HomeRenterApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/upload_space_screen': (context) => UploadSpaceScreen(),
        '/requests': (context) => const RequestScreen(),
        '/profile': (context) {
          return ProfileScreen(
            providers: [EmailAuthProvider()],
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
            ],
          );
        },
        '/sign-in': (context) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                // if (!state.user!.emailVerified) {
                //   Navigator.pushNamed(context, '/verify-email');
                // } else {
                //   Navigator.pushReplacementNamed(context, '/profile');
                // }
                Navigator.of(context).pushNamed('/dashboard');
              }),
            ],
          );
        },
      },
      home: Scaffold(
        body: Builder(builder: (context) {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Navigator.pushNamed(context, '/sign-in');
            },
          );
          return Container();
        }),
      ),
    );
  }
}
