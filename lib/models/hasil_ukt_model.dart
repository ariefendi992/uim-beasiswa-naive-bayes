import 'package:equatable/equatable.dart';


class HasilUktModel extends Equatable {
  final int? id;
  // final UserM
  final String? 
      // id,
      nama,
      stambuk,
      prodi,
      kelaykan,
      semester,
      statusMhs,
      kip,
      penghasilan,
      tanggungan,
      pkh;

  HasilUktModel({
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

  factory HasilUktModel.fromJson(Map<String, dynamic> json) {
    return HasilUktModel(
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
