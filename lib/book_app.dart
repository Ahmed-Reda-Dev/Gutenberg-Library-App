import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Gutenberg Library App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
