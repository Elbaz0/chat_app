import 'package:app_chat/cubits/login_cubit/login_cubit.dart';
import 'package:app_chat/screen/register.dart';
import 'package:app_chat/widget/button.dart';
import 'package:app_chat/widget/snack_bar.dart';
import 'package:app_chat/widget/text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatelessWidget {
  String? email;
  bool isload = false;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isload = true;
        } else if (state is LoginSccess) {
          isload = false;
          snack_bar(context, 'Login sccess');
          Navigator.pushNamed(context, 'chat_screen', arguments: email);
        } else if (state is LoginField) {
          snack_bar(context, state.msg_erorre);
          isload = false;
        }
      },
      builder: (context, State) => ModalProgressHUD(
        inAsyncCall: isload,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(),
            child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.always,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Center(
                    child: Text(
                      'Welcome ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        text_from_field(
                            text: 'Email',
                            onchange: (data) {
                              email = data;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        text_from_field(
                          obobscure: true,
                          text: 'PassWord',
                          onchange: (data) {
                            password = data;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Button(
                            text: 'Sign In',
                            ontap: () {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context)
                                    .login_method(
                                        email: email, password: password);
                              } else {}
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'do not have an acc  ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return register();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          backgroundColor: Color(0xff274460),
        ),
      ),
    );
  }
}
