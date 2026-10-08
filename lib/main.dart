import 'package:flutter/material.dart';

import 'quiz_brain.dart';

void main() {
  runApp(const QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain quizBrain = QuizBrain();
  final List<Icon> scoreKeeper = [];

  Future<void> checkAnswer(bool userAnswer) async {
    final correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      scoreKeeper.add(
        Icon(
          userAnswer == correctAnswer ? Icons.check : Icons.close,
          color: userAnswer == correctAnswer
              ? Colors.greenAccent
              : Colors.redAccent,
        ),
      );
    });

    if (quizBrain.isFinished()) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Hoàn thành!'),
          content: const Text('Bạn đã trả lời hết các câu hỏi.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Làm lại'),
            ),
          ],
        ),
      );
      setState(() {
        quizBrain.reset();
        scoreKeeper.clear();
      });
    } else {
      setState(quizBrain.nextQuestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202124),
      appBar: AppBar(
        title: const Text('Quizzler'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: FilledButton(
                    onPressed: () => checkAnswer(true),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Đúng', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: FilledButton(
                    onPressed: () => checkAnswer(false),
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Sai', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(spacing: 4, children: scoreKeeper),
            ],
          ),
        ),
      ),
    );
  }
}
