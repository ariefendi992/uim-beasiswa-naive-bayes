import 'package:equatable/equatable.dart';

class TanggunganModel extends Equatable {
  final int id;
  final String? tanggungan;

  TanggunganModel({
    required this.id,
    required this.tanggungan,
  });

  factory TanggunganModel.fromJson(Map<String, dynamic> json) {
    return TanggunganModel(
      id: json['id'],
      tanggungan: json['tanggungan'],
    );
  }

  @override
  List<Object?> get props => [id, tanggungan];
}
