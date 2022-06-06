import 'dart:convert';
import 'package:ft_uim_naive_bayes/models/training_ukt.dart';
import 'package:ft_uim_naive_bayes/models/uji_ukt_model.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:http/http.dart' as http;

class UktService {
  Future<UjiUktModel> ujiData({
    int? idProdi,
    idUser,
    idSemester,
    idPenghasilan,
    idTanggungan,
    String? statusMhs,
    kip,
    pkh,
  }) async {
    try {
      String route = baseUrl + '/beasiswa-ukt/uji-data';

      var header = {
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({
        'id_user': idUser,
        'id_prodi': idProdi,
        'id_semester': idSemester,
        'status_mhs': statusMhs,
        'kip_bm': kip,
        'id_penghasilan': idPenghasilan,
        'id_tanggungan': idTanggungan,
        'pkh_kks': pkh,
      });

      final response = await http.post(
        Uri.parse(route),
        headers: header,
        body: body,
      );

      print('response ukt === ${response.body}');

      var prodi = jsonDecode(response.body)['layak']['p_prodi_layak'];

      print('value prodi == $prodi');

      if (response.statusCode == 200) {
        var jsonResp = jsonDecode(response.body);

        // prodi layak
        await SecureStorages().setStorage('prodiLayak', prodi.toString());

        // prodi tidak layak
        await SecureStorages().setStorage(
            'prodiTidakLayak', jsonResp['tidak']['p_prodi_tidak'].toString());

        // semester layak
        await SecureStorages().setStorage(
            'semesterLayak', jsonResp['layak']['p_sms_layak'].toString());

        // semester tidak layak
        await SecureStorages().setStorage(
            'semesterTidakLayak', jsonResp['tidak']['p_sms_tidak'].toString());

        // statusMahasiswa layak
        await SecureStorages().setStorage('statusMahasiswaLayak',
            jsonResp['layak']['p_status_mhs_layak'].toString());

        // statusMahasiswa tidak layak
        await SecureStorages().setStorage('statusMahasiswaTidakLayak',
            jsonResp['tidak']['p_status_mhs_tidak'].toString());

        // kip layak
        await SecureStorages().setStorage(
            'kipLayak', jsonResp['layak']['p_kip_layak'].toString());

        // kip tidak layak
        await SecureStorages().setStorage(
            'kipTidakLayak', jsonResp['tidak']['p_kip_tidak'].toString());

        // penghasilan layak
        await SecureStorages().setStorage('penghasilanLayak',
            jsonResp['layak']['p_penghasilan_layak'].toString());

        // penghasilan tidak layak
        await SecureStorages().setStorage('penghasilanTidakLayak',
            jsonResp['tidak']['p_penghasilan_tidak'].toString());

        // pkh layak
        await SecureStorages().setStorage(
            'pkhLayak', jsonResp['layak']['p_pkh_layak'].toString());

        // pkh tidak layak
        await SecureStorages().setStorage(
            'pkhTidakLayak', jsonResp['tidak']['p_pkh_tidak'].toString());

        // kesimpulan
        await SecureStorages().setStorage('hasil', jsonResp['keputusan']);

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

  Future<List<TrainingUktModel>> fetchUkt() async {
    try {
      final route = baseUrl + '/beasiswa-ukt/data-record2';
      final response = await http.get(Uri.parse(route));
      print('respon ukt == $route');
      if (response.statusCode == 200) {
        var jsonResp = jsonDecode(response.body);
        print('data ukt === $jsonResp');

        List<TrainingUktModel> uktModel =
            List<TrainingUktModel>.from(jsonResp['data'].map((e) {
          return TrainingUktModel.fromJson(e);
        })).toList();

        return uktModel;
      } else {
        throw Exception(
            'Failed load data $route, staus : ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
