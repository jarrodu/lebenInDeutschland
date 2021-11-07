import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:leben_in_deutschland/models/question_model.dart';

class QuestionViewModel {
  List<QuestionModel> questions = [];

  QuestionViewModel(){
    getQuestionsFromJson();
    print("question view model construction");
  }

  Future<void> getQuestionsFromJson() async {
    try {
      final String response = await rootBundle.loadString("assets/jsons/lid_fragen.json");
      final data = await json.decode(response);
      for (var i = 0; i < data.length; i++) {
        questions.add(QuestionModel.fromJson(data[i]));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
