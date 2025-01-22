import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {required this.answerText, required this.onTap, super.key});
  final String answerText;
  final void Function() onTap;
  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
        backgroundColor: const Color.fromARGB(255, 135, 206, 235),
        foregroundColor: Colors.black,
      ),
      child: Text(
        answerText,
        style: GoogleFonts.robotoCondensed(
            color: const Color.fromARGB(255, 0, 0, 0), fontSize: 11.5),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// class AnswerButton extends StatefulWidget {
//   const AnswerButton(this.text, {super.key});
//   final String text;

//   @override
//   State<AnswerButton> createState() {
//     // ignore: no_logic_in_create_state
//     return _AnswerButtonState(text);
//   }
// }

// class _AnswerButtonState extends State<AnswerButton> {
//   _AnswerButtonState(this.text);
//   final String text;
//   @override
//   Widget build(context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(255, 135, 206, 235),
//         foregroundColor: Colors.black,
//       ),
//       child: Text(text),
//     );
//   }
// }
