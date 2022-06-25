import 'package:equatable/equatable.dart';

class UploadModel extends Equatable {
  final String idUser;

  UploadModel(
    this.idUser,
  );

  @override
  List<Object?> get props => [idUser];
}
