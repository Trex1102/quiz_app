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
  late List<String> options;
  int life = 3;

  @override
  void initState() {
    super.initState();
    generateQuestion();
    _countdown = 5;
    _globalCountDown = 20; // Adjust the global countdown time as needed
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
        builder: (context) => ResultPage(), // Replace ResultPage() with your actual result page
      ),
    );
  }

  void generateQuestion() {
    _question = GenerateQuestion.generate();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  'Total Time Remaining:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                FAProgressBar(
                  currentValue: _globalCountDown,
                  maxValue: 20,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.amber,
                ),
              ],
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
              'Time Remaining: $_countdown',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Question: $_question',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
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
                SizedBox(width: 16.0),
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
            SizedBox(height: 16.0),
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
                SizedBox(width: 16.0),
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
