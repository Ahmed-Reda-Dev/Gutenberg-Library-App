import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/cubit/book_cubit.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // Arguments can be passed to screens when navigating
    // Using settings.arguments if needed

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const Text('OnBoarding Screen'),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<BookCubit>(),
                child: const HomeScreen(),
              ),
        );

      default:
        return null;
    }
  }
}
