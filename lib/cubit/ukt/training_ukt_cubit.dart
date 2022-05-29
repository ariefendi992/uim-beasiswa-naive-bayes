import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/training_ukt.dart';
import 'package:ft_uim_naive_bayes/services/ukt_service.dart';

part 'training_ukt_state.dart';

class TrainingUktCubit extends Cubit<TrainingUktState> {
  TrainingUktCubit() : super(TrainingUktInitial());

  void fetchUkt() async {
    try {
      emit(TrainingUktLoading());
      List<TrainingUktModel> trainingUkt = await UktService().fetchUkt();
      emit(TrainingUktSuccess(trainingUkt));
    } catch (e) {
      emit(TrainingUktFailed(e.toString()));
    }
  }
}
