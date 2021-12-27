import 'package:TODO/ui/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key,
  required this.label,
  required this.func}) : super(key: key);
  final String label;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func();
      },
      child: Container(
        height: 45,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
        color: primaryClr),
        child: Text(label,style: const TextStyle(color: Colors.white,
        ),textAlign: TextAlign.center,),
      ),
    );
  }
}
