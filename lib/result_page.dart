import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/score_provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreProvider = Provider.of<ScoreProvider>(context);
    final int score = scoreProvider.score;
    const int totalQuestions = 5; // Replace with your actual total number of questions

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz Complete!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Your Score: $score / $totalQuestions',
              style:const  TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Reset the score and navigate back to the quiz page
                scoreProvider.resetScore();
                Navigator.pop(context);
              },
              child: const Text('Retry Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
