import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/core/utils/widgets/custom_general_button.dart';
import '../../../login/presentation/widgets/customBottomAppBar.dart';
import '../../../login/presentation/widgets/custom_circle _avatar.dart';
import '../../../login/presentation/widgets/custom_text_field.dart';
import '../bloc/sign_up_bloc.dart';
import '../bloc/sign_up_event.dart';
import '../bloc/sign_up_state.dart';

class signViewBody extends StatelessWidget {
  signViewBody({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is SignUpFailure) {
            Navigator.of(context).pop(); // إغلاق الـ loading
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is SignUpSuccess) {
            Navigator.of(context).pop(); // إغلاق الـ loading
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account created successfully ✅")),
            );
            Navigator.pop(context); // يرجع على شاشة تسجيل الدخول
          }
        },
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xffdeb3ad),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 45),
                const CircleAvatar(
                  backgroundColor: Color(0xffdeb3ad),
                  radius: 132,
                  child: CustomCircleAvatar(),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  labelText: 'Name',
                  hintText: 'Please Enter Your Name',
                  controller: nameController,
                ),
                const SizedBox(height:10),

                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter Your Email',
                  controller: emailController,
                ),
                const SizedBox(height:10),

                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        ' Log in',
                        style: TextStyle(color: Color(0xffC7EDE6), fontSize: 18),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                customGeneralButton(
                  text: 'Register',
                  onTap: () {
                    BlocProvider.of<SignUpBloc>(context).add(
                      SignUpButtonPressed(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
