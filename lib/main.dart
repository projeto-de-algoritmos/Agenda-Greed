import 'package:agenda/adapter.dart';
import 'package:agenda/get_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

GetData dataRepo = GetData();
late final FirebaseFirestore db;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  db = FirebaseFirestore.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Agenda")),
      ),
      body: FutureBuilder(
          future: db.collection("jobs").get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final jobList = JobAdapter.fromJson(snapshot.data!.docs);
              return ListView(
                scrollDirection: Axis.horizontal,
                children: jobList
                    .map((e) => JobWidget(
                          name: e.name,
                        ))
                    .toList(),
              );
            }
            return const JobWidget(
              name: "TEste",
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await db.collection('jobs').doc().set({"name": "Algo"});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class JobWidget extends StatelessWidget {
  final String name;
  const JobWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 60,
      height: 60,
      child: Center(
        child: Text(
          name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String name;
  const JobCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Card(
        color: Colors.red,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.more_vert),
              ),
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(name),
              )
            ],
          ),
        ),
      ),
    );
  }
}
