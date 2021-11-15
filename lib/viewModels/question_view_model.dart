import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:leben_in_deutschland/constants/string_constants.dart';
import 'package:leben_in_deutschland/models/question_model.dart';

class QuestionViewModel {
  List<QuestionModel> questions = [];
  List<List<QuestionModel>> statesQuestions = [];

  QuestionViewModel() {
    getQuestionsFromJson();
    getStatesQuestionsJson();
    print("question view model construction");
  }

  Future<void> getQuestionsFromJson() async {
    try {
      final String response = await rootBundle.loadString(lidQuestionsPath);
      final data = await json.decode(response);
      for (var i = 0; i < data.length; i++) {
        questions.add(QuestionModel.fromJson(data[i]));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> getStatesQuestionsJson() async {
    try {
      for (var i = 0; i < statesQuestionsPaths.length; i++) {
        List<QuestionModel> _squestions = [];
        final String response = await rootBundle.loadString(statesQuestionsPaths[i]);
        final data = await json.decode(response);
        for (var k = 0; k < data.length; k++) {
          _squestions.add(QuestionModel.fromJson(data[k]));
        }
        statesQuestions.add(_squestions);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
