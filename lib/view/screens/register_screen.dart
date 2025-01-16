// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/view/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../method/method_app.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    super.key,
    this.email,
    this.password,
  });

  String? email;
  String? password;
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                  settings: RouteSettings(
                    arguments: email,
                  )));
          isLoading = false;
          showSnakBar(
              context: context,
              message: state.successMessage,
              color: state.color);
        } else if (state is RegisterFailure) {
          showSnakBar(
              context: context,
              message: state.errorMessage,
              color: state.color);
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                    CustomFormTextField(
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      hintText: 'Email :',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    CustomFormTextField(
                        isPassword: true,
                        hintText: 'Password :',
                        onChanged: (data) {
                          password = data;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formstate.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .registerUser(email: email!, password: password!);
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
            ),
          ),
        );
      },
    );
  }
}
