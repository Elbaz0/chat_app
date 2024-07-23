import 'package:flutter/material.dart';

class Buttom extends StatelessWidget {
  Buttom({super.key, required this.text, this.ontap});
  String text;
  var ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(fontSize: 25),
          ),
        ),
        width: 400,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
      ),
    );
  }
}
