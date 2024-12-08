// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:chat_app/method/method_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    super.key,
    this.email,
    this.password,
  });

  String? email;
  String? password;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formstate = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.blue,
      blur: 5,
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
                    widget.email = data;
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
                      widget.password = data;
                    }),
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
                            .createUserWithEmailAndPassword(
                          email: widget.email!,
                          password: widget.password!,
                        );
                        Navigator.pop(context);
                        MethodApp.showSnakBar(
                          context: context,
                          message:
                              "Account created successfully for ${credential.user?.email}!",
                          backgroundColor: Colors.green,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          MethodApp.showSnakBar(
                            context: context,
                            message: "The password provided is too weak.",
                            backgroundColor: Colors.red,
                          );
                        } else if (e.code == 'email-already-in-use') {
                          MethodApp.showSnakBar(
                            context: context,
                            message:
                                "The account already exists for that email.",
                            backgroundColor: Colors.red,
                          );
                        } else {
                          'An unknown error occurred.';
                        }
                      } catch (e) {
                        MethodApp.showSnakBar(
                          context: context,
                          message: "There was an error",
                          backgroundColor: Colors.redAccent,
                        );
                      }
                    } else {
                      MethodApp.showSnakBar(
                        context: context,
                        message: "Please enter both email and password!!",
                        backgroundColor: Colors.grey,
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
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
        ),
      ),
    );
  }
}
