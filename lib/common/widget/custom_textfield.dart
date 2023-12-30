import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField({required this.controller, required this.hintText,  this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        decoration:  InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (val){
          if(val == null || val.isEmpty){
            return 'Enter your $hintText';
          }
          return null;
        },
      ),
    );
  }
}
