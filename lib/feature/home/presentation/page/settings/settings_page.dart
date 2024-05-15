import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: const WidgetAppBar(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SizedBox(),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Interface',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Use dark mode',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        'Get that whiteness out',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box('settings').listenable(),
                  builder: (context, box, widget) {
                    var isDarkMode = box.get('darkMode') ?? false;
                    return Switch(
                      value: isDarkMode,
                      onChanged: (value) async {
                        isDarkMode = value;
                        await box.put('darkMode', isDarkMode);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetAppBar extends PreferredSize {
  const WidgetAppBar(
      {super.key, required super.preferredSize, required super.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var isDarkMode = box.get('darkMode') ?? false;
        return isDarkMode
            ? AppBar(
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : AppBar(
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 20),
                ),
              );
      },
    );
  }
}
