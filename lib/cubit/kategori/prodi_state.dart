part of 'prodi_cubit.dart';

abstract class ProdiState extends Equatable {
  const ProdiState();

  @override
  List<Object> get props => [];
}

class ProdiInitial extends ProdiState {}

class ProdiLoading extends ProdiState {}

class ProdiSucces extends ProdiState {
  final List<ProdiModel> prodiModel;

  ProdiSucces(this.prodiModel);

  @override
  List<Object> get props => [prodiModel];
}

class ProdiFailed extends ProdiState {
  final String error;

  ProdiFailed(this.error);

  @override
  List<Object> get props => [error];
}
