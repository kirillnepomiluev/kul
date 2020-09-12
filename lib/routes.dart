import 'package:flutter/material.dart';
import 'package:kul/pages/anketaPage.dart';
import 'package:kul/pages/categoriesPage.dart';
import 'package:kul/pages/homePage.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/anketa':
        return MaterialPageRoute(builder: (_) => AnketaPage());
      case '/categoriesPage':
        return MaterialPageRoute(builder: (_) => CategoriesPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
