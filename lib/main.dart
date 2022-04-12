import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/homePage.dart';
import 'package:flutter_assignment2/loginPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appvocado',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const LogoPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LogoPage> createState() => _LogoPage();
}

class _LogoPage extends State<LogoPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //backgroundColor: const Color(0xFFE5E5E5),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(90.0),
              child: Image(
                image: AssetImage("images/appvocado-loading.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
