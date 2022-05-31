import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/prodi_model.dart';
import 'package:ft_uim_naive_bayes/services/kategori_service.dart';

part 'prodi_state.dart';

class ProdiCubit extends Cubit<ProdiState> {
  ProdiCubit() : super(ProdiInitial());

  void fetchProdi() async {
    try {
      emit(ProdiLoading());
      List<ProdiModel> prodiModel = await KategoriService().getProdi();
      emit(ProdiSucces(prodiModel));
    } catch (e) {
      emit(ProdiFailed(e.toString()));
    }
  }
}
