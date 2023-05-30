part of 'job_bloc.dart';

class JobState extends Equatable {
  final List<Job> allJobs;
  final List<Job> betterJobs;

  const JobState({
    this.allJobs = const [],
    this.betterJobs = const [],
  });

  JobState copyWith(
    List<Job>? allJobs,
    List<Job>? betterJobs,
  ) {
    return JobState(
      allJobs: allJobs ?? this.allJobs,
      betterJobs: betterJobs ?? this.betterJobs,
    );
  }

  @override
  List<Object?> get props => [allJobs, betterJobs];
}
