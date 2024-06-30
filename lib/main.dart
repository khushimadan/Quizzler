import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctans = quizBrain.correctAns();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
                context: context,
                title: "FINISHED!",
                desc: "You've reached the end of the quiz.")
            .show();
        scorekeeper = [];
        quizBrain.reset();
      } else {
        if (correctans == userPickedAnswer) {
          scorekeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scorekeeper.add(
            const Icon(Icons.close, color: Colors.red),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () {
                  checkAnswer(true);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'True',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () {
                  checkAnswer(false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Row(children: scorekeeper)
        ]);
  }
}
