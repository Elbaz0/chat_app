import 'package:app_chat/widget/button.dart';
import 'package:app_chat/widget/snack_bar.dart';
import 'package:app_chat/widget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class register extends StatefulWidget {
  register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                        SizedBox(
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
                            ontap: () async {
                              if (formkey.currentState!.validate()) {
                                isloading = true;
                                setState(() {});
                                try {
                                  await register_method();
                                  snack_bar(context, 'sccess');
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    snack_bar(context,
                                        'The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                    snack_bar(context,
                                        'The account already exists for that email');
                                  }
                                } catch (e) {
                                  snack_bar(context, 'try agin');
                                }
                                isloading = false;
                                setState(() {});
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
    );
  }

  Future<void> register_method() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
