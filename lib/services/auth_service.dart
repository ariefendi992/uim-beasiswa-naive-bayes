import 'dart:convert';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:ft_uim_naive_bayes/models/user_model.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<UserModel> register({
    String? stambuk,
    String? nama,
    String? gender,
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/auth/register';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode({
      'stambuk': stambuk,
      'nama': nama,
      'gender': gender,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('Data : ${response.body}');

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);

      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      var data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<UserModel> signIn({
    String? stambuk,
    String? password,
  }) async {
    var url = ('$baseUrl/auth/login');
    print('url = $url');

    var header = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      'stambuk': stambuk,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('Data : ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      // prefs.setString('token', data['token']);
      // prefs.setString('expire', data['expire']);
      // prefs.setString('nama', data['nama']);
      // prefs.setString('stambuk', data['stambuk']);
      // prefs.setString('refresh', data['token']);
      // prefs.setString('expire', data['expire']);
      await SecureStorages().setStorage('token', data['token']);
      await SecureStorages().setStorage('refresh', data['refresh']);

      // print('get token = ${prefs.getString('token')}');
      UserModel user = UserModel.fromJson(data);

      return user;
    } else {
      var data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<void> signOut() async {
    try {
      await SecureStorages().deleteKey('token');
    } catch (e) {}
  }

  Future<UserModel?> getProfil() async {
    var token = await SecureStorages().readStorage('token');
    var url = '$baseUrl/auth/get-one';

    // var newToken = await SecureStorages().readStorage('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    // print('Header === $headers');
    // var newHeaders = {
    //   'Authorization': 'Bearer $newToken',
    // };

    // var newHeader = newHeaders ? newHeaders : headers;

    // print('New Header === $newHeaders');
    var response = await http.get(
      Uri.parse(url),
      // headers: newHeaders.isNotEmpty ? newHeaders : headers,
      headers: headers,
    );

    print('Data = ${response.body}');

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(jsonDecode(response.body));
      return user;
    } else if (response.statusCode == 401 && response.statusCode == 404) {
      // var token = await SecureStorages().readStorage('token');
      print('expire bos');
      // await refreshToken();
      await SecureStorages().deleteKey('token');
    } else {
      var data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  // Future<void> refreshToken() async {
  //   var refresh = await SecureStorages().readStorage('refresh');

  //   var url = '$baseUrl/auth/token-refresh';
  //   var headers = {
  //     'Authorization': 'Bearer $refresh',
  //   };
  //   var response = await http.post(
  //     Uri.parse(url),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body)['token'];
  //     await SecureStorages().setStorage('token', data);
  //     print('New Token = $data');

  //     return data;
  //   } else {
  //     // await SecureStorages().deleteKey('token');
  //     print('expire 2');
  //     throw Exception('error boss');
  //   }
  // }
}
