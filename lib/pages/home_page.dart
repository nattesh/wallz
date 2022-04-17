import 'package:flutter/material.dart';
import 'package:wallz/pages/list_walls_page.dart';
import 'package:wallz/models/filters.dart';
import 'package:wallz/models/query_filter.dart';

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

  _searchByTagName(BuildContext context) {
    String value = _controller.text;
    QueryFilter query = QueryFilter(value, '', '');
    Filters filters = new Filters(
        onlyPortrait ? 'portrait' : '',
        '100', '100', 'relevance', '', '', query);
    _search(context, filters, query.tagName);
  }

  _searchLatest(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        onlyPortrait ? 'portrait' : '',
        '100', '100', 'date_added', '', '', query);
    _search(context, filters, 'Latest');
  }

  _searchToplist(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        onlyPortrait ? 'portrait' : '',
        '100', '100', 'toplist', '', '', query);
    _search(context, filters, 'Toplist');
  }

  _searchRandom(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        onlyPortrait ? 'portrait' : '',
        '100', '100', 'random', '', '', query);
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

  void _setPortrait(value) async {
    setState(() {
      onlyPortrait = value;
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Only portrait'),
                          Switch(
                            activeColor: Colors.blueGrey,
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
              padding: EdgeInsets.all(30),
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}