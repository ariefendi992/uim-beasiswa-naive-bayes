import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/semester_model.dart';
import 'package:ft_uim_naive_bayes/services/kategori_service.dart';

part 'semester_state.dart';

class SemesterCubit extends Cubit<SemesterState> {
  SemesterCubit() : super(SemesterInitial());

  void fetchSemester() async {
    try {
      emit(SemesterLoading());
      List<SemesterModel> semesters = await KategoriService().fetchSemester();
      print('semster $semesters');
      // emit(SemesterSuccess(semesters));
    } catch (e) {
      emit(SemesterFailed(e.toString()));
    }
  }
}
