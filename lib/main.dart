import 'package:flutter/material.dart';

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

class homescreen extends StatelessWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Compress image",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        child: Center(
          child: TextButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor: MaterialStateProperty.all(Colors.black54)),
            child: const Text(
              'Upload',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // ignore: avoid_print
              print("Clicked");
            },
          ),
        ),
      ),
    );
  }
}

displayHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

displayWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
