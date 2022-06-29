part of 'hasil_ukt_cubit.dart';

abstract class HasilUktState extends Equatable {
  const HasilUktState();

  @override
  List<Object> get props => [];
}

class HasilUktInitial extends HasilUktState {}

class HasilUktLoading extends HasilUktState {}

class HasilUktSuccess extends HasilUktState {
  final List<HasilUktModel> hasilUkt;

  HasilUktSuccess(this.hasilUkt);

  @override
  List<Object> get props => [hasilUkt];
}

class HasilUkFailed extends HasilUktState {
  final String error;

  HasilUkFailed(this.error);

  @override
  List<Object> get props => [error];
}
