import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/question_widget.dart';
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
  final counter = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionsViewModel = Provider.of<QuestionViewModel>(context);
    final List<QuestionModel>? questions = _questionsViewModel.questions;



    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.push_pin_outlined)),
          IconButton(onPressed: () {
            counter.value = controller.page!.toInt();
            print(counter.value);
            print(controller.page);
          }, icon: const Icon(Icons.translate)),
        ],
      ),
      body: Center(
        child: PageView(

          controller: controller,
          children: _buildQuestionPages(questions!).toList(),
        ),
      ),
    );
  }

  Iterable<Widget> _buildQuestionPages(List<QuestionModel> questions) sync* {
    for (var i = 0; i < questions.length; i++) {
      yield ValueListenableBuilder<int>(
        valueListenable: counter,
        builder: (context, value, _) {
          if (value == i) {
            return QuestionWidget(questions[i], true);
          }
          else{
            return QuestionWidget(questions[i], false);
          }
        },
      );
    }
  }
}
