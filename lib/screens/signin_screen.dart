import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:MIDTERM_CRUD/reuseable_widgets/reuseable_widget.dart';
import 'package:MIDTERM_CRUD/screens/home_screen.dart';
import 'package:MIDTERM_CRUD/screens/signup_screen.dart';  // Updated typo from "singup_screen"

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5), // Changed the background color to a lighter tone
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80, // Space at the top
              ),
              reusableTextField("Enter your email", Icons.email, false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter your password", Icons.lock, true, _passwordTextController),
              const SizedBox(
                height: 30,
              ),
              signInSignUpButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
              const SizedBox(
                height: 15,
              ),
              signUpOption(),
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.black87),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
                color: Color(0xFF0D47A1), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
