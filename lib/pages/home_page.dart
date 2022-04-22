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
  String selectedColor = '';

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

  _manualSearch(BuildContext context) {
    String value = _controller.text.isNotEmpty ? _controller.text : '';
    QueryFilter query = QueryFilter(value, '', '');
    String sorting = value.isNotEmpty ? 'relevance' : '';
    Filters filters = new Filters(
        _getRatio(), _getCategories(), '100', sorting, '', selectedColor, query);
    _search(context, filters, query.tagName);
  }

  _searchLatest(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        'portrait', '100', '100', 'date_added', '', '', query);
    _search(context, filters, 'Latest');
  }

  _searchToplist(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        'portrait', '100', '100', 'toplist', '', '', query);
    _search(context, filters, 'Toplist');
  }

  _searchRandom(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters = new Filters(
        'portrait', '100', '100', 'random', '', '', query);
    _search(context, filters, 'Random');
  }

  _search(BuildContext context, Filters filters, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListWallPage(title: title, filters: filters,)),
    );
  }

  List<Widget> _renderColors() {
    List<Widget> listColors = [];

    colors.forEach((c) {
      String cleaned = c.replaceAll('#', '');
      String parsed = '0xFF' + cleaned;
      listColors.add(Container(
        padding: EdgeInsets.only(right: 5),
        width: 60,
        child: RaisedButton(
          padding: EdgeInsets.all(2),
          child: selectedColor == c ? Icon(Icons.check) : null,
          onPressed: () => {
            setState(() {
              String val = c;
              if(selectedColor == c) {
                val = '';
              }
              selectedColor = val;
            })
          },
          textColor: Colors.white,
          color: Color(int.parse(parsed)),
        ),
      ));
    });

    return listColors;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            endIndent: 0,
                            color: Colors.white,
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Text('Rapid search',
                                style: TextStyle(
                                    fontSize: 15
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            endIndent: 0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      endIndent: 0,
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Text('Manual search',
                          style: TextStyle(
                              fontSize: 15
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      endIndent: 0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Text('Screen ratio:'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 15),
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('Categories:'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: InputChip(
                            label: Text('Generic'),
                            onSelected: (bool value) {
                              setState(() {
                                if(!value) {
                                  if(animeFilter || peopleFilter) {
                                    genericFilter = value;
                                  }
                                } else {
                                  genericFilter = value;
                                }
                              });
                            },
                            selected: genericFilter,
                            selectedColor: Colors.blueGrey,
                          ),
                        ),
                        Center(
                          child: InputChip(
                            label: Text('Anime'),
                            onSelected: (bool value) {
                              setState(() {
                                if(!value) {
                                  if(genericFilter || peopleFilter) {
                                    animeFilter = value;
                                  }
                                } else {
                                  animeFilter = value;
                                }
                              });
                            },
                            selected: animeFilter,
                            selectedColor: Colors.blueGrey,
                          ),
                        ),
                        Expanded(
                          child: InputChip(
                            label: Text('People'),
                            onSelected: (bool value) {
                              setState(() {
                                if(!value) {
                                  if(genericFilter || animeFilter) {
                                    peopleFilter = value;
                                  }
                                } else {
                                  peopleFilter = value;
                                }
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
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text('Color:'),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: _renderColors()
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
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
                      labelText: 'Tag',
                      hintText: 'Enter a tag (e.g. \'Mountains\')',
                      suffixIcon: disabledBtn ? null : IconButton(
                        onPressed: _reset,
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    onSubmitted: (String value) => {
                      _manualSearch(context)
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                        child: Icon(Icons.search, color: Colors.blueGrey,),
                        onPressed: () => _manualSearch(context),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 40, 40, 40)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blueGrey)
                                )
                            )
                        )
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}