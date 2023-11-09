import 'package:hive/hive.dart';
// part 'employee_model.g.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel {
  @HiveField(0)
  final String employeeName;
  @HiveField(1)
  final String employeeType;
  @HiveField(2)
  final DateTime startDateTime;
  @HiveField(3, defaultValue: null)
  DateTime? endDateTime;

  EmployeeModel({
    required this.employeeName,
    required this.employeeType,
    required this.startDateTime,
    this.endDateTime,
  });
}
