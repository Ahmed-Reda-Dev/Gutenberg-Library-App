import 'package:book_listing_app/book_app.dart';
import 'package:book_listing_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(BookApp(appRouter: AppRouter()));
}
