// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'package:chat_app/method/method_app.dart';
import 'package:chat_app/view/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? emailLogin;
  String? passwordLogin;
  GlobalKey<FormState> formstate = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formstate,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset(
                  "assets/iamges/WhatsApp-IOS-Android-logo.webp",
                  height: 100,
                  width: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Chat App",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Parkinsans",
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                CustomFormTextField(
                  suffixIcon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  onChanged: (data) {
                    emailLogin = data;
                  },
                  hintText: 'Email :',
                ),
                CustomFormTextField(
                  isPassword: true,
                  onChanged: (data) {
                    passwordLogin = data;
                  },
                  hintText: 'Password :',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onTap: () async {
                    if (formstate.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailLogin!,
                          password: passwordLogin!,
                        );
                        MethodApp.showSnakBar(
                          context: context,
                          message: "Welcome! ${credential.user!.email}",
                          backgroundColor: Colors.green,
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(
                                  arguments: emailLogin,
                                ),
                                builder: (context) => ChatScreen()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          MethodApp.showSnakBar(
                            context: context,
                            message:
                                "This email is not registered. Please sign up first.",
                            backgroundColor: Colors.red,
                          );
                        } else {
                          MethodApp.showSnakBar(
                            context: context,
                            message: "An error occurred: ${e.message}",
                            backgroundColor: Colors.redAccent,
                          );
                        }
                      } catch (e) {
                        MethodApp.showSnakBar(
                          context: context,
                          message:
                              "Something went wrong. Please try again later.",
                          backgroundColor: Colors.redAccent,
                        );
                      }
                      {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else {
                      MethodApp.showSnakBar(
                        context: context,
                        message:
                            "Please fill in both email and password fields.",
                        backgroundColor: Colors.redAccent,
                      );
                    }
                  },
                  title: 'Login',
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
        ),
      ),
    );
  }
}
