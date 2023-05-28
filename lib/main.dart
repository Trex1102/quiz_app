import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/quiz_app_intro_page.dart';
import 'package:quiz_app/quiz_page.dart';
import 'package:quiz_app/result_page.dart';
import 'package:quiz_app/score_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ScoreProvider(),
      child: const QuizApp(),
    ),
  );
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const QuizAppIntroPage(),
        '/quiz': (context) => const QuizPage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}
