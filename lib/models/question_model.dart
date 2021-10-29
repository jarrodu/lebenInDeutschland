class QuestionModel {
  final int id;
  final String category;
  final String question;
  final List<dynamic> options;
  final String correctAnswer;

  QuestionModel({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"] as int,
      category: json["category"] as String,
      question: json["question"] as String,
      options: json["options"] as List<dynamic>,
      correctAnswer: json["correctAnswer"] as String,
    );
  }
}
