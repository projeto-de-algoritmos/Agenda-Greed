import 'package:agenda/bloc/job_bloc.dart';
import 'package:agenda/components/add_job_modal.dart';
import 'package:agenda/get_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

GetData dataRepo = GetData();
late final FirebaseFirestore db;
JobBloc jobBloc = JobBloc();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  db = FirebaseFirestore.instance;
  runApp(BlocProvider(
    create: (context) => jobBloc,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    jobBloc.add(FetchJobListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Agendador")),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state.betterJobs.isEmpty && state.allJobs.isNotEmpty) {
            jobBloc.add(UpdateBetterJobCombinationEvent());
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 14,
              ),
              const Text("Todas tarefas"),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: state.allJobs.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JobWidget(
                        name: state.allJobs[index].name!,
                        endTime: state.allJobs[index].endTime.toString(),
                        startTime: state.allJobs[index].startTime.toString(),
                        width: 150,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text("Melhores opções"),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: Colors.green,
                  height: 100,
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      itemCount: state.betterJobs.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: JobWidget(
                            name: state.betterJobs[index].name!,
                            endTime: state.betterJobs[index].endTime.toString(),
                            startTime:
                                state.betterJobs[index].startTime.toString(),
                            height: 150,
                            width: 150,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () async {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const AddJobModal();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class JobWidget extends StatelessWidget {
  final String name;
  final String endTime;
  final String startTime;
  final double? width;
  final double? height;
  const JobWidget({
    super.key,
    required this.name,
    this.width,
    this.height,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      width: width ?? 60,
      height: height ?? 60,
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                name,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                startTime,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                endTime,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
