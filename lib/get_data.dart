import 'package:agenda/adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late final FirebaseFirestore db;

class GetData {
  GetData() {
    db = FirebaseFirestore.instance;
  }

  Future<List<Job>> getJobs() async {
    List<Job> jobsList = [];
    final data = await db.collection("jobs").get();
    for (var jobInJson in data.docs) {
      jobsList.add(JobAdapter.fromJson(jobInJson));
    }
    return jobsList;
  }
}

class Job {}
