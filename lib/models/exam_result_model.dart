import 'package:hive/hive.dart';

part 'exam_result_model.g.dart';

@HiveType(typeId: 1)
class ExamResultModel extends HiveObject{

  @HiveField(0)
  int correctQuestionCount;

  @HiveField(1)
  int falseQuestionCount;

  @HiveField(2)
  int blankQuestionCount;

  @HiveField(3)
  List<Map<String, dynamic>> answeredQuestions;

  @HiveField(4)
  DateTime time;

  ExamResultModel({
    required this.correctQuestionCount,
    required this.falseQuestionCount,
    required this.blankQuestionCount,
    required this.answeredQuestions,
    required this.time,
  });
}
