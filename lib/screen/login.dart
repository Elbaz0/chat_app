import 'package:app_chat/screen/register.dart';
import 'package:app_chat/widget/button.dart';
import 'package:app_chat/widget/snack_bar.dart';
import 'package:app_chat/widget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  bool isload = false;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isload,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Text(
                    'Welcome ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      text_from_field(
                          text: 'Email',
                          onchange: (data) {
                            email = data;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      text_from_field(
                        obobscure: true,
                        text: 'PassWord',
                        onchange: (data) {
                          password = data;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Button(
                          text: 'Sign In',
                          ontap: () async {
                            if (formkey.currentState!.validate()) {
                              isload = true;
                              setState(() {});
                              try {
                                await login_method();
                                snack_bar(context, 'sccess login');

                                Navigator.pushNamed(context, 'chat_screen',
                                    arguments: email);
                              } catch (e) {
                                snack_bar(context, 'try again');
                              }
                              isload = false;
                              setState(() {});
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
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
                      child: Text(
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
    );
  }

  Future<void> login_method() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
