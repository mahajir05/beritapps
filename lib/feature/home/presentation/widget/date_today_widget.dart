import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateTodayWidget extends StatefulWidget {
  const DateTodayWidget({super.key});

  @override
  State<StatefulWidget> createState() => _DateTodayWidgetState();
}

class _DateTodayWidgetState extends State<DateTodayWidget> {
  String? strToday;

  @override
  void initState() {
    strToday = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      strToday ?? "-",
      style: TextStyle(
        fontSize: 16.sp,
        color: Colors.grey,
      ),
    );
  }
}
