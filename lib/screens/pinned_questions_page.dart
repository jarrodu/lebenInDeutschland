import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/cache/cache_manager.dart';
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
    List<QuestionModel> _questions = [];

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<int>?>(
        future: CacheManager.instance.getPinnedQuestions(),
        builder: (context, AsyncSnapshot<List<int>?> snapshot) {
          if (snapshot.hasData) {
            for (var i = 0; i < snapshot.data!.length; i++) {
              _questions.add(_questionsViewModel.questions[snapshot.data![i]]);
            }
            return Center(
              child: PageView(
                controller: controller,
                children: _buildQuestionPages(_questions).toList(),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Iterable<Widget> _buildQuestionPages(List<QuestionModel> questions) sync* {
    for (var i = 0; i < questions.length; i++) {
      yield QuestionWidget(questions[i], false, PageType.pinnedQuestionsPage);
    }
  }
}
