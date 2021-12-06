import 'package:flutter/material.dart';

const greeting = Center(
  child: Text(
    'Hello Sirius',
    style: TextStyle(
      color: Colors.lightBlue,
      fontSize: 56,
    ),
    textDirection: TextDirection.ltr,
  ),
);

class StatefulGreetWidget extends StatefulWidget {
  const StatefulGreetWidget({
    Key? key,
  }) : super(key: key);

  @override
  _StatefulGreetWidgetState createState() => _StatefulGreetWidgetState();
}

class _StatefulGreetWidgetState extends State<StatefulGreetWidget> {
  bool isCity = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCity = !isCity;
        });
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: isCity ? cityWidgets : flutterWidgets,
      ),
    );
  }

  Widget get cityWidgets => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Icon(
            Icons.location_city,
            color: Colors.lightBlue,
            size: 56,
          ),
          SizedBox(height: 24),
          Text(
            'Hello Sirius',
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 56,
            ),
          ),
        ],
      );

  Widget get flutterWidgets => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Icon(
            Icons.flutter_dash,
            color: Colors.lightBlue,
            size: 56,
          ),
          SizedBox(height: 24),
          Text(
            'Hello Flutter',
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 56,
            ),
          ),
        ],
      );
}
