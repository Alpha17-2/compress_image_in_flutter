import 'package:flutter/material.dart';

import 'homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: homescreen(),
    );
  }
}

displayHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

displayWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
