import 'package:flutter_test/flutter_test.dart';

import 'package:lab06_quizzler/main.dart';
import 'package:lab06_quizzler/quiz_brain.dart';

void main() {
  test('QuizBrain chuyển câu hỏi và reset', () {
    final brain = QuizBrain();
    final firstQuestion = brain.getQuestionText();
    brain.nextQuestion();
    expect(brain.getQuestionText(), isNot(firstQuestion));
    brain.reset();
    expect(brain.getQuestionText(), firstQuestion);
  });

  testWidgets('hiển thị câu hỏi và hai nút trả lời', (tester) async {
    await tester.pumpWidget(const QuizzlerApp());

    expect(find.text('Đúng'), findsOneWidget);
    expect(find.text('Sai'), findsOneWidget);
    expect(find.text('Flutter sử dụng ngôn ngữ Dart.'), findsOneWidget);
  });
}
