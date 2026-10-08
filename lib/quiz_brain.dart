import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = const [
    Question('Flutter sử dụng ngôn ngữ Dart.', true),
    Question('StatefulWidget không thể thay đổi giao diện.', false),
    Question('setState() yêu cầu Flutter dựng lại widget.', true),
    Question('List trong Dart chỉ chứa được số nguyên.', false),
    Question('MaterialApp là widget gốc phổ biến của ứng dụng Flutter.', true),
  ];

  String getQuestionText() => _questionBank[_questionNumber].questionText;

  bool getQuestionAnswer() => _questionBank[_questionNumber].questionAnswer;

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() => _questionNumber >= _questionBank.length - 1;

  void reset() {
    _questionNumber = 0;
  }
}
