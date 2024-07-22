import 'package:flutter/material.dart';

class text_from_field extends StatelessWidget {
  text_from_field(
      {super.key, required this.text, this.onchange, this.obobscure = false});
  String text;
  var onchange;
  bool obobscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      obscureText: obobscure,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Frild in requierd';
        }
      },
      onChanged: onchange,
      decoration: InputDecoration(
        hoverColor: Color.fromARGB(255, 255, 255, 255),
        hintText: '$text',
        hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
