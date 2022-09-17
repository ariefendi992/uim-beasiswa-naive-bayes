// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends Equatable {
  final int? id;
  final String? stambuk;
  final String? nama;
  final String? prodi;
  final String? gender;
  final String? picture;
  final String? email;
  final String? password;
  final String? berkas;
  final String? statusBerkas;

  UserModel(
      {required this.id,
      required this.stambuk,
      required this.nama,
      required this.prodi,
      required this.gender,
      required this.picture,
      required this.email,
      required this.password,
      this.berkas = '',
      this.statusBerkas = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        stambuk: json['stambuk'],
        prodi: json['prodi'],
        nama: json['nama'],
        gender: json['gender'],
        picture: json['picture'],
        email: json['email'],
        password: json['password'],
        berkas: json['berkas'],
        statusBerkas: json['status_berkas']);
  }

  Map<String, dynamic> toJson() => {
        'stambuk': stambuk,
        'nama': nama,
        'prodi': prodi,
        'gender': gender,
        'email': email,
        'password': password,
      };
  // List<UserModel> userModelFromJson(jsonData) {
  //   List<UserModel> result = List<UserModel>.from(
  //     jsonData.map(
  //       (item) => UserModel.fromJson(item),
  //     ),
  //   );
  //   return result;
  // }

  @override
  List<Object?> get props => [
        id,
        stambuk,
        prodi,
        nama,
        gender,
        picture,
        email,
        password,
        berkas,
        statusBerkas,
      ];
}
