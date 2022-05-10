import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/enums/enums.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/question_widget.dart';
import 'package:provider/provider.dart';

class PinnedQuestionsPage extends StatefulWidget {
  const PinnedQuestionsPage({Key? key}) : super(key: key);

  @override
  _PinnedQuestionsPageState createState() => _PinnedQuestionsPageState();
}

class _PinnedQuestionsPageState extends State<PinnedQuestionsPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionsViewModel =
        Provider.of<QuestionViewModel>(context);
    List<QuestionModel> _questions = _questionsViewModel.getPinnedQuestions();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
              child: PageView(
                controller: controller,
                children: _buildQuestionPages(_questions).toList(),
              ),
            )
          
    );
  }

  Iterable<Widget> _buildQuestionPages(List<QuestionModel> questions) sync* {
    for (var i = 0; i < questions.length; i++) {
      yield QuestionWidget(questions[i].id, PageType.pinnedQuestionsPage);
    }
  }
}
