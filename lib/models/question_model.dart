import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String question;

  @HiveField(3)
  final List<dynamic> options;

  @HiveField(4)
  final bool hasImage;

  @HiveField(5)
  bool? isPinned;

  @HiveField(6)
  int? falseCounter;

  QuestionModel({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.hasImage,
    this.isPinned,
    this.falseCounter,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"] as int,
      category: json["category"] as String,
      question: json["question"] as String,
      options: json["options"] as List<dynamic>,
      hasImage: json["hasImage"] as bool,
      isPinned: false,
      falseCounter: 0,
    );
  }
}
