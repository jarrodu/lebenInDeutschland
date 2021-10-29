import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:provider/provider.dart';

class AllQuestions extends StatelessWidget {
  const AllQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _questionsViewModel = Provider.of<QuestionViewModel>(context);
    final controller = PageController();


    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PageView(
          controller: controller,
          children: List.generate(_questionsViewModel.questions.length, (index) {
            return Center(
              child: Column(
                children: [
                  Text(_questionsViewModel.questions[index].question),
                  Column(
                    children: [
                      ElevatedButton(onPressed: null, child: Text(_questionsViewModel.questions[index].options[0])),
                      ElevatedButton(onPressed: null, child: Text(_questionsViewModel.questions[index].options[1])),
                      ElevatedButton(onPressed: null, child: Text(_questionsViewModel.questions[index].options[2])),
                      ElevatedButton(onPressed: null, child: Text(_questionsViewModel.questions[index].options[3])),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
