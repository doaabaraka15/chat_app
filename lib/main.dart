import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_app/screens/chat_screen.dart';
import 'package:scholar_app/screens/home_screen.dart';
import 'package:scholar_app/screens/login_screen.dart';
import 'package:scholar_app/screens/register_screen.dart';
import 'firebase_options.dart' as options;

import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(

  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login_screen',
      routes: {
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/chat_screen': (context) => const ChatScreen(),

      },
    );
  }
}
