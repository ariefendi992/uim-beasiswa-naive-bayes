import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:http/http.dart' as http;

class ProdiModel extends Equatable {
  final int? id;
  final String? jurusan;

  ProdiModel({
    required this.id,
    required this.jurusan,
  });

  factory ProdiModel.fromJson(Map<String, dynamic> json) {
    return ProdiModel(
      id: json['id'],
      jurusan: json['jurusan'],
    );
  }

  @override
  List<Object?> get props => [id, jurusan];
}

List<ProdiModel> prodiFromJson(jsonData) {
  List<ProdiModel> result = List<ProdiModel>.from(
    jsonData.map(
      (item) => ProdiModel.fromJson(item),
    ),
  );
  return result;
}

Future<List<ProdiModel>> fetchProdi() async {
  String route = baseUrl + '/kategori/jurusan';
  final response = await http.get(Uri.parse(route));
  if (response.statusCode == 200) {
    var jsonRespon = jsonDecode(response.body);
    return prodiFromJson(jsonRespon['data']);
  } else {
    throw Exception('Failed load $route, status : ${response.statusCode}');
  }
}
