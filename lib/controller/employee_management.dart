import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:real_time_innovation/constants/app_string.dart';
import 'package:real_time_innovation/constants/keys.dart';
import 'package:real_time_innovation/controller/calendar_controller.dart';
import 'package:real_time_innovation/service/db_service.dart';
import 'package:real_time_innovation/model/employee_model.dart';

class EmployeeManagement extends GetxController {
  final DBService _dbController = DBService();
  final _calendarManagementController =
      Get.find<CalendarManagementController>();
  TextEditingController selectRoleTextEditingController =
      TextEditingController();
  TextEditingController employeeNameTextEditingController =
      TextEditingController();
  DateTime startDate = DateTime.now();
  RxString startDateView = AppString.kTodayHintText.obs;

  DateTime? endDate;
  String? endDateView;

  EmployeeModel? _previousEmployeTempData;
  EmployeeModel? _currentEmployeTempData;

  void setEmployeeRole(String val) {
    selectRoleTextEditingController.text = val;
    navigatorKey.currentState!.pop();
  }

  Future<void> saveEmployeCurrentData() async {
    await _dbController.addCurrentEmployeeToBox(
      employeeModel: EmployeeModel(
        employeeName: employeeNameTextEditingController.text,
        employeeType: selectRoleTextEditingController.text,
        startDateTime: startDate,
      ),
    );
    selectRoleTextEditingController.clear();
    employeeNameTextEditingController.clear();
    startDate = DateTime.now();
    endDate = null;
    endDateView = null;
    startDateView.value = AppString.kTodayHintText;
  }

  Future<void> updateEmployeCurrentData(int index) async {
    await _dbController.updateCurrentEmployeeData(
      index: index,
      employeeData: EmployeeModel(
        employeeName: employeeNameTextEditingController.text,
        employeeType: selectRoleTextEditingController.text,
        startDateTime: startDate,
      ),
    );
    selectRoleTextEditingController.clear();
    employeeNameTextEditingController.clear();
    startDate = DateTime.now();
    endDate = null;
    endDateView = null;
    startDateView.value = AppString.kTodayHintText;
  }

  Future<void> saveEmployePreviousData() async {
    await _dbController.addPreviousEmployeeToBox(
      employeeModel: EmployeeModel(
        employeeName: employeeNameTextEditingController.text,
        employeeType: selectRoleTextEditingController.text,
        startDateTime: startDate,
        endDateTime: endDate,
      ),
    );
    selectRoleTextEditingController.clear();
    employeeNameTextEditingController.clear();
    startDate = DateTime.now();
    endDate = null;
    endDateView = null;
    startDateView.value = AppString.kTodayHintText;
  }

  Future<void> updateEmployePreviousData(int index) async {
    await _dbController.updatePreviousEmployeeData(
      index: index,
      employeeData: EmployeeModel(
        employeeName: employeeNameTextEditingController.text,
        employeeType: selectRoleTextEditingController.text,
        startDateTime: startDate,
        endDateTime: endDate,
      ),
    );
    selectRoleTextEditingController.clear();
    employeeNameTextEditingController.clear();
    startDate = DateTime.now();
    endDate = null;
    endDateView = null;
    startDateView.value = AppString.kTodayHintText;
  }

  void setCurrentDate(DateTime dateTime) {
    startDate = dateTime;
    if (startDate.year == DateTime.now().year &&
        startDate.month == DateTime.now().month &&
        startDate.day == DateTime.now().day) {
      startDateView.value = AppString.kTodayHintText;
    } else {
      startDateView.value = DateFormat('dd MMM yyyy').format(startDate);
    }
  }

  void setEndDate(DateTime? dateTime) {
    if (dateTime != null) {
      endDate = dateTime;
    }
    if (dateTime == null) {
      endDateView = '';
    } else if (endDate!.year == DateTime.now().year &&
        endDate!.month == DateTime.now().month &&
        endDate!.day == DateTime.now().day) {
      endDateView = AppString.kTodayHintText;
    } else {
      endDateView = DateFormat('dd MMM yyyy').format(endDate!);
    }
  }
}
