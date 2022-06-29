import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/hasil_ukt_model.dart';
import 'package:ft_uim_naive_bayes/services/ukt_service.dart';

part 'hasil_ukt_state.dart';

class HasilUktCubit extends Cubit<HasilUktState> {
  HasilUktCubit() : super(HasilUktInitial());

  void fetchOneUkt({required String idUser}) async {
    try {
      emit(HasilUktLoading());
      List<HasilUktModel> uktHasil =
          await UktService().fetchOne(idUser: idUser);
      emit(HasilUktSuccess(uktHasil));
    } catch (e) {
      emit(HasilUkFailed(e.toString()));
    }
  }
}
