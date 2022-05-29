import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/uji_ukt_model.dart';
import 'package:ft_uim_naive_bayes/services/ukt_service.dart';

part 'ukt_state.dart';

class UktCubit extends Cubit<UktState> {
  UktCubit() : super(UktInitial());

  void ujiUkt({
    required int idProdi,
    required int idSemester,
    required String statusMhs,
    required String kip,
    required int idPenghasilan,
    required String tanggungan,
    required String pkh,
  }) async {
    try {
      emit(UktLaoding());

      UjiUktModel ujiUkt = await UktService().ujiData(
        idProdi: idProdi,
        idSemester: idSemester,
        statusMhs: statusMhs,
        kip: kip,
        idPenghasilan: idPenghasilan,
        tanggungan: tanggungan,
        pkh: pkh,
      );

      emit(UktSuccess(ujiUkt));
    } catch (e) {
      emit(UktFailed(e.toString()));
    }
  }


}
