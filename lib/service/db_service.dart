import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_time_innovation/constants/keys.dart';
import 'package:real_time_innovation/model/employee_model.dart';

class DBService {
  final currentEmployeeBox = Hive.box<EmployeeModel>(currentEmployeeBoxName);
  final previousEmployeeBox = Hive.box<EmployeeModel>(previousEmployeeBoxName);

  Future<void> addCurrentEmployeeToBox(
      {required EmployeeModel employeeModel}) async {
    await currentEmployeeBox
        .add(employeeModel)
        .whenComplete(() => debugPrint('Complete'));
  }

  Future<void> addPreviousEmployeeToBox(
      {required EmployeeModel employeeModel}) async {
    await previousEmployeeBox
        .add(employeeModel)
        .whenComplete(() => debugPrint('Complete'));
  }

  Future<void> updateCurrentEmployeeData(
      {required int index, required EmployeeModel employeeData}) async {
    await currentEmployeeBox.putAt(index, employeeData);
  }

  Future<void> updatePreviousEmployeeData(
      {required int index, required EmployeeModel employeeData}) async {
    await previousEmployeeBox.putAt(index, employeeData);
  }

  Future<void> removeCurrentEmployeeData({required int index}) async {
    await currentEmployeeBox.deleteAt(index);
  }

  Future<void> removePreviousEmployeeData({required int index}) async {
    await previousEmployeeBox.deleteAt(index);
  }
}
