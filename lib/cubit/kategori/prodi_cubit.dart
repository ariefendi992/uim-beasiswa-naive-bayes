import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/prodi_model.dart';

part 'prodi_state.dart';

class ProdiCubit extends Cubit<ProdiState> {
  ProdiCubit() : super(ProdiInitial());

  void getProdi() async {
    
  }
}
