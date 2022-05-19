part of 'ukt_cubit.dart';

abstract class UktState extends Equatable {
  const UktState();

  @override
  List<Object> get props => [];
}

class UktInitial extends UktState {}

class UktLaoding extends UktState {}

class UktSuccess extends UktState {
  final UjiUktModel ujiUkt;

  UktSuccess(this.ujiUkt);

  @override
  List<Object> get props => [ujiUkt];
}

class UktFailed extends UktState {
  final String error;

  UktFailed(this.error);

  @override
  List<Object> get props => [error];
}
