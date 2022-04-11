import 'package:flutter/material.dart';
import 'package:wallz/pages/list_walls_page.dart';
import 'package:wallz/models/filters.dart';

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
  }

  setAndSearch(context) async {
    String value = _controller.text;
    Filters filters = new Filters(
        onlyPortrait ? 'portrait' : '',
        '100', '100', 'relevance', 'date_added', '', value);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListWallPage(title: 'Wallz', filters: filters,)),
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