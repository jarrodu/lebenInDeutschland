import 'package:leben_in_deutschland/cache/exam_result_cach_manager.dart';
import 'package:leben_in_deutschland/models/exam_result_model.dart';
import 'package:leben_in_deutschland/models/question_model.dart';

class ExamResultViewModel {
  late ExamResultModel _examResult;


  set setExamResult( value) => _examResult = value;
  ExamResultModel get examResult => _examResult;

  final ExamResultCacheManager _examResultCacheManager =
      ExamResultCacheManager();
  List<ExamResultModel> allExamResults = [];

  ExamResultViewModel(){
    _examResultCacheManager.init();
  }

  void createExamResultModel(List<QuestionModel> examQuestions) {
    _examResult = ExamResultModel(
      correctQuestionCount: 0,
      falseQuestionCount: 0,
      blankQuestionCount: 0,
      answeredQuestions: List.generate(
          examQuestions.length,
          (index) => {
                "question": examQuestions[index],
                "selectedOptionIndex": null,
              }),
      time: DateTime(0).add(
        const Duration(hours: 1),
      ),
    );
  }

  void changeQuestionSelectedOption(int questionID, int selectedOptionIndex) {
    _examResult.answeredQuestions.singleWhere((element) =>
            element["question"].id == questionID)["selectedOptionIndex"] =
        selectedOptionIndex;
  }

  int? findQuestionSelectedOptionIndex(int questionID) {
    return _examResult.answeredQuestions.singleWhere((element) =>
        element["question"].id == questionID)["selectedOptionIndex"];
  }

  void controlExam() {
    for (var i = 0; i < examResult.answeredQuestions.length; i++) {
      if (examResult.answeredQuestions[i]["selectedOptionIndex"] == null) {
        addBlankCount();
      } else {
        if (examResult.answeredQuestions[i]["question"]
                .options[examResult.answeredQuestions[i]["selectedOptionIndex"]]
            ["is_Correct"]) {
          addCorrectCount();
        } else {
          addFalseCount();
        }
      }
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.minute, from.second);
    to = DateTime(to.year, to.month, to.day, to.minute, to.second);
    return (to.difference(from).inMinutes);
  }

  void setTimer(DateTime time) {
    _examResult.time =
        DateTime(0).add(Duration(seconds: daysBetween(time, DateTime.now())));
  }

  void addCorrectCount() {
    _examResult.correctQuestionCount++;
  }

  void addFalseCount() {
    _examResult.falseQuestionCount++;
  }

  void addBlankCount() {
    _examResult.blankQuestionCount++;
  }

  void saveExamResult() async {
    controlExam();
    await _examResultCacheManager.addItem(_examResult);
  }

  void getExamResult() {
    allExamResults = _examResultCacheManager.getAllItems() ?? [];
  }
}
