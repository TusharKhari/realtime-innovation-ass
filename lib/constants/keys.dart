import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackKey =
    GlobalKey<ScaffoldMessengerState>();

const String currentEmployeeBoxName = 'current-employee-box';
const String previousEmployeeBoxName = 'previous-employee-box';
