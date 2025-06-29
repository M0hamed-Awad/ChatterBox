import 'package:bloc/bloc.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await AuthService().loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(
        AuthService().loginExceptionsHandling(exception: e),
      ));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
