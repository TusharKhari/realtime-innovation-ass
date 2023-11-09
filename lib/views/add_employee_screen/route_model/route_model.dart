class AddEmployeeRouteModel {
  final String employeeName;
  final String employeeType;
  final DateTime startDate;
  final DateTime? endDate;
  final int hiveBoxIndex;
  final bool isCurrentEmployee;

  AddEmployeeRouteModel({
    required this.employeeName,
    required this.employeeType,
    required this.startDate,
    this.endDate,
    required this.hiveBoxIndex,
    required this.isCurrentEmployee,
  });
}
