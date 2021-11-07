import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:translator/translator.dart';

class QuestionWidget extends StatefulWidget {
  final QuestionModel question;
  final bool isTranslated;
  const QuestionWidget(this.question, this.isTranslated, {Key? key}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final translator = GoogleTranslator();

  List<Color> optionColors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ];
  @override
  Widget build(BuildContext context) {
    //translator.translate("Hello", to: 'tr').then(print);
    return Center(
      child: FutureBuilder(
        future: _buildQuestion(widget.question),
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        }
        else{
          return CircularProgressIndicator();
        }
      },)
      
      // Column(
      //   children: [
      //     _buildQuestionText(widget.question),
      //     //TODO image
      //     _buildQuestionOptions(widget.question),
      //   ],
      // ),
    );
  }

  Text _buildQuestionText(QuestionModel question) {
    return Text((question.id).toString() + ". " + question.question);
  }

  Column _buildQuestionOptions(QuestionModel question) {
    return Column(
        children: List.generate(
      4,
      (optionIndex) => ElevatedButton(
          //style: ElevatedButton.styleFrom(primary: optionColors[optionIndex]),
          onPressed: () => controlQuestion(question, optionIndex),
          child: Text(question.options[optionIndex])),
    ));
  }

  void controlQuestion(QuestionModel question, int optionIndex) {
    if (question.options[optionIndex] == question.correctAnswer) {
    } else {}
  }

  Future<Widget> _buildQuestion(QuestionModel question) async {
    //await translator.translate(question.question, to: 'tr').then((value) => print(value));
    if (widget.isTranslated) {
      String tQuestion = await translator.translate(question.question, to: 'tr').then((value) => print(value)) as String;
      String tCategory = await translator.translate(question.category, to: 'tr') as String;
      List<String> tOptions = [];
      for (var i = 0; i < 4; i++) {
        tOptions.add(await translator.translate(question.category, to: 'tr') as String);
      }
      String tCorrect = await translator.translate(question.correctAnswer, to: 'tr') as String;
      QuestionModel translatedQuestion = QuestionModel(
          id: question.id,
          category: tCategory,
          question: tQuestion,
          options: tOptions,
          correctAnswer: tCorrect);
      print(translatedQuestion);
      return Column(
        children: [
          _buildQuestionText(translatedQuestion),
          //TODO image
          _buildQuestionOptions(translatedQuestion),
        ],
      );
    } else {
      return Column(
        children: [
          _buildQuestionText(question),
          //TODO image
          _buildQuestionOptions(question),
        ],
      );
    }
  }
}
