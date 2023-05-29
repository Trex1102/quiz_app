import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/generate_options.dart';
import 'package:quiz_app/score_provider.dart';
import 'package:quiz_app/generate_question.dart';
import 'package:quiz_app/result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Timer _globalTimer;
  late Timer _timer;
  late String _question;
  late double _correctAnswer;
  late int _countdown;
  late double _globalCountDown;
  final double _globalTimerCount = 120;
  late List<String> options;
  int life = 3;

  @override
  void initState() {
    super.initState();
    generateQuestion();
    _countdown = 5;
    _globalCountDown = 120; // Adjust the global countdown time as needed
    startTimer();
    startGlobalTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _globalTimer.cancel();
    super.dispose();
  }

  void startGlobalTimer() {
    _globalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_globalCountDown > 0) {
          _globalCountDown--;
        } else {
          _globalTimer.cancel();
          navigateToResultPage(); // Navigate to the result page
        }
      });
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          resetTimer();
        }
      });
    });
  }

  void resetTimer() {
    _countdown = 5;
    generateQuestion();
  }

  void navigateToResultPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ResultPage(), // Replace ResultPage() with your actual result page
      ),
    );
  }

  void generateQuestion() {
    _question = GenerateQuestion.generateMediumQuestions();
    _correctAnswer = GenerateQuestion.answer(_question);
    options = GenerateOptions.generateOptions(_correctAnswer);
  }

  void answerQuestion(double answer) {
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    if (answer == _correctAnswer) {
      scoreProvider.incrementScore();
      resetTimer();
    } else {
      life--;
      resetTimer();
    }

    if (life == 0) {
      _globalTimer.cancel();
      navigateToResultPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: 220.0,
                    child: FAProgressBar(
                      currentValue: _globalCountDown,
                      maxValue: _globalTimerCount,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Life Remaining: $life',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              '$_countdown',
              style: const TextStyle(
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 120.0),

            Text(
              ' $_question',
              style: const TextStyle(
                fontSize: 34.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(double.parse(options[0]));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40.0),
                  ),
                  child: Text(options[0]),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(double.parse(options[1]));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40.0),
                  ),
                  child: Text(options[1]),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(double.parse(options[2]));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40.0),
                  ),
                  child: Text(options[2]),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(double.parse(options[3]));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40.0),
                  ),
                  child: Text(options[3]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
