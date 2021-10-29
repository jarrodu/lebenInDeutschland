import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:provider/provider.dart';

class AllQuestions extends StatefulWidget {
  const AllQuestions({Key? key}) : super(key: key);

  @override
  State<AllQuestions> createState() => _AllQuestionsState();
}

class _AllQuestionsState extends State<AllQuestions> {
  final controller = PageController();
  bool? isTrue;
  List<Color> optionColors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionsViewModel = Provider.of<QuestionViewModel>(context);
    final List<QuestionModel> questions = _questionsViewModel.questions;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PageView(
          clipBehavior: Clip.antiAlias,
          onPageChanged: (value) {
            optionColors = [
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
            ];
            setState(() {
              
            });
          },
          controller: controller,
          children: List.generate(questions.length, (questionIndex) {
            return Center(
              child: Column(
                children: [
                  _buildQuestionText(questionIndex, questions),
                  //TODO image
                  _buildQuestionOptions(questionIndex, questions),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Text _buildQuestionText(int questionIndex, List<QuestionModel> questions) {
    return Text((questionIndex + 1).toString() + ". " + questions[questionIndex].question);
  }

  Column _buildQuestionOptions(int questionIndex, List<QuestionModel> questions) {
    return Column(
        children: List.generate(
      4,
      (optionIndex) => ElevatedButton(
          style: ElevatedButton.styleFrom(primary: optionColors[optionIndex]),
          onPressed: () => controlQuestion(questions, optionIndex, questionIndex),
          child: Text(questions[questionIndex].options[optionIndex])),
    ));
  }

  void controlQuestion(List<QuestionModel> questions, int optionIndex, int questionIndex) {
    if (questions[questionIndex].options[optionIndex] == questions[questionIndex].correctAnswer) {
      isTrue = true;
      optionColors[optionIndex] = Colors.green;
      setState(() {});
    } else {
      isTrue = false;
      optionColors[optionIndex] = Colors.red;
      setState(() {});
    }
    print(isTrue);
  }
}
