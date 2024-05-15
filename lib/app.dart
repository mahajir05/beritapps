import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'feature/home/presentation/page/home/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var isDarkMode = box.get('darkMode') ?? false;
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Beritapps',
              theme: ThemeData(
                brightness: isDarkMode ? Brightness.dark : Brightness.light,
              ),
              home: child,
            );
          },
          child: const HomePage(),
        );
      },
    );
  }
}
