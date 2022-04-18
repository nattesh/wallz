import 'package:flutter/material.dart';
import 'package:wallz/pages/list_walls_page.dart';
import 'package:wallz/models/filters.dart';
import 'package:wallz/models/query_filter.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TextEditingController _controller;
  bool disabledBtn = true;
  int selectedScreenSize = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  final Map<int, Widget> screenSizes = const <int, Widget> {
    0: Center (
      child: Padding(
        child: Icon(
            Icons.stay_current_portrait
        ),
        padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
      ),
    ),
    1: Center (
        child: Icon(
        Icons.all_inclusive
      ),
    ),
    2: Center (
      child: Icon(
          Icons.stay_current_landscape
      ),
    ),
  };

  String _getOrientation() {
    switch(selectedScreenSize) {
      case 0:
        return 'portrait';
      case 1:
        return 'landscape';
      default:
        return '';
    }
  }

  _searchByTagName(BuildContext context) {
    String value = _controller.text;
    QueryFilter query = QueryFilter(value, '', '');
    Filters filters = new Filters(
        _getOrientation(), '100', '100', 'relevance', '', '', query);
    _search(context, filters, query.tagName);
  }

  _searchLatest(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        _getOrientation(), '100', '100', 'date_added', '', '', query);
    _search(context, filters, 'Latest');
  }

  _searchToplist(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        _getOrientation(), '100', '100', 'toplist', '', '', query);
    _search(context, filters, 'Toplist');
  }

  _searchRandom(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        _getOrientation(), '100', '100', 'random', '', '', query);
    _search(context, filters, 'Random');
  }

  _search(BuildContext context, Filters filters, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListWallPage(title: title, filters: filters,)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallz'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 50,
                        color: Colors.blueAccent,
                        icon: Icon(Icons.punch_clock),
                        onPressed: () => {
                          _searchLatest(context)
                        },
                      ),
                      Text('Latest')
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 50,
                        color: Colors.redAccent,
                        icon: Icon(Icons.diamond),
                        onPressed: () {
                          _searchToplist(context);
                        },
                      ),
                      Text('Toplist')
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 50,
                        color: Colors.amber,
                        icon: Icon(Icons.shuffle),
                        onPressed: () {
                          _searchRandom(context);
                        },
                      ),
                      Text('Random')
                    ],
                  ),
                )
              ],
            ),
          ),
          Container (
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _controller,
                      onChanged: (txt) => _onChange(txt),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                        suffixIcon: disabledBtn ? null : IconButton(
                          onPressed: _reset,
                          icon: Icon(Icons.clear),
                        ),
                      ),
                      onSubmitted: (String value) => {
                        _searchByTagName(context)
                      },
                    ),
                    ElevatedButton(
                      onPressed: disabledBtn ? () {} : () => _searchByTagName(context),
                      child: const Text('Search'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoSegmentedControl(
                  unselectedColor: Color.fromARGB(100, 31, 31, 31),
                  borderColor: Colors.blueGrey,
                  selectedColor: Colors.blueGrey,
                  children: screenSizes,
                  onValueChanged: (int val) {
                    setState(() {
                      selectedScreenSize = val;
                    });
                  },
                  groupValue: selectedScreenSize,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}