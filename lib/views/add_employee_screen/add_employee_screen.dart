import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:real_time_innovation/constants/app_string.dart';
import 'package:real_time_innovation/constants/colors.dart';
import 'package:real_time_innovation/constants/image_paths.dart';
import 'package:real_time_innovation/constants/keys.dart';
import 'package:real_time_innovation/controller/employee_management.dart';
import 'package:real_time_innovation/service/db_service.dart';
import 'package:real_time_innovation/views/add_employee_screen/route_model/route_model.dart';
import 'package:real_time_innovation/views/add_employee_screen/widget/calendar_dialog.dart';
import 'package:real_time_innovation/views/add_employee_screen/widget/employee_role_select_sheet.dart';
import 'package:real_time_innovation/widgets/common_app_bar/common_app_bar.dart';
import 'package:real_time_innovation/widgets/common_elevated_btn/common_elevated_btn.dart';
import 'package:real_time_innovation/widgets/common_text_form_field/common_text_form_field.dart';
import 'package:real_time_innovation/widgets/date_selected_widget/date_selected_widget.dart';

class AddEmployeeScreen extends StatefulWidget {
  final AddEmployeeRouteModel? routeData;
  AddEmployeeScreen({
    super.key,
    this.routeData,
  });

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _employeeManagement = Get.find<EmployeeManagement>();

  final DBService _dbService = DBService();

  @override
  void initState() {
    super.initState();
    if (widget.routeData != null) {
      _employeeManagement.employeeNameTextEditingController =
          TextEditingController(text: widget.routeData!.employeeName);
      _employeeManagement.selectRoleTextEditingController =
          TextEditingController(text: widget.routeData!.employeeType);
      _employeeManagement.setCurrentDate(widget.routeData!.startDate);
      _employeeManagement.setEndDate(widget.routeData!.endDate);
    }
  }

  @override
  void dispose() {
    _employeeManagement.employeeNameTextEditingController.clear();
    _employeeManagement.selectRoleTextEditingController.clear();
    _employeeManagement.endDate = null;
    _employeeManagement.endDateView = null;
    _employeeManagement.startDate = DateTime.now();
    _employeeManagement.startDateView.value = AppString.kTodayHintText;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CommonAppBar(
          appBarTitle: widget.routeData == null
              ? AppString.kAddEmployeeAppBarTitle
              : AppString.kEditEmployee,
          trailingWidget: widget.routeData == null
              ? null
              : GestureDetector(
                  onTap: () {
                    if (widget.routeData!.isCurrentEmployee) {
                      _dbService.removeCurrentEmployeeData(
                          index: widget.routeData!.hiveBoxIndex);
                    } else {
                      _dbService.removePreviousEmployeeData(
                          index: widget.routeData!.hiveBoxIndex);
                    }
                    navigatorKey.currentState!.pop();
                  },
                  child: Image.asset(
                    ImagePaths.deleteIcon,
                    width: 15,
                    height: 16.88,
                  ),
                ),
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CommonTextFormField(
                textEditingController:
                    _employeeManagement.employeeNameTextEditingController,
                hintText: AppString.kEmployeeMentNameHintText,
                prefixWidget: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                  child: Image.asset(
                    ImagePaths.nameIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(height: 23),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    builder: (_) {
                      return EmployeeRoleSelectSheetWidget(
                        size: size,
                        onTap: (val) {
                          _employeeManagement.setEmployeeRole(val);
                        },
                      );
                    },
                  );
                },
                child: CommonTextFormField(
                  isEnable: false,
                  hintText: AppString.kEmployeeMentRoleHintText,
                  textEditingController:
                      _employeeManagement.selectRoleTextEditingController,
                  prefixWidget: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                    child: Image.asset(
                      ImagePaths.roleIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  suffixWidget: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                    child: Image.asset(
                      ImagePaths.dropDownIcon,
                      width: 11.67,
                      height: 6.67,
                      scale: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () {
                      return DateSelectionWidget(
                        hintText: '',
                        valueText: _employeeManagement.startDateView.value,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              insetPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                              content: CalendarDialog(
                                onSave: (DateTime? selectedDate) {
                                  _employeeManagement
                                      .setCurrentDate(selectedDate!);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    ImagePaths.arrowIcon,
                    width: 13.21,
                    height: 9.54,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  // _employeeManagement.endDateView == null
                  //     ?
                  GetBuilder<EmployeeManagement>(
                    builder: (c) {
                      return DateSelectionWidget(
                        hintText: AppString.kNoDateHintText,
                        valueText: _employeeManagement.endDateView ?? '',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              insetPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                              content: CalendarDialog(
                                isStartCalendar: false,
                                onSave: (DateTime? selectedDate) {
                                  _employeeManagement.setEndDate(selectedDate);
                                  c.update();
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(
          bottom: 12,
          top: 12,
        ),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2,
              color: AppColors.kBorderColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonElevatedButton(
              btnName: AppString.kButtonTextCancel,
              btnTextColor: AppColors.kDefaultAppColorBlue,
              btnBgColor: AppColors.kButtonBgLightBlue,
              onPressed: () {
                navigatorKey.currentState!.pop();
              },
            ),
            const SizedBox(width: 16),
            CommonElevatedButton(
              btnName: AppString.kButtonTextSave,
              btnTextColor: Colors.white,
              btnBgColor: AppColors.kDefaultAppColorBlue,
              onPressed: () async {
                if (_employeeManagement.endDate != null) {
                  if (widget.routeData != null &&
                      !widget.routeData!.isCurrentEmployee) {
                    await _employeeManagement.updateEmployePreviousData(
                        widget.routeData!.hiveBoxIndex);
                  } else {
                    await _employeeManagement.saveEmployePreviousData();
                  }
                } else {
                  if (widget.routeData != null &&
                      widget.routeData!.isCurrentEmployee) {
                  } else {
                    await _employeeManagement.saveEmployeCurrentData();
                  }
                }
                navigatorKey.currentState!.pop();
              },
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
