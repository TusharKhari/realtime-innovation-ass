import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_time_innovation/constants/colors.dart';
import 'package:real_time_innovation/constants/keys.dart';
import 'package:real_time_innovation/controller/calendar_controller.dart';
import 'package:real_time_innovation/controller/employee_management.dart';
import 'package:real_time_innovation/model/employee_model.dart';
import 'package:real_time_innovation/routes/on_generated_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeModelAdapter());
  await Hive.openBox<EmployeeModel>(currentEmployeeBoxName);
  await Hive.openBox<EmployeeModel>(previousEmployeeBoxName);
  Get.put(CalendarManagementController());
  Get.put(EmployeeManagement());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Focus.of(context).unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: snackKey,
        theme: ThemeData(
          primaryColor: AppColors.kDefaultAppColorBlue,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        onGenerateRoute: OnGeneratedRoute.onGeneratedRoute,
      ),
    );
  }
}
