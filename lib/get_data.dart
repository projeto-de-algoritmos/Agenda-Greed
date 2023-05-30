import 'package:agenda/adapter/adapter.dart';
import 'package:agenda/entity/job.dart';
import 'package:agenda/main.dart';

class GetData {
  GetData();

  Future<List<Job>> getJobs() async {
    late List<Job> jobsList;
    final data = await db.collection("jobs").get();
    jobsList = JobAdapter.fromJson(data.docs);
    return jobsList;
  }
}
