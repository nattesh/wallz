import 'package:flutter/material.dart';
import 'package:wallz/pages/list_walls_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  setAndSearch(context) async {
    final prefs = await SharedPreferences.getInstance();
    String value = _controller.text.trim().replaceAll(' ', '+');
    await prefs.setString('tagName', value);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListWallPage(title: 'Wallz')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search'
                ),
                onSubmitted: (String value) => {
                  setAndSearch(context)
                },
              ),
              ElevatedButton(
                onPressed: () => setAndSearch(context),
                child: const Text('Search'),
              ),
            ],
          )
        ),
      ),
    );
  }
}