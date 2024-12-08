// ignore_for_file: prefer_const_constructors

import 'package:chat_app/view/screens/register_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  "Login",
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
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              title: 'Login',
              onTap: () {},
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an accont?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Parkinsans",
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ));
                  },
                  child: Text(
                    "Sign Up",
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
