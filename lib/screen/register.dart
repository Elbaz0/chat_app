import 'package:app_chat/cubits/register_cubit/register_cubit.dart';
import 'package:app_chat/widget/button.dart';
import 'package:app_chat/widget/snack_bar.dart';
import 'package:app_chat/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class register extends StatelessWidget {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is registerLoading) {
          isloading = true;
        } else if (state is registerSccess) {
          isloading = false;
          snack_bar(context, 'Register sccess');
          Navigator.pop(context);
        } else if (state is registerField) {
          isloading = false;
          snack_bar(context, state.msg_erorre);
        }
      },
      builder: (context, State) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const Center(
                      child: Text(
                        'Register ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 170,
                          ),
                          const Text(
                            'Register',
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
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          text_from_field(
                            text: 'PassWord',
                            onchange: (data) {
                              password = data;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Button(
                              text: 'register',
                              ontap: () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .register_method(
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
                          ' have an acc  ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 240, 237, 239),
                              fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login ',
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
      ),
    );
  }

  // Future<void> register_method() async {
  //   UserCredential userCredential = await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email!, password: password!);
  // }
}
