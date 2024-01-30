import 'package:flutter/material.dart';
import 'package:quote/app/router/app_routes.dart';
import 'package:quote/features/home/views/home_screen.dart';
import 'package:quote/features/saved/saved_screen.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.saved:
        return _materialRoute(const SavedScreen());

      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(opacity: animation, child: view);
      },
    );
  }
}
