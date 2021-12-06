import 'package:flutter/material.dart';

import 'common/app.dart';
import 'examples/greeting.dart';

enum ExampleType {
  greet,
  statefulGreet,
  masteringWidgets,
}

void main() {
  const example = ExampleType.masteringWidgets;
  late Widget app;

  switch (example) {
    case ExampleType.greet:
      app = greeting;
      break;
    case ExampleType.statefulGreet:
      app = const StatefulGreetWidget();
      break;
    case ExampleType.masteringWidgets:
      app = const MyApp(step: 7);
      break;
  }

  runApp(app);
}
