import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/core/utils/widgets/custom_general_button.dart';
import 'package:ocassio_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:ocassio_app/features/login/presentation/bloc/login_event.dart';
import 'package:ocassio_app/features/login/presentation/bloc/login_state.dart';

import 'package:ocassio_app/features/product_details/presentation/views/product_view.dart';
import 'package:ocassio_app/features/sign_up/presentation/views/sign_up_view.dart';

import '../../../../core/utils/constsnts.dart';
import '../../../categories/presentation/views/categories_view.dart';
import 'customBottomAppBar.dart';
import 'custom_circle _avatar.dart';
import 'custom_text_field.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
              );
            } else if (state is LoginFailure) {
              Navigator.of(context).pop(); // لإغلاق الـ loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is LoginSuccess) {
              Navigator.of(context).pop(); // لإغلاق الـ loading dialog
              Navigator.pushNamed(context, CategoriesView.id);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              color: kcolor,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      backgroundColor: kcolor,
                      radius: 132,
                      child: CustomCircleAvatar(),
                    ),
                    SizedBox(height: 80),
                    CustomTextField(
                        labelText: 'Email',
                        hintText: 'please Enter Your Email',
                        controller:emailController
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        labelText: 'Password',
                        hintText: 'Please Enter Your Paasswod',
                        controller:passwordController,
                      isPassword: true,

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don\'t have an account?',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, signView.id);
                            },
                            child: Text(
                              ' Register',
                              style: TextStyle(
                                  color: Color(0xffC7EDE6), fontSize: 18),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    customGeneralButton(
                      text: 'login',
                      onTap: () {
                        BlocProvider.of<LoginBloc>(context).add(
                            LogginButtonPressed(
                                Email: emailController.text,
                                Password: passwordController.text));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
