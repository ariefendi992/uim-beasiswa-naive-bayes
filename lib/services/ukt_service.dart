import 'dart:convert';
import 'package:ft_uim_naive_bayes/models/training_ukt.dart';
import 'package:ft_uim_naive_bayes/models/uji_ukt_model.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
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

        // prodi layak
        await SecureStorages().setStorage(
            'prodiLayak', jsonResp['data']['atr_prodi']['layak'].toString());

        // prodi tidak layak
        await SecureStorages().setStorage('prodiTidakLayak',
            jsonResp['data']['atr_prodi']['tidak_layak'].toString());

        // semester layak
        await SecureStorages().setStorage('semesterLayak',
            jsonResp['data']['atr_semester']['layak'].toString());

        // semester tidak layak
        await SecureStorages().setStorage('semesterTidakLayak',
            jsonResp['data']['atr_semester']['tidak_layak'].toString());

        // statusMahasiswa layak
        await SecureStorages().setStorage('statusMahasiswaLayak',
            jsonResp['data']['atr_status_mhs']['layak'].toString());

        // statusMahasiswa tidak layak
        await SecureStorages().setStorage('statusMahasiswaTidakLayak',
            jsonResp['data']['atr_status_mhs']['tidak_layak'].toString());

        // kip layak
        await SecureStorages().setStorage('kipLayak',
            jsonResp['data']['atr_penerima_kip']['layak'].toString());

        // kip tidak layak
        await SecureStorages().setStorage('kipTidakLayak',
            jsonResp['data']['atr_penerima_kip']['tidak_layak'].toString());

        // penghasilan layak
        await SecureStorages().setStorage('penghasilanLayak',
            jsonResp['data']['atr_penghasilan_orang_tua']['layak'].toString());

        // penghasilan tidak layak
        await SecureStorages().setStorage(
            'penghasilanTidakLayak',
            jsonResp['data']['atr_penghasilan_orang_tua']['tidak_layak']
                .toString());

        // pkh layak
        await SecureStorages().setStorage(
            'pkhLayak', jsonResp['data']['atr_status_pkh']['layak'].toString());

        // pkh tidak layak
        await SecureStorages().setStorage('pkhTidakLayak',
            jsonResp['data']['atr_status_pkh']['tidak_layak'].toString());

        // kesimpulan
        await SecureStorages().setStorage('hasil', jsonResp['kesimpulan']);

        print('json resp ukt == ${jsonResp["data"]["atr_prodi"]['layak']}');
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
