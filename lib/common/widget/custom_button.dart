import 'package:flutter/material.dart';

class CustomButtton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButtton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}
