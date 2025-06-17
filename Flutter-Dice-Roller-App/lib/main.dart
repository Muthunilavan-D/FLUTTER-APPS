import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 29, 0, 59),
          Color.fromARGB(255, 65, 0, 122),
        ),
      ),
    ),
  );
}
