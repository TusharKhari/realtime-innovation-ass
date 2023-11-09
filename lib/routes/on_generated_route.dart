import 'package:flutter/material.dart';
import 'package:real_time_innovation/routes/route_name.dart';
import 'package:real_time_innovation/views/add_employee_screen/add_employee_screen.dart';
import 'package:real_time_innovation/views/add_employee_screen/route_model/route_model.dart';
import 'package:real_time_innovation/views/home_screen.dart';

class OnGeneratedRoute {
  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteNames.addOrEditEmployee:
        return MaterialPageRoute(
            builder: (_) => AddEmployeeScreen(
                  routeData: args as AddEmployeeRouteModel?,
                ));
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
