import 'package:app_chat/cubits/login_cubit/login_cubit.dart';
import 'package:app_chat/screen/chat.dart';
import 'package:app_chat/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Myapp());
}

var keycolor = Color(0xff274460);

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        routes: {
          'chat_screen': (context) => chat(),
        },
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
