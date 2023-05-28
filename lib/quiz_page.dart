import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/generate_options.dart';
import 'package:quiz_app/score_provider.dart';
import 'package:quiz_app/generate_question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Timer _timer;
  late String _question;
  late double _correctAnswer;

  int _seconds = 5;
  int _tempseconds = 0;
  bool _isRunning = false;


  late List<String> options;

  @override
  void initState() {
    super.initState();
    generateQuestion();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void generateQuestion() {
    _question = GenerateQuestion.generate();
    _correctAnswer = GenerateQuestion.answer(_question);
    options = GenerateOptions.generateOptions(_correctAnswer);
  }

  void startTimer() {
    if(!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          _seconds--;
        });
        if (_seconds <= 0) {
          generateQuestion();
          resetTimer();
        }
      });
    }
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 5;
      _tempseconds = 5;
      _isRunning = true;
    });
  }

  String getTimerText() {

    if(!_isRunning){
      _seconds = _tempseconds;
    }
    int seconds = _seconds % 60;
    return seconds.toString();
  }


  void answerQuestion(double answer) {
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    if (answer == _correctAnswer) {
      scoreProvider.incrementScore();
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
            Text(
              'Question: $_question',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),

            // Center(
            //   child: Text(
            //     getTimerText(),
            //   ),
            // ),

            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(options[0] as double);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40.0),
                  ),
                  child: Text(options[0]),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(options[1] as double);
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
                    answerQuestion(options[2] as double);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40.0),
                  ),
                  child: Text(options[2]),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(options[3] as double);
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
