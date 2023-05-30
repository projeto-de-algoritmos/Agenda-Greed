import 'package:agenda/adapter/adapter.dart';
import 'package:agenda/entity/job.dart';
import 'package:agenda/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(const JobState()) {
    on<UpdateBetterJobCombinationEvent>((event, emit) {
      if (state.allJobs.isEmpty) return;

      Job? lastJobByFinishTime;
      List<Job> solution = [];
      List<Job> jobsList = state.allJobs;

      jobsList.sort((firstJob, secondJob) =>
          firstJob.endTime!.compareTo(secondJob.endTime!));
      print("Sorted list of jobs by endtime: ${state.allJobs}");
      // Add first Job on the solution
      solution.add(state.allJobs.first);

      for (int i = 1; i < jobsList.length; i++) {
        Job currentJob = jobsList[i];
        // take last job on solution
        lastJobByFinishTime = solution.last;
        if (isCompative(currentJob, lastJobByFinishTime)) {
          solution.add(currentJob);
        }
      }
      emit(state.copyWith(null, solution));
    });
    on<AddJobEvent>((event, emit) async {
      await db.collection('jobs').doc().set(JobAdapter.toJson(event.job));
    });
    on<FetchJobListEvent>((event, emit) async {
      final snapshot = await db.collection("jobs").get();
      final jobList = JobAdapter.fromJson(snapshot.docs);
      emit(state.copyWith(jobList, null));
      jobBloc.add(UpdateBetterJobCombinationEvent());
    });
  }
}

bool isCompative(Job currentJob, Job lastJobByFinishTime) {
  /* print("Current Job: $currentJob, Last Job: $lastJobByFinishTime \n "); */
  return currentJob.startTime! >= lastJobByFinishTime.endTime!;
}
