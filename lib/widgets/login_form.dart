import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/cubits/login_cubit/login_cubit.dart';
import 'package:chatter_box_app/helper/custom_snack_bar.dart';
import 'package:chatter_box_app/helper/utils.dart';
import 'package:chatter_box_app/views/home_view.dart';
import 'package:chatter_box_app/widgets/custom_button.dart';
import 'package:chatter_box_app/widgets/custom_loading_indicator.dart';
import 'package:chatter_box_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showCustomSnackBar(context,
              snackBarMessage: state.errorMessage, status: CodeStatus.Failure);
        } else if (state is LoginSuccess) {
          Navigator.popAndPushNamed(context, HomeView.id);
        }
      },
      builder: (context, state) {
        return Form(
          key: _loginFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _emailController,
                hintText: "Email",
                validator: validateEmail,
                isEnabled: state is LoginLoading ? false : true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Password field can't be empty.";
                  } else {
                    return null;
                  }
                },
                isEnabled: state is LoginLoading ? false : true,
              ),
              // TODO
              // Forget Password Functionally
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 8),
                child: const Text(
                  "Forget Password?",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: kSubTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                onTap: () async {
                  await _submitForm(context);
                },
                title: _textButtonTitle(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _textButtonTitle(LoginState state) {
    return state is LoginLoading
        ? const CustomLoadingIndicator(
            indicatorColor: Colors.white,
          )
        : Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          );
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_loginFormKey.currentState?.validate() ?? false) {
      BlocProvider.of<LoginCubit>(context).login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}
