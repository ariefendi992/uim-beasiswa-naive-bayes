import 'dart:convert';
import 'package:ft_uim_naive_bayes/models/uji_ukt_model.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:http/http.dart' as http;

class UktService {
  Future<UjiUktModel> ujiData({
    int? idProdi,
    idSemester,
    idPenghasilan,
    String? statusMhs,
    kip,
    tanggungan,
    pkh,
  }) async {
    try {
      String route = baseUrl + '/beasiswa-ukt/uji-data';

      var header = {
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({
        'id_prodi': idProdi,
        'id_semester': idSemester,
        'status_mhs': statusMhs,
        'kip_bm': kip,
        'id_penghasilan': idPenghasilan,
        'tanggungan': tanggungan,
        'pkh_kks': pkh,
      });

      final response = await http.post(
        Uri.parse(route),
        headers: header,
        body: body,
      );

      print('response ukt === ${response.body}');

      if (response.statusCode == 200) {
        var jsonResp = jsonDecode(response.body);
        // await SecureStorages().setStorage('prodiLayak', jsonResp['data']['atr_prodi']);
        print('json resp ukt == ${jsonResp["data"]["atr_prodi"]}');

        UjiUktModel ujiUkt = UjiUktModel.fromJson(jsonResp);
        return ujiUkt;
      } else {
        throw Exception(
            'Gagal memuat data $route, status : ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  // Future<List<UjiUktModel>> fetchUjiUkt() async {

  // }
}
