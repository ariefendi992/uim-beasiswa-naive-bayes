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
  final String? email;
  final String? password;

  UserModel({
    required this.id,
    required this.stambuk,
    required this.nama,
    required this.prodi,
    required this.gender,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      stambuk: json['stambuk'],
      prodi: json['prodi'],
      nama: json['nama'],
      gender: json['gender'],
      email: json['email'],
      password: json['password'],
    );
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
  List<Object?> get props =>
      [id, stambuk, prodi, nama, gender, email, password];
}
