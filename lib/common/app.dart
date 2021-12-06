import 'package:flutter/material.dart';

import '../examples/details_page.dart';
import '../examples/home_page_1.dart';
import '../examples/home_page_2.dart';
import '../examples/home_page_3.dart';
import '../examples/home_page_4.dart';
import '../examples/home_page_5.dart';
import '../examples/home_page_6.dart';
import 'tile_model.dart';

class MyApp extends StatelessWidget {
  final int step;

  const MyApp({
    required this.step,
    Key? key,
  }) : super(key: key);

  static final navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    Widget home = Scaffold(
      body: Center(
        child: Text(
          'ERROR: unknown step ($step)',
        ),
      ),
    );

    switch (step) {
      case 1:
        // Простой список
        home = const MyHomePage1();
        break;
      case 2:
        // Список со сливерами
        home = const MyHomePage2();
        break;
      case 3:
        // Добавляем контроллеры
        home = const MyHomePage3();
        break;
      case 4:
        // Усложняем логику с контроллерами
        home = const MyHomePage4();
        break;
      case 5:
        // Разбиваем на маленькие виджеты
        home = const MyHomePage5();
        break;
      case 6:
        // Разбиваем на маленькие виджеты
        home = const MyHomePage6();
        break;
    }

    return MaterialApp(
      title: 'Widgets Mastering',
      navigatorKey: navigationKey,
      onGenerateRoute: (settings) {
        final route = settings.name;
        switch (route) {
          case DetailsPage.routeName:
            return MaterialPageRoute(
              builder: (context) => DetailsPage(
                model: settings.arguments as TileViewModel,
              ),
              settings: settings,
            );
        }
        throw UnimplementedError('Unknown route $route');
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
    );
  }
}
