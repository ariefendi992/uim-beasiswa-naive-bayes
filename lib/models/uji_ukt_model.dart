import 'package:equatable/equatable.dart';

class UjiUktModel extends Equatable {
  final int? idProdi, idSemester, idPenghasilan;
  final String? statusMhs, kip, tanggungan, pkh;

  UjiUktModel({
    required this.idProdi,
    required this.idSemester,
    required this.statusMhs,
    required this.kip,
    required this.idPenghasilan,
    required this.tanggungan,
    required this.pkh,
  });

  factory UjiUktModel.fromJson(Map<dynamic, dynamic> json) {
    return UjiUktModel(
      idProdi: json['id_prodi'],
      idSemester: json['id_semester'],
      statusMhs: json['status_mhs'],
      kip: json['kip_bm'],
      idPenghasilan: json['id_penghasilan'],
      tanggungan: json['tanggungan'],
      pkh: json['pkh'],
    );
  }

  @override
  List<Object?> get props => [
        idProdi,
        idSemester,
        statusMhs,
        kip,
        idPenghasilan,
        tanggungan,
        pkh,
      ];
}

List<UjiUktModel> ujiUktFromJson(jsonData) {
  List<UjiUktModel> result = List<UjiUktModel>.from(
    jsonData.map(
      (item) => UjiUktModel.fromJson(item),
    ),
  );
  return result;
}
