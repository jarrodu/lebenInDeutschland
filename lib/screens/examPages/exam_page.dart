// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/constants/string_constants.dart';
import 'package:leben_in_deutschland/enums/enums.dart';
import 'package:leben_in_deutschland/extensions/context_extension.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/screens/examPages/exam_result_page.dart';
import 'package:leben_in_deutschland/viewModels/exam_result_view_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/question_widget.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ExamPage extends StatefulWidget {
  final int selectedStateIndex;
  const ExamPage(this.selectedStateIndex, {Key? key}) : super(key: key);

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final controller = PageController();
  List<QuestionModel> _questions = [];
  List<QuestionModel> _examQuestions = [];
  DateTime timeNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final ExamResultViewModel _examResultViewModel =
        Provider.of<ExamResultViewModel>(context);

    final QuestionViewModel _questionsViewModel =
        Provider.of<QuestionViewModel>(context);

    _createExamQuestions(_questionsViewModel);
    _examResultViewModel.createExamResultModel(_examQuestions);

    return Scaffold(
      appBar: AppBar(
        title: SlideCountdown(
          duration: const Duration(minutes: 60),
          onDone: () => endExamAndGoToExamResult(_examResultViewModel),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildEndExamButton(context, _examResultViewModel),
          )
        ],
      ),
      body: Center(
        child: PageView(
          controller: controller,
          children: _buildQuestionPages(_examQuestions).toList(),
        ),
      ),
    );
  }

  TextButton _buildEndExamButton(
      BuildContext context, ExamResultViewModel _examResultViewModel) {
    return TextButton(
        style: context.theme.elevatedButtonTheme.style!.copyWith(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
        onPressed: () => _showMaterialDialog(_examResultViewModel),
        child: Text(
          endExamButtonText,
          style: context.primaryTextTheme.headline6!.copyWith(fontSize: 13),
        ));
  }

  void _createExamQuestions(QuestionViewModel questionsViewModel) {
    for (var i = 0; i < 300; i++) {
      _questions.add(questionsViewModel.questions[i]);
    }
    _questions.shuffle();
    for (var i = 0; i < 30; i++) {
      _examQuestions.add(_questions[i]);
    }
    _questions.clear();
    for (var i = 300 + (widget.selectedStateIndex * 10) + 1;
        i < 300 + (widget.selectedStateIndex * 10) + 11;
        i++) {
      _questions.add(questionsViewModel.questions[i]);
    }
    _questions.shuffle();
    for (var i = 0; i < 3; i++) {
      _examQuestions.add(_questions[i]);
    }
    _questions.clear();
  }

  Iterable<Widget> _buildQuestionPages(
      List<QuestionModel> examQuestions) sync* {
    for (var i = 0; i < examQuestions.length; i++) {
      yield QuestionWidget(examQuestions[i].id, PageType.examPage);
    }
  }

  void endExamAndGoToExamResult(ExamResultViewModel examResultViewModel) {
    examResultViewModel.setTimer(timeNow);
    examResultViewModel.saveExamResult();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExamResultPage(examResultViewModel.examResult),
        ));
  }

  void _showMaterialDialog(ExamResultViewModel examResultViewModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              alertDialogQuestion,
              style: context.primaryTextTheme.headline6,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    alertDialogNoButtonText,
                    style: context.primaryTextTheme.headline6,
                  )),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  endExamAndGoToExamResult(examResultViewModel);
                },
                child: Text(
                  alertDialogYesButtonText,
                  style: context.primaryTextTheme.headline6,
                ),
              )
            ],
          );
        });
  }
}
