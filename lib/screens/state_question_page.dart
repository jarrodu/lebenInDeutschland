import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/enums/enums.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/question_widget.dart';
import 'package:provider/provider.dart';

class StateQuestionPage extends StatefulWidget {
  final int _selectedStateIndex;
  const StateQuestionPage(this._selectedStateIndex, {Key? key}) : super(key: key);

  @override
  State<StateQuestionPage> createState() => _StateQuestionPageState();
}

class _StateQuestionPageState extends State<StateQuestionPage> {
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionsViewModel = Provider.of<QuestionViewModel>(context);
    final List<QuestionModel>? stateQuestions =
        _questionsViewModel.statesQuestions[widget._selectedStateIndex];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.push_pin_outlined)),
          IconButton(
              onPressed: () {
                counter.value = controller.page!.toInt();
                print(counter.value);
                print(controller.page);
              },
              icon: const Icon(Icons.translate)),
        ],
      ),
      body: Center(
        child: PageView.builder(
          itemCount: stateQuestions!.length,
          itemBuilder: (context, index) {
            return _buildQuestionPages(stateQuestions, index);
          },
          allowImplicitScrolling: true,
          controller: controller,
          //children: _buildQuestionPages(questions!).toList(),
        ),
      ),
    );
  }

   Widget _buildQuestionPages(List<QuestionModel> stateQuestions, int i)  {
    //for (var i = 0; i < questions.length; i++) {
      return ValueListenableBuilder<int>(
        valueListenable: counter,
        builder: (context, value, _) {
          if (value == i) {
            return QuestionWidget(stateQuestions[i], true,PageType.stateQuestionPage);
          } else {
            return QuestionWidget(stateQuestions[i], false,PageType.stateQuestionPage);
          }
        },
      );
    //}
  }
}
