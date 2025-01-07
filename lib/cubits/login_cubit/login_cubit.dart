// ignore_for_file: unused_local_variable, unused_catch_clause, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String emailLogin, required String passwordLogin}) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailLogin,
        password: passwordLogin,
      );
      emit(LoginSuccess(color: Colors.green));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user-not-found', color: Colors.red));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong-password', color: Colors.red));
      }
    } catch (e) {
      emit(LoginFailure(
          errorMessage: 'something went wrong', color: Colors.red));
    }
  }
}
