part of 'semester_cubit.dart';

abstract class SemesterState extends Equatable {
  const SemesterState();

  @override
  List<Object> get props => [];
}

class SemesterInitial extends SemesterState {}

class SemesterLoading extends SemesterState {}

class SemesterSuccess extends SemesterState {
  final SemesterModel semester;

  SemesterSuccess(this.semester);

  @override
  List<Object> get props => [semester];
}

class SemesterFailed extends SemesterState {
  final String error;

  SemesterFailed(this.error);

  @override
  List<Object> get props => [error];
}
