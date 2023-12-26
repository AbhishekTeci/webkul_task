import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webkul_task/helper/constant.dart';
import 'package:webkul_task/helper/snackbar.dart';
import 'package:webkul_task/views/dashboard/dashboard.dart';

import '../../helper/Color.dart';
import '../../helper/app_button.dart';
import '../../helper/design_confg.dart';
import '../../provider/dashboard_provider.dart';

class MovieDetailView extends StatefulWidget {
  String movName;
  String movDesc;
  String movImg;

  MovieDetailView(
      {super.key,
      required this.movDesc,
      required this.movImg,
      required this.movName});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            appbarView(widget.movImg),
            moviesName(widget.movName),
            moviesDescription(widget.movDesc),
            selectDate(),
            selectTime(context),
            bookNowBtn()
          ],
        ),
      ),
    );
  }

  Widget appbarView(String img) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(circularBorderRadius12),
            bottomLeft: Radius.circular(5.0)),
        image: DecorationImage(
            image: NetworkImage(img),
            fit: BoxFit.cover,
            alignment: Alignment.center),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  DesignConfiguration.setPngPath('back'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moviesName(String name) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: textFontSize25),
            ),
            Text(
              name,
              style: const TextStyle(
                  color: black,
                  fontWeight: FontWeight.w400,
                  fontSize: textFontSize20),
            )
          ],
        ));
  }

  Widget moviesDescription(String description) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description ',
              style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: textFontSize25),
            ),
            Text(
              description,
              style: const TextStyle(
                  color: black,
                  fontWeight: FontWeight.w400,
                  fontSize: textFontSize10),
            )
          ],
        ));
  }

  Widget selectDate() {
    return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date ',
              style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: textFontSize25),
            ),
            SizedBox(
              height: 144,
              child: AnimatedHorizontalCalendar(
                  tableCalenderIcon: const Icon(
                    Icons.calendar_today,
                    color: black,
                    size: 30,
                  ),
                  date: DateTime.now(),
                  textColor: blackColor,
                  backgroundColor: white,
                  selectedBoxShadow:
                      const BoxShadow(color: grey, blurRadius: 2),
                  tableCalenderThemeData: ThemeData.light().copyWith(
                    primaryColor: primary,
                    colorScheme:
                        const ColorScheme.light(primary: darkVioletColor),
                    buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary),
                  ),
                  selectedColor: primary,
                  onDateSelected: (date) {
                    // sharedPreferences.setString(DATE, date);
                    debugPrint("date: " +
                        DateTime.parse(date)
                            .isBefore(
                                DateTime.now().subtract(Duration(days: 1)))
                            .toString());
                  }),
            )
          ],
        ));
  }

  selectTime(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Select Time ',
              style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: textFontSize25),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {
                _selectTime(context);
              },
              child: Image.asset(
                DesignConfiguration.setPngPath('clock'),
                fit: BoxFit.cover,
                cacheHeight: 50,
                cacheWidth: 50,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            context.read<DashBoardProvider>().selectedTime != null
                ? Text(
                    "${context.read<DashBoardProvider>().time.hour} : ${context.read<DashBoardProvider>().time.minute}",
                    style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: textFontSize15),
                  )
                : const SizedBox()
          ],
        ));
  }

  bookNowBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: AppBtn(
          title: 'Book Now',
          btnCntrl: context.read<DashBoardProvider>().buttonController,
          onBtnSelected: () async {
            setSnackbar('Your Movies is booked', context);
            Future.delayed(const Duration(seconds: 2)).then((value) =>
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (BuildContext context) => const Dashboard()),
                    ModalRoute.withName('/home')));
          },
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: context.read<DashBoardProvider>().selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
    if (pickedS != null &&
        pickedS != context.read<DashBoardProvider>().selectedTime) {
      context.read<DashBoardProvider>().setTime(pickedS);
      // sharedPreferences.setInt(TIME, pickedS.hour+pickedS.minute);
    }
  }
}
