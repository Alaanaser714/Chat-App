// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:chat_app/method/method_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    super.key,
    this.email,
    this.password,
  });

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/iamges/WhatsApp-IOS-Android-logo.webp",
              height: 100,
              width: 100,
            ),
            const Text(
              "Chat App",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: "Parkinsans",
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            const Row(
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Parkinsans",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            CustomTextField(
              hintText: 'Email :',
              suffixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              onChanged: (data) {
                email = data;
              },
            ),
            CustomTextField(
                hintText: 'Password :',
                suffixIcon: IconButton(
                  onPressed: () {},
                  color: Colors.white,
                  icon: Icon(
                    Icons.visibility,
                  ),
                ),
                onChanged: (data) {
                  password = data;
                }),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onTap: () async {
                if (email != null && password != null) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );

                    MethodApp.showSnakBar(
                      context: context,
                      message:
                          "Account created successfully for ${credential.user?.email}!",
                      backgroundColor: Colors.green,
                    );
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = '';
                    if (e.code == 'weak-password') {
                      errorMessage = 'The password provided is too weak.';
                    } else if (e.code == 'email-already-in-use') {
                      errorMessage =
                          'The account already exists for that email.';
                    } else {
                      errorMessage = e.message ?? 'An unknown error occurred.';
                    }

                    MethodApp.showSnakBar(
                      context: context,
                      message: errorMessage,
                      backgroundColor: Colors.red,
                    );
                  }
                } else {
                  MethodApp.showSnakBar(
                    context: context,
                    message: "Please enter both email and password!!",
                    backgroundColor: Colors.grey,
                  );
                }
              },
              title: "Sign Up",
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an accont?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Parkinsans",
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Parkinsans",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
