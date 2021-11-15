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

class _QuestionWidgetState extends State<QuestionWidget> with AutomaticKeepAliveClientMixin {
  final translator = GoogleTranslator();
  bool? _isAnswered;
  List<Color>? optionColors;
  @override
  void initState() {
    super.initState();
    _isAnswered = false;
    optionColors = [
      Colors.black,
      Colors.black,
      Colors.black,
      Colors.black,
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //translator.translate("Hello", to: 'tr').then(print);
    return Center(
        child: FutureBuilder(
      future: _buildQuestion(widget.question),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        } else {
          return const CircularProgressIndicator();
        }
      },
    )

        // Column(
        //   children: [
        //     _buildQuestionText(widget.question),
        //     //TODO image
        //     _buildQuestionOptions(widget.question),
        //   ],
        // ),
        );
  }

  Widget _buildQuestionNumberCard(QuestionModel question) {
    return Card(
      color: Colors.tealAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Text(
          question.id.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildQuestionText(QuestionModel question) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Card(
          //margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              question.question,
              style: TextStyle(color: Colors.black),
            ),
          )),
    );
  }

  Column _buildQuestionOptions(QuestionModel question) {
    return Column(
      children: List.generate(
        4,
        (optionIndex) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: optionColors![optionIndex],
                  alignment: Alignment.center,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 50)),
              onPressed: () {
                controlQuestion(question, optionIndex);
              },
              child: Text(question.options[optionIndex])),
        ),
      ),
    );
  }

  void controlQuestion(QuestionModel question, int optionIndex) {
    if (!_isAnswered!) {
      if (question.options[optionIndex] == question.correctAnswer) {
        optionColors![optionIndex] = Colors.green;
      } else {
        optionColors![optionIndex] = Colors.red;
        for (var i = 0; i < question.options.length; i++) {
          if (question.options[i] == question.correctAnswer) {
            optionColors![i] = Colors.green;
          }
        }
      }
      _isAnswered = true;
      setState(() {});
    }
  }

  Future<Widget> _buildQuestion(QuestionModel question) async {
    //await translator.translate(question.question, to: 'tr').then((value) => print(value));
    if (widget.isTranslated) {
      String tQuestion = await translator
          .translate(question.question, to: 'tr')
          .then((value) => print(value)) as String;
      String tCategory = await translator.translate(question.category, to: 'tr') as String;
      List<String> tOptions = [];
      for (var i = 0; i < 4; i++) {
        tOptions.add(await translator.translate(question.category, to: 'tr') as String);
      }
      String tCorrect = await translator.translate(question.correctAnswer, to: 'tr') as String;
      print(tCorrect);
      QuestionModel translatedQuestion = QuestionModel(
          id: question.id,
          category: tCategory,
          question: tQuestion,
          options: tOptions,
          correctAnswer: tCorrect);
      print(translatedQuestion);
      return Column(
        children: [
          _buildQuestionNumberCard(translatedQuestion),
          _buildQuestionText(translatedQuestion),
          //TODO image
          _buildQuestionOptions(translatedQuestion),
        ],
      );
    } else {
      return Column(
        children: [
          Align(alignment: Alignment.centerLeft, child: _buildQuestionNumberCard(question)),
          _buildQuestionText(question),
          //TODO image
          _buildQuestionOptions(question),
        ],
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
