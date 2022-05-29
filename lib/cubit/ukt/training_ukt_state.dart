part of 'training_ukt_cubit.dart';

abstract class TrainingUktState extends Equatable {
  const TrainingUktState();

  @override
  List<Object> get props => [];
}

class TrainingUktInitial extends TrainingUktState {}

class TrainingUktLoading extends TrainingUktState {}

class TrainingUktSuccess extends TrainingUktState {
  final List<TrainingUktModel> trainingUktModel;

  TrainingUktSuccess(this.trainingUktModel);

  @override
  List<Object> get props => [trainingUktModel];
}

class TrainingUktFailed extends TrainingUktState {
  final String error;

  TrainingUktFailed(this.error);

  @override
  List<Object> get props => [error];
}
