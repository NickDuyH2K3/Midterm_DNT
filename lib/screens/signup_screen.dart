import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:MIDTERM_CRUD/reuseable_widgets/reuseable_widget.dart';
import 'package:MIDTERM_CRUD/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5), // Changed background to match Sign In screen
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80, // Space at the top
              ),
              reusableTextField("Enter your username", Icons.person, false, _userTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter your email", Icons.email, false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter your password", Icons.lock, true, _passwordTextController),
              const SizedBox(
                height: 30,
              ),
              signInSignUpButton(context, false, () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
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
            ],
          ),
        ),
      ),
    );
  }
}
