import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarManagementController extends GetxController {
  CalendarController calendarController = CalendarController();

  RxString selectedDate = DateFormat('dd MMM yyyy').format(DateTime.now()).obs;
  List calendarStartTopBtnNames =
      ['Today', 'Next Monday', 'Next Tuesday', 'After 1 week'].obs;
  List calendarEndTopBtnNames = [
    'No Date',
    'Today',
  ].obs;

  RxList<bool> isSelected = [false, false, false, false].obs;
  DateTime? saveDateTime = DateTime.now();
  RxString headerMonthYear = ''.obs;

  @override
  void onInit() {
    monthAndYearConvert();
    super.onInit();
  }

  void onTapCalendarCellDate() {
    selectedDate.value =
        DateFormat('dd MMM yyyy').format(calendarController.selectedDate!);
    saveDateTime = calendarController.selectedDate!;
  }

  void onTapEndCalendarHeaderDate(int index) {
    isSelected.value = [false, false, false, false];
    isSelected[index] = true;
    if (index == 0) {
      calendarController.selectedDate = DateTime.now();
      calendarController.displayDate = DateTime.now();
      selectedDate.value = '';
      saveDateTime = null;
    } else {
      calendarController.selectedDate = DateTime.now();
      calendarController.displayDate = DateTime.now();
      selectedDate.value = DateFormat('dd MMM yyyy').format(DateTime.now());
      saveDateTime = DateTime.now();
    }
  }

  void onTapStartCalendarHeaderDate(int index) {
    isSelected.value = [false, false, false, false];
    isSelected[index] = true;
    if (index == 0) {
      calendarController.selectedDate = DateTime.now();
      calendarController.displayDate = DateTime.now();
      selectedDate.value = DateFormat('dd MMM yyyy').format(DateTime.now());
      saveDateTime = DateTime.now();
    } else if (index == 1) {
      calendarController.selectedDate = DateTime.now().next(1);
      calendarController.displayDate = DateTime.now().next(1);
      selectedDate.value =
          DateFormat('dd MMM yyyy').format(DateTime.now().next(1));
      saveDateTime = DateTime.now().next(1);
    } else if (index == 2) {
      calendarController.selectedDate = DateTime.now().next(2);
      calendarController.displayDate = DateTime.now().next(2);
      selectedDate.value =
          DateFormat('dd MMM yyyy').format(DateTime.now().next(2));
      saveDateTime = DateTime.now().next(2);
    } else {
      DateTime aW = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 7);
      calendarController.selectedDate = aW;
      calendarController.displayDate = aW;
      selectedDate.value = DateFormat('dd MMM yyyy').format(aW);
      saveDateTime = aW;
    }
  }

  void monthAndYearConvert({DateTime? dateTime}) {
    dateTime ??= DateTime.now();
    switch (dateTime.month) {
      case 0:
        headerMonthYear.value = 'January ${dateTime.year}';
        break;
      case 1:
        headerMonthYear.value = 'February ${dateTime.year}';
        break;
      case 3:
        headerMonthYear.value = 'March ${dateTime.year}';
        break;
      case 4:
        headerMonthYear.value = 'April ${dateTime.year}';
        break;
      case 5:
        headerMonthYear.value = 'May ${dateTime.year}';
        break;
      case 6:
        headerMonthYear.value = 'June ${dateTime.year}';
        break;
      case 7:
        headerMonthYear.value = 'July ${dateTime.year}';
        break;
      case 8:
        headerMonthYear.value = 'August ${dateTime.year}';
        break;
      case 9:
        headerMonthYear.value = 'September ${dateTime.year}';
        break;
      case 10:
        headerMonthYear.value = 'October ${dateTime.year}';
        break;
      case 11:
        headerMonthYear.value = 'November ${dateTime.year}';
        break;
      case 12:
        headerMonthYear.value = 'December ${dateTime.year}';
        break;
      default:
        headerMonthYear.value = 'January ${dateTime.year}';
        break;
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    if (day == weekday) {
      return add(const Duration(days: 7));
    } else {
      return add(
        Duration(
          days: (day - weekday) % DateTime.daysPerWeek,
        ),
      );
    }
  }

  DateTime previous(int day) {
    if (day == weekday) {
      return subtract(const Duration(days: 7));
    } else {
      return subtract(
        Duration(
          days: (weekday - day) % DateTime.daysPerWeek,
        ),
      );
    }
  }
}
