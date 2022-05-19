import 'package:equatable/equatable.dart';

class SemesterModel extends Equatable {
  final int id;
  final String semester;

  SemesterModel({
    required this.id,
    required this.semester,
  });

  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    return SemesterModel(
      id: json['id'],
      semester: json['semester'],
    );
  }
  @override
  List<Object?> get props => [id, semester];
}

List<SemesterModel> semesterFromJson(jsonData) {
  List<SemesterModel> result = List<SemesterModel>.from(
    jsonData.map(
      (item) => SemesterModel.fromJson(item),
    ),
  );
  return result;
}
