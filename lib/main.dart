import 'package:flutter/material.dart';
import 'package:wallz/pages/list_walls_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallz',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const ListWallPage(title: 'Wallz'),
      debugShowCheckedModeBanner: false,
    );
  }
}




