import 'package:agenda/bloc/job_bloc.dart';
import 'package:agenda/components/text_fields.dart';
import 'package:agenda/entity/job.dart';
import 'package:agenda/main.dart';
import 'package:flutter/material.dart';

class AddJobModal extends StatefulWidget {
  const AddJobModal({super.key});

  @override
  State<AddJobModal> createState() => _AddJobModalState();
}

class _AddJobModalState extends State<AddJobModal> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Job _job = const Job(name: null, startTime: null, endTime: null);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber,
                ),
                height: 4,
                width: 64,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 12,
              left: 12,
            ),
            child: Text(
              "Text",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            thickness: 1,
            height: 0,
          ),
          // add textfields
          NameField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Name",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.green,
                ),
              ),
            ),
            cursorColor: Colors.green,
            controller: nameController,
            onSaved: (name) {
              _job = _job.copyWith(name: name);
            },
          ),
          StartTimeField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Start Time",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.green,
                ),
              ),
            ),
            cursorColor: Colors.green,
            controller: startTimeController,
            onSaved: (startTime) {
              _job = _job.copyWith(startTime: int.parse(startTime!));
            },
            /* validator: (string) => jobValidator(string!), */
          ),
          EndTimeField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "End Time",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.green,
                ),
              ),
            ),
            cursorColor: Colors.green,
            controller: endTimeController,
            onSaved: (string) {
              _job = _job.copyWith(endTime: int.parse(string!));
            },
            /* validator: (string) => jobValidator(string!), */
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              formKey.currentState!.save();
              //todo bloc
              jobBloc.add(AddJobEvent(_job));
              jobBloc.add(FetchJobListEvent());
              jobBloc.add(UpdateBetterJobCombinationEvent());
              Navigator.of(context).pop();
            },
            child: const Center(child: Text("Send Job")),
          ),
        ],
      ),
    );
  }
}
