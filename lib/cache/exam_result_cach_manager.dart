import 'package:hive_flutter/hive_flutter.dart';
import 'package:leben_in_deutschland/models/exam_result_model.dart';

class ExamResultCacheManager {
  Box<ExamResultModel>? _examResultBox;

  static final ExamResultCacheManager _examResultCacheManager =
      ExamResultCacheManager.internal();

  factory ExamResultCacheManager() {
    return _examResultCacheManager;
  }
  ExamResultCacheManager.internal();

  get getExamResultBox => _examResultBox;

  Future<void> init() async {
    _examResultBox = Hive.box<ExamResultModel>("examResults");
  }

  Future<void> addItem(ExamResultModel examResultModel) async {
    await _examResultBox?.add(examResultModel);
  }

  ExamResultModel? getAtItem(int index) {
    return _examResultBox?.getAt(index);
  }

  List<ExamResultModel>? getAllItems() {
    return _examResultBox?.values.toList();
  }
}
