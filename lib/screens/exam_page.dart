import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/enums/enums.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/viewModels/exam_result_view_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/question_widget.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final ExamResultViewModel _examResultViewModel = Provider.of<ExamResultViewModel>(context);
    _examResultViewModel.createExamResultMode();

    final QuestionViewModel _questionsViewModel = Provider.of<QuestionViewModel>(context);
    List<QuestionModel> _questions = [];
    
    for (var i = 0; i < _questionsViewModel.questions.length; i++) {
      _questions.add(_questionsViewModel.questions[i]);
    }
    _questions.shuffle();
    return Scaffold(
      appBar: AppBar(
        title: const SlideCountdown(
          duration: Duration(minutes: 60),
        ),
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
      yield QuestionWidget(questions[i], false, PageType.examPage);
    }
  }
}
