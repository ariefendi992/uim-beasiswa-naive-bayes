import 'package:equatable/equatable.dart';

class TrainingUktModel extends Equatable {
  final int? id;
  final String? nama,
      stambuk,
      prodi,
      kelaykan,
      semester,
      statusMhs,
      kip,
      penghasilan,
      tanggungan,
      pkh;

  TrainingUktModel({
    required this.id,
    this.nama = '',
    this.stambuk = '',
    this.prodi = '',
    this.semester = '',
    this.statusMhs = '',
    this.kip = '',
    this.penghasilan = '',
    this.tanggungan = '',
    this.pkh = '',
    this.kelaykan = '',
  });

  factory TrainingUktModel.fromJson(Map<String, dynamic> json) {
    return TrainingUktModel(
      id: json['id'],
      nama: json['nama'],
      stambuk: json['nim'],
      prodi: json['prodi'],
      semester: json['semester'],
      statusMhs: json['status_mhs'],
      kip: json['terima_kip_bm'],
      penghasilan: json['penghasilan_orang_tua'],
      tanggungan: json['jml_tanggungan'],
      pkh: json['pkh'],
      kelaykan: json['keputusan'],
    );
  }

  @override
  List<Object?> get props => [
        nama,
        prodi,
        semester,
        statusMhs,
        kip,
        penghasilan,
        tanggungan,
        pkh,
        kelaykan
      ];
}
