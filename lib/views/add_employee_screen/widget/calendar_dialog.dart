import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:real_time_innovation/constants/app_string.dart';
import 'package:real_time_innovation/constants/colors.dart';
import 'package:real_time_innovation/constants/image_paths.dart';
import 'package:real_time_innovation/constants/keys.dart';
import 'package:real_time_innovation/controller/calendar_controller.dart';
import 'package:real_time_innovation/controller/employee_management.dart';
import 'package:real_time_innovation/utils/text_styles.dart';
import 'package:real_time_innovation/widgets/common_elevated_btn/common_elevated_btn.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarDialog extends StatelessWidget {
  final Function(DateTime?) onSave;
  final bool isStartCalendar;
  CalendarDialog({
    super.key,
    required this.onSave,
    this.isStartCalendar = true,
  });

  final _calendarFormatterController = Get.find<CalendarManagementController>();
  final _employeeManagementController = Get.find<EmployeeManagement>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Obx(
                  () => WeekDayBtnWidget(
                    isSelected: !isStartCalendar
                        ? _calendarFormatterController.isSelected[0]
                        : _calendarFormatterController.isSelected[0],
                    btnName: !isStartCalendar
                        ? _calendarFormatterController.calendarEndTopBtnNames[0]
                        : _calendarFormatterController
                            .calendarStartTopBtnNames[0],
                    onTap: () {
                      !isStartCalendar
                          ? _calendarFormatterController
                              .onTapEndCalendarHeaderDate(0)
                          : _calendarFormatterController
                              .onTapStartCalendarHeaderDate(0);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Obx(
                  () => WeekDayBtnWidget(
                    isSelected: !isStartCalendar
                        ? _calendarFormatterController.isSelected[1]
                        : _calendarFormatterController.isSelected[1],
                    btnName: !isStartCalendar
                        ? _calendarFormatterController.calendarEndTopBtnNames[1]
                        : _calendarFormatterController
                            .calendarStartTopBtnNames[1],
                    onTap: () {
                      !isStartCalendar
                          ? _calendarFormatterController
                              .onTapEndCalendarHeaderDate(1)
                          : _calendarFormatterController
                              .onTapStartCalendarHeaderDate(1);
                    },
                  ),
                ),
              ],
            ),
            !isStartCalendar ? const SizedBox() : const SizedBox(height: 16),
            !isStartCalendar
                ? const SizedBox()
                : Row(
                    children: [
                      Obx(
                        () => WeekDayBtnWidget(
                          isSelected:
                              _calendarFormatterController.isSelected[2],
                          btnName: _calendarFormatterController
                              .calendarStartTopBtnNames[2],
                          onTap: () {
                            _calendarFormatterController
                                .onTapStartCalendarHeaderDate(2);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Obx(
                        () => WeekDayBtnWidget(
                          isSelected:
                              _calendarFormatterController.isSelected[3],
                          btnName: _calendarFormatterController
                              .calendarStartTopBtnNames[3],
                          onTap: () {
                            _calendarFormatterController
                                .onTapStartCalendarHeaderDate(3);
                          },
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    _calendarFormatterController.calendarController.backward!();
                    _calendarFormatterController.monthAndYearConvert(
                      dateTime: _calendarFormatterController
                              .calendarController.displayDate ??
                          DateTime.now(),
                    );
                  },
                  child: Image.asset(
                    ImagePaths.calendarLeftIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 8),
                _calendarFormatterController.headerMonthYear == null
                    ? Text(
                        '--',
                        style: TextStyles.kFontStyleW500S16.copyWith(
                          color: const Color(0xff323238),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      )
                    : Obx(
                        () => Text(
                          _calendarFormatterController.headerMonthYear!.value,
                          style: TextStyles.kFontStyleW500S16.copyWith(
                            color: const Color(0xff323238),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    _calendarFormatterController.calendarController.forward!();
                    _calendarFormatterController.monthAndYearConvert(
                      dateTime: _calendarFormatterController
                              .calendarController.displayDate ??
                          DateTime.now(),
                    );
                  },
                  child: Image.asset(
                    ImagePaths.calendarRightIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 24),
            SfCalendar(
              onTap: (calendarTapDetails) {
                _calendarFormatterController.selectedDate.value =
                    DateFormat('dd MMM yyyy').format(calendarTapDetails.date!);
              },
              controller: _calendarFormatterController.calendarController,
              headerHeight: 0,
              showNavigationArrow: false,
              viewHeaderHeight: 22,
              view: CalendarView.month,
              cellBorderColor: Colors.white,
              selectionDecoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.kDefaultAppColorBlue,
                ),
                shape: BoxShape.circle,
              ),
              todayHighlightColor: AppColors.kDefaultAppColorBlue,
              monthCellBuilder: (context, details) {
                return details.date.year == DateTime.now().year &&
                        details.date.month == DateTime.now().month &&
                        details.date.day == DateTime.now().day
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.kDefaultAppColorBlue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            details.date.day.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyles.kFontStyleW500S16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          details.date.day.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyles.kFontStyleW500S16.copyWith(
                            color: AppColors.kLightBlackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
              },
              onSelectionChanged: (calendarSelectionDetails) {
                _calendarFormatterController.onTapCalendarCellDate();
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.asset(
                  ImagePaths.calendarIcon,
                  width: 20,
                  height: 23,
                ),
                const SizedBox(width: 10),
                Obx(
                  () => Text(
                    _calendarFormatterController.selectedDate.value,
                    style: TextStyles.kFontStyleW500S16.copyWith(
                      color: AppColors.kLightBlackColor,
                    ),
                  ),
                ),
                const Spacer(),
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
                  btnBgColor: AppColors.kDefaultAppColorBlue,
                  btnTextColor: AppColors.kButtonBgLightBlue,
                  onPressed: () {
                    onSave(_calendarFormatterController.saveDateTime);
                    navigatorKey.currentState!.pop();
                  },
                ),
                const SizedBox(width: 16),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WeekDayBtnWidget extends StatelessWidget {
  const WeekDayBtnWidget({
    super.key,
    required this.isSelected,
    required this.btnName,
    required this.onTap,
  });

  final bool isSelected;
  final String btnName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 160,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kDefaultAppColorBlue
              : AppColors.kButtonBgLightBlue,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          btnName,
          style: TextStyles.kFontStyleW500S16.copyWith(
            color: isSelected ? Colors.white : AppColors.kDefaultAppColorBlue,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
