import 'package:agenda/entity/job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobAdapter {
  JobAdapter._();

  static List<Job> fromJson(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> collectionSnapshot) {
    final List<Job> usersJob = collectionSnapshot
        .map((docSnapshot) => Job(
              name: docSnapshot["name"],
              endTime: docSnapshot["endTime"],
              startTime: docSnapshot["startTime"],
            ))
        .toList();

    return usersJob;
  }

  static Map<String, dynamic> toJson(Job job) {
    return {
      "name": job.name,
      "startTime": job.startTime,
      "endTime": job.endTime,
    };
  }
}
