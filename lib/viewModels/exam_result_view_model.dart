import 'package:leben_in_deutschland/models/exam_result_model.dart';

class ExamResultViewModel {
  late ExamResultModel _examResult;

  ExamResultModel get examResult => _examResult;

  void createExamResultMode() {
    _examResult = ExamResultModel(correctQuestionCount: 0, falseQuestionCount: 0);
  }

  void addCorrectCount() {
    _examResult.correctQuestionCount++;
  }

  void addFalseCount() {
    _examResult.falseQuestionCount++;
  }

  void saveExamResult() {}
  void getExamResult() {}
}
