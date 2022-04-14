import 'package:flutter/material.dart';
import 'package:wallz/pages/home_page.dart';

void main() {
  runApp(const WallzApp());
}

class WallzApp extends StatelessWidget {
  const WallzApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallz',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}




