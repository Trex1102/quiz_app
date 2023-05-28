import 'package:flutter/material.dart';

class QuizAppIntroPage extends StatelessWidget {
  const QuizAppIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to QuizApp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Image.asset(
              'assets/images/quiz_icon.png',
              width: 150.0,
              height: 150.0,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the quiz page
                Navigator.pushReplacementNamed(context, '/quiz');
              },
              child: const Text(
                'Start Quiz',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
