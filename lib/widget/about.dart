import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Expression Evaluator',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'This app allows you to evaluate mathematical expressions.',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Text(
            "Rules for valid expressions:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "• Only numbers, +, -, *, /, (, ^, ) and spaces are allowed.",
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: 5),
          Text(
            "• Expressions must be mathematically valid (e.g. 2 + 3 * (4 - 1)).",
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: 5),
          Text(
            "• No letters or special symbols (except +, -, *, /, (, )).",
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: 5),
          Text(
            "• Spaces are optional and ignored.",
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
