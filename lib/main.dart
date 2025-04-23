import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'book_app.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'features/home/data/models/author_model.dart';
import 'features/home/data/models/book_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(BookModelAdapter());
  Hive.registerAdapter(AuthorModelAdapter());

  // Initialize screen util for responsive UI
  await ScreenUtil.ensureScreenSize();

  // Initialize dependency injection
  await DependencyInjection.init();

  runApp(BookApp(appRouter: AppRouter()));
}
