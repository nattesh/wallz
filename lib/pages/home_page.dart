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
  bool disabledBtn = true;
  bool onlyPortrait = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    SharedPreferences.getInstance().then( (SharedPreferences prefs) {
      String? prefRatio = prefs.getString('ratios');
      onlyPortrait = prefRatio != null;
    });
  }

  setAndSearch(context) async {
    var prefs = await SharedPreferences.getInstance();
    String value = _controller.text;
    await prefs.setString('tagName', value);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListWallPage(title: 'Wallz')),
      );
  }

  void _reset() {
    _controller.clear();
    setState(() {
      disabledBtn = _controller.text.length == 0;
    });
  }

  void _onChange(txt) {
    setState(() {
      disabledBtn = txt.length == 0;
    });
  }

  void _setPortrait(value) async {
    var prefs = await SharedPreferences.getInstance();

    if(value) {
      prefs.setString('ratios', 'portrait');
    } else {
      prefs.remove('ratios');
    }

    setState(() {
      onlyPortrait = value;
    });
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Only portrait'),
                    Switch(
                      value: onlyPortrait,
                      onChanged: (value) => _setPortrait(value),
                    ),
                  ]
              ),
              TextField(
                controller: _controller,
                onChanged: (txt) => _onChange(txt),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  suffixIcon: disabledBtn ? null : IconButton(
                    onPressed: _reset,
                    icon: Icon(Icons.clear),
                  ),
                ),
                onSubmitted: (String value) => {
                  setAndSearch(context)
                },
              ),
              ElevatedButton(
                onPressed: disabledBtn ? () {} : () => setAndSearch(context),
                child: const Text('Search'),
              ),
            ],
          )
        ),
      ),
    );
  }
}