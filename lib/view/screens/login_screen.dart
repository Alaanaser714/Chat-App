// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/method/method_app.dart';
import 'package:chat_app/view/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  String? emailLogin;
  String? passwordLogin;
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                    settings: RouteSettings(
                      arguments: emailLogin,
                    )));
            isLoading = false;
            showSnakBar(
                context: context,
                message: state.successMessage,
                color: state.color);
          } else if (state is LoginFailure) {
            showSnakBar(
                context: context,
                message: state.errorMessage,
                color: state.color);
            isLoading = false;
          }
        },
        builder: (context, state) => ModalProgressHUD(
              inAsyncCall: state is LoginLoading,
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
                              BlocProvider.of<LoginCubit>(context).loginUser(
                                  emailLogin: emailLogin!,
                                  passwordLogin: passwordLogin!);
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
            ));
  }
}
