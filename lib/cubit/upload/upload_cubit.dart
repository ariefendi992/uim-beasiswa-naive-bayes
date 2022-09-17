import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/upload_model.dart';
import 'package:ft_uim_naive_bayes/services/upload_service.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());

  void uploadImage({
    required String? idUser,
    required dynamic fieldName,
    required File imageFile,
  }) async {
    try {
      emit(UploadLoading());
      await UploadService().uploadImage(
          idUser: idUser, fieldName: fieldName, imageFile: imageFile);

      emit(UploadInitial());
      // emit(uploadImage);
    } catch (e) {
      emit(UploadFailed(e.toString()));
    }
  }

  void uploadPdf({
    required String? idUser,
    required dynamic fieldName,
    required File pdfFile,
  }) async {
    try {
      emit(UploadLoading());
      await UploadService()
          .uploadBerkas(idUser: idUser, fieldName: fieldName, pdfFile: pdfFile);

      // UserModel users =
      //     await UploadService().uploadBerkas(idUser: idUser, pdfFile: pdfFile);

      emit(UploadInitial());
    } catch (e) {
      emit(UploadFailed(e.toString()));
    }
  }
}
