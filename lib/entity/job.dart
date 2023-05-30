import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final String? name;
  final int? startTime;
  final int? endTime;

  int get duration => endTime! - startTime!;

  const Job({
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  Job copyWith({
    String? name,
    int? startTime,
    int? endTime,
  }) {
    return Job(
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [name, startTime, endTime];

  @override
  String toString() {
    return "Name: $name | Start: $startTime | End: $endTime";
  }
}
