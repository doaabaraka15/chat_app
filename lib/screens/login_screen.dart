import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_app/utils/helper.dart';


import '../firebase/firebase_auth.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helper {
  late TextEditingController _email;

  late TextEditingController _password;
  bool isloading = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KprimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Image.asset('assets/images/scholar.png'),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'pacifico'),
            ),
            const Spacer(
              flex: 1,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _email,
              hint: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _password,
              hint: 'Password',
              isObscure: true,
            ),
            const SizedBox(height: 25),
            CustomElevatedButton(
              text: "LOGIN",
              onPressed: ()async {
                setState(() {
                  isloading = true ;
                });
                await performLogin();

              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/register_screen'),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xffc7ede6),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }


  Future<void> performLogin() async {
    if (checkData()) {
      await createAccount();
    }
  }

  bool checkData() {
    if (_email.text.isNotEmpty &&
        _password.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, error: true, content: 'Enter required date');
    return false;
  }

  Future<void> createAccount() async {
    bool status = await FBAuthController().signIn(context,
        email: _email.text, password: _password.text);
    if (status) Navigator.pushNamed(context, '/chat_screen');
  }
}
