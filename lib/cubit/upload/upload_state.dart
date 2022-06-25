part of 'upload_cubit.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  // final int idUser;
  // final dynamic fieldName;
  // final dynamic imageFile;

  // UploadSuccess(this.idUser, this.fieldName, this.imageFile);
  final UploadModel upload;
  UploadSuccess(this.upload);

  @override
  // List<Object> get props => [idUser, fieldName, imageFile];
  List<Object> get props => [upload];
}

class UploadFailed extends UploadState {
  final String error;

  UploadFailed(this.error);

  @override
  List<Object> get props => [error];
}
