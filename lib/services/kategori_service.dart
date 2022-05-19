import 'dart:convert';

import 'package:ft_uim_naive_bayes/models/penghasilan_ortu_model.dart';
import 'package:ft_uim_naive_bayes/models/semester_model.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:http/http.dart' as http;

class KategoriService {
  void getProdi() async {
    var url = '$baseUrl/kategori/jurusan';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      print('dta prodi $data');
      return data;
    } else {
      var data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<List<SemesterModel>> fetchSemester() async {
    try {
      String route = baseUrl + '/kategori/semester';
      final response = await http.get(Uri.parse(route));
      if (response.statusCode == 200) {
        var jsonResp = jsonDecode(response.body);
        return semesterFromJson(jsonResp['data']);
      } else {
        throw Exception('Failed load $route, status : ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<PenghasilanOrtuModel>> fetchPenghasilanOrtu() async {
    try {
      String route = baseUrl + '/kategori/penghasilan';
      final response = await http.get(Uri.parse(route));

      if (response.statusCode == 200) {
        var jsonResp = jsonDecode(response.body);
        return penghasilanOrtuFromJson(jsonResp['data']);
      } else {
        throw Exception(
            'Gagal memuat data $route, status : ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
