// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamResultModelAdapter extends TypeAdapter<ExamResultModel> {
  @override
  final int typeId = 1;

  @override
  ExamResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamResultModel(
      correctQuestionCount: fields[0] as int,
      falseQuestionCount: fields[1] as int,
      blankQuestionCount: fields[2] as int,
      answeredQuestions: (fields[3] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      time: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExamResultModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.correctQuestionCount)
      ..writeByte(1)
      ..write(obj.falseQuestionCount)
      ..writeByte(2)
      ..write(obj.blankQuestionCount)
      ..writeByte(3)
      ..write(obj.answeredQuestions)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
