import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/question_widget.dart';
import 'package:leben_in_deutschland/widgets/timer_widget.dart';
import 'package:provider/provider.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final controller = PageController();
  final counter = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionsViewModel = Provider.of<QuestionViewModel>(context);
    List<QuestionModel> _questions = [];
    for (var i = 0; i < _questionsViewModel.questions.length; i++) {
      _questions.add(_questionsViewModel.questions[i]);
    }
    _questions.shuffle();
    return Scaffold(
      appBar: AppBar(
        title: const TimerWidget(),
        centerTitle: true,
      ),
      body: Center(
        child: PageView(
          controller: controller,
          children: _buildQuestionPages(_questions).toList(),
        ),
      ),
    );
  }

  Iterable<Widget> _buildQuestionPages(List<QuestionModel> questions) sync* {
    for (var i = 0; i < 30; i++) {
      yield ValueListenableBuilder<int>(
        valueListenable: counter,
        builder: (context, value, _) {
          if (value == i) {
            return QuestionWidget(questions[i], true);
          } else {
            return QuestionWidget(questions[i], false);
          }
        },
      );
    }
  }
}
