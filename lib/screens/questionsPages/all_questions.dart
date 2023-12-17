import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/enums/enums.dart';
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


  late int page;

  @override
  void initState() {
    super.initState();
    page = 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionsViewModel =
        Provider.of<QuestionViewModel>(context);
    final List<QuestionModel>? questions = _questionsViewModel.questions;

    return Scaffold(
      appBar: AppBar(
        actions: [
          _buildChooseQuestionDropdown(),
        ],
      ),
      body: Center(
        child: PageView.builder(
          itemCount: 300,
          itemBuilder: (context, index) {
            return _buildQuestionPages(questions!, index);
          },
          allowImplicitScrolling: true,
          controller: controller,
          onPageChanged: (value) {
            //page = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  DropdownButtonHideUnderline _buildChooseQuestionDropdown() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<int>(
      value: page,
      onChanged: (value) => setState(() {
        page = value!;
        controller.jumpToPage(value);
      }),
      items: List.generate(
          300,
          (index) => DropdownMenuItem(
              value: index, child: Text((index + 1).toString()))),
    ));
  }

  Widget _buildQuestionPages(List<QuestionModel> questions, int i) {
    return QuestionWidget(i + 1, PageType.allQuestionPage);
  }
}
