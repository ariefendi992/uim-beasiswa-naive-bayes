import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/tanggungan_model.dart';
import 'package:ft_uim_naive_bayes/services/kategori_service.dart';

part 'tanggungan_state.dart';

class TanggunganCubit extends Cubit<TanggunganState> {
  TanggunganCubit() : super(TanggunganInitial());

  void fetchTanggungan() async {
    try {
      emit(TanggunganLoading());
      List<TanggunganModel> result = await KategoriService().fecthTanggungan();
      emit(TanggunganSucces(result));
    } catch (e) {
      emit(TanggunganFailed(e.toString()));
    }
  }
}
