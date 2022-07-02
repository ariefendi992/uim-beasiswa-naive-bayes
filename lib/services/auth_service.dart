import 'dart:async';
import 'dart:convert';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/models/user_model.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Timer? authTimer;

  Future<UserModel> register({
    String? stambuk,
    String? nama,
    String? prodi,
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
      'prodi': prodi,
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

      await SecureStorages().setStorage('token', data['token']);
      await SecureStorages().setStorage('id_user', data['id'].toString());
      await SecureStorages().setStorage('timeSecond', data['expire']);

      DateTime setTimeString =
          DateTime.now().add(Duration(seconds: int.parse(data['expire'])));

      print('date String === $setTimeString');

      await SecureStorages().setStorage('timeExpire', setTimeString.toString());

      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      var data = jsonDecode(response.body);
      throw data['error'];
      // throw Exception(
      //     'Gagal login url : $url, status : ${response.statusCode}');
    }
  }

  Future<void> signOut() async {
    try {
      await SecureStorages().deleteKey('token');
      await SecureStorages().deleteAll();
    } catch (e) {
      throw e;
    }
  }

  void autoLogOut() async {
    var readString = await SecureStorages().readStorage('timeSecond');

    DateTime tempExpireDate =
        DateTime.now().add(Duration(seconds: int.parse(readString!)));
    // DateTime tempExpireDate = DateTime.now().add(Duration(seconds: 20));

    print('date time == $tempExpireDate');

    final timeToExpire = tempExpireDate.difference(DateTime.now()).inSeconds;

    print('Datime now ${DateTime.now()}');

    if (authTimer != null) {
      authTimer!.cancel();
    }

    authTimer = Timer(Duration(seconds: timeToExpire), () async {
      await SecureStorages().deleteKey('token');
      // await signOut();
    });
  }

  Future<UserModel?> getProfil() async {
    var readToken = await SecureStorages().readStorage('token');
    var url = '$baseUrl/auth/get-one';

    var headers = {
      'Authorization': 'Bearer $readToken',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print('Data = ${response.body}');

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(jsonDecode(response.body));
      return user;
    } else if (response.statusCode == 401) {
      await SecureStorages().deleteKey('token');
      print('expire bos ${response.statusCode}');
      await SecureStorages().setStorage('msg', 'expire');
      await refreshToken();
    } else {
      throw Exception('gagal muat data $url, status : ${response.body}');
    }
  }

  Future<void> refreshToken() async {
    var refresh = await SecureStorages().readStorage('refresh');

    var url = '$baseUrl/auth/token-refresh';
    var headers = {
      'Authorization': 'Bearer $refresh',
    };
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['token'];
      await SecureStorages().setStorage('newToken', data);
      print('New Token = $data');

      return data;
    } else {
      // await SecureStorages().deleteKey('token');
      print('expire 2');
      throw Exception('error boss');
    }
  }

  Future<UserModel> checkPassword({
    String? password,
    String? idUser,
  }) async {
    var url = ('$baseUrl/auth/check-password?id=$idUser');
    print('url == $url');
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({'password': password});

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(jsonResp);
      return user;
    } else {
      var jsonResp = jsonDecode(response.body);
      throw jsonResp['msg'];
    }
  }

  Future<UserModel> updatePassword({
    String? idUser,
    String? password,
  }) async {
    var url = baseUrl + '/auth/update-password?id=$idUser';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'password': password});

    var response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      var jsonResp = jsonDecode(response.body);
      UserModel users = UserModel.fromJson(jsonResp);
      return users;
    } else {
      throw Exception(
          'Gagal update password $url, status ${response.statusCode}');
    }
  }
}
