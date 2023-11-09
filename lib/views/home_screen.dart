import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:real_time_innovation/constants/app_string.dart';
import 'package:real_time_innovation/constants/colors.dart';
import 'package:real_time_innovation/constants/image_paths.dart';
import 'package:real_time_innovation/constants/keys.dart';
import 'package:real_time_innovation/model/employee_model.dart';
import 'package:real_time_innovation/service/db_service.dart';
import 'package:real_time_innovation/routes/route_name.dart';
import 'package:real_time_innovation/utils/snack_messages.dart';
import 'package:real_time_innovation/utils/text_styles.dart';
import 'package:real_time_innovation/views/add_employee_screen/route_model/route_model.dart';
import 'package:real_time_innovation/widgets/common_app_bar/common_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final DBService _dbService = DBService();
  Box<EmployeeModel>? temp;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(appBarTitle: AppString.kEmployeList),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          ImagePaths.plusIcon,
          width: 18,
          height: 18,
        ),
        onPressed: () {
          navigatorKey.currentState!.pushNamed(RouteNames.addOrEditEmployee);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 56,
              width: size.width,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.kBorderColor,
              ),
              child: Text(
                AppString.kCurrentEmployeeTitle,
                style: TextStyles.kFontStyleW500S16.copyWith(
                  color: AppColors.kDefaultAppColorBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _dbService.currentEmployeeBox.listenable(),
              builder: (_, Box<EmployeeModel> value, __) {
                return Column(
                  children: List.generate(
                    value.length,
                    (index) {
                      return SwipeListTile(
                        obejctKey: ObjectKey(index),
                        employeeName: value.getAt(index)!.employeeName,
                        employeeType: value.getAt(index)!.employeeType,
                        dateTime: value.getAt(index)!.startDateTime,
                        onClickDelete: (v) async {
                          v;
                          temp = _dbService.currentEmployeeBox;
                          // _dbService.currentEmployeeBox.deleteAt(index);
                          print(value.getAt(index)!.employeeName);
                          SnackMessages.showSnackMessgae(
                            msg: 'Employee data has been deleted',
                            btnName: 'undo',
                            onPressed: () async {
                              print("object");
                              
                            },
                          );
                        },
                        onClickEdit: () async {
                          navigatorKey.currentState!.pushNamed(
                            RouteNames.addOrEditEmployee,
                            arguments: AddEmployeeRouteModel(
                              employeeName: value.getAt(index)!.employeeName,
                              employeeType: value.getAt(index)!.employeeType,
                              startDate: value.getAt(index)!.startDateTime,
                              hiveBoxIndex: index,
                              isCurrentEmployee: true,
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                );
              },
            ),
            Container(
              height: 56,
              width: size.width,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.kBorderColor,
              ),
              child: Text(
                AppString.kPreviousEmployeeTitle,
                style: TextStyles.kFontStyleW500S16.copyWith(
                  color: AppColors.kDefaultAppColorBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _dbService.previousEmployeeBox.listenable(),
              builder: (_, Box<EmployeeModel> value, __) {
                return Column(
                  children: List.generate(
                    value.length,
                    (index) {
                      return SwipeListTile(
                        obejctKey: ObjectKey(index),
                        employeeName: value.getAt(index)!.employeeName,
                        employeeType: value.getAt(index)!.employeeType,
                        dateTime: value.getAt(index)!.startDateTime,
                        onClickDelete: (v) async {
                          _dbService.previousEmployeeBox.deleteAt(index);
                          SnackMessages.showSnackMessgae(
                            msg: 'Employee data has been deleted',
                            btnName: 'undo',
                            onPressed: () async {},
                          );
                        },
                        onClickEdit: () async {
                          navigatorKey.currentState!.pushNamed(
                            RouteNames.addOrEditEmployee,
                            arguments: AddEmployeeRouteModel(
                              employeeName: value.getAt(index)!.employeeName,
                              employeeType: value.getAt(index)!.employeeType,
                              startDate: value.getAt(index)!.startDateTime,
                              endDate: value.getAt(index)!.endDateTime,
                              hiveBoxIndex: index,
                              isCurrentEmployee: false,
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeListTile extends StatelessWidget {
  final String employeeName;
  final String employeeType;
  final DateTime dateTime;
  final Function(CompletionHandler) onClickDelete;
  final Function() onClickEdit;
  final Key obejctKey;
  const SwipeListTile({
    super.key,
    required this.obejctKey,
    required this.employeeName,
    required this.employeeType,
    required this.dateTime,
    required this.onClickDelete,
    required this.onClickEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: obejctKey,
      trailingActions: <SwipeAction>[
        SwipeAction(
          onTap: (CompletionHandler handler) async =>
              await onClickDelete(handler),
          color: const Color(0xffF34642),
          content: Image.asset(
            ImagePaths.deleteIcon,
            width: 17.12,
            height: 18,
          ),
        ),
      ],
      leadingActions: [
        SwipeAction(
          onTap: (CompletionHandler handler) async => await onClickEdit(),
          color: Colors.green,
          content: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        height: 104,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employeeName,
              style: TextStyles.kFontStyleW500S16.copyWith(
                color: AppColors.kLightBlackColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              employeeType,
              style: TextStyles.kFontStyleW500S16.copyWith(
                color: const Color(0xff949C9E),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              DateFormat('dd MMMM yyyy').format(dateTime),
              style: TextStyles.kFontStyleW500S16.copyWith(
                color: const Color(0xff949C9E),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
