import 'package:flutter/material.dart';
import 'package:wallz/pages/list_walls_page.dart';
import 'package:wallz/models/filters.dart';
import 'package:wallz/models/query_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallz/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TextEditingController _controller;
  bool disabledBtn = true;
  int selectedScreenSize = 0;
  bool genericFilter = true;
  bool animeFilter = false;
  bool peopleFilter = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  String _getRatio() {
    switch(selectedScreenSize) {
      case 0:
        return 'portrait';
      case 1:
        return '';
      case 2:
        return 'landscape';
      default:
        return '';
    }
  }

  String _getCategories() {
    return '${genericFilter ? '1' : '0'}${animeFilter ? '1' : '0'}${peopleFilter ? '1' : '0'}';
  }

  _searchByTagName(BuildContext context) {
    String value = _controller.text;
    QueryFilter query = QueryFilter(value, '', '');
    Filters filters = new Filters(
        _getRatio(), _getCategories(), '100', 'relevance', '', '', query);
    _search(context, filters, query.tagName);
  }

  _searchLatest(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        _getRatio(), _getCategories(), '100', 'date_added', '', '', query);
    _search(context, filters, 'Latest');
  }

  _searchToplist(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        _getRatio(), _getCategories(), '100', 'toplist', '', '', query);
    _search(context, filters, 'Toplist');
  }

  _searchRandom(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        _getRatio(), _getCategories(), '100', 'random', '', '', query);
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
              height: 150,
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
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Text('Screen ratio:'),
                ),
                Container(
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
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(15, 40, 15, 5),
                  child: Text('Categories:'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: InputChip(
                          label: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('Generic'),
                          ),
                          onSelected: (bool value) {
                            setState(() {
                              genericFilter = value;
                            });
                          },
                          selected: genericFilter,
                          selectedColor: Colors.blueGrey,
                        ),
                      ),
                      Center(
                        child: InputChip(
                          label: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('Anime'),
                          ),
                          onSelected: (bool value) {
                            setState(() {
                              animeFilter = value;
                            });
                          },
                          selected: animeFilter,
                          selectedColor: Colors.blueGrey,
                        ),
                      ),
                      Expanded(
                        child: InputChip(
                          label: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('People'),
                          ),
                          onSelected: (bool value) {
                            setState(() {
                              peopleFilter = value;
                            });
                          },
                          selected: peopleFilter,
                          selectedColor: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}