import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;
  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.start,
            'Created by:\nMuthunilavan D',
            style: GoogleFonts.playfairDisplay(
                color: Colors.pinkAccent,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 250,
            color: const Color.fromARGB(248, 135, 207, 235),
          ),
          const SizedBox(height: 40),
          const Text(
            'Learn flutter the fun way!',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 135, 206, 235)),
            onPressed: startQuiz,
            icon: const Icon(Icons.arrow_right_alt_outlined),
            label: const Text(
              "Start!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
