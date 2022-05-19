import 'package:equatable/equatable.dart';

class PenghasilanOrtuModel extends Equatable {
  final int id;
  final String penghasilan, keterangan;
  PenghasilanOrtuModel({
    required this.id,
    required this.penghasilan,
    required this.keterangan,
  });

  factory PenghasilanOrtuModel.fromJson(Map<String, dynamic> json) {
    return PenghasilanOrtuModel(
      id: json['id'],
      penghasilan: json['penghasilan'],
      keterangan: json['keterangan'],
    );
  }

  @override
  List<Object?> get props => [id, penghasilan, keterangan];
}

List<PenghasilanOrtuModel> penghasilanOrtuFromJson(jsonData) {
  List<PenghasilanOrtuModel> result = List<PenghasilanOrtuModel>.from(
    jsonData.map(
      (item) => PenghasilanOrtuModel.fromJson(item),
    ),
  );
  return result;
}
