import 'package:agenda/get_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobAdapter {
  JobAdapter._();

  static List<Job> fromJson(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> collectionSnapshot) {
    final List<Job> usersJob = collectionSnapshot
        .map((docSnapshot) => Job(name: docSnapshot["name"]))
        .toList();

    return usersJob;
  }
}
