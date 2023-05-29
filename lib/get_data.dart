import 'package:agenda/adapter.dart';
import 'package:agenda/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetData {
  GetData();

  Future<List<Job>> getJobs() async {
    late List<Job> jobsList;
    final data = await db.collection("jobs").get();
    jobsList = JobAdapter.fromJson(data.docs);
    return jobsList;
  }
}

class Job {
  final String name;

  Job({required this.name});
}
