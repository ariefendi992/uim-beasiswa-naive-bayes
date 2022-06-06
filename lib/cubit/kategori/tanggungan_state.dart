part of 'tanggungan_cubit.dart';

abstract class TanggunganState extends Equatable {
  const TanggunganState();

  @override
  List<Object> get props => [];
}

class TanggunganInitial extends TanggunganState {}

class TanggunganLoading extends TanggunganState {}

class TanggunganSucces extends TanggunganState {
  final List<TanggunganModel> tanggungan;

  TanggunganSucces(this.tanggungan);

  @override
  List<Object> get props => [tanggungan];
}

class TanggunganFailed extends TanggunganState {
  final String error;

  TanggunganFailed(this.error);

  @override
  List<Object> get props => [error];
}
