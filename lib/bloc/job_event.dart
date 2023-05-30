part of 'job_bloc.dart';

@immutable
abstract class JobEvent {}

class UpdateBetterJobCombinationEvent extends JobEvent {}

class AddJobEvent extends JobEvent {
  final Job job;

  AddJobEvent(this.job);
}

class FetchJobListEvent extends JobEvent {}
