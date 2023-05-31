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
    switch (selectedScreenSize) {
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
    Filters filters = Filters(_getRatio(), _getCategories(), '100', sorting, '',
        selectedColor, query);
    _search(context, filters, query.tagName);
  }

  _searchLatest(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters =
        Filters('portrait', '100', '100', 'date_added', '', '', query);
    _search(context, filters, 'Latest');
  }

  _searchToplist(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters =
        Filters('portrait', '100', '100', 'toplist', '', '', query);
    _search(context, filters, 'Toplist');
  }

  _searchRandom(BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters filters =
        Filters('portrait', '100', '100', 'random', '', '', query);
    _search(context, filters, 'Random');
  }

  _search(BuildContext context, Filters filters, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListWallPage(
                title: title,
                filters: filters,
              )),
    );
  }

  List<Widget> _renderColors() {
    List<Widget> listColors = [];

    for (var c in colors) {
      String cleaned = c.replaceAll('#', '');
      String parsed = '0xFF' + cleaned;
      final ButtonStyle style = ElevatedButton.styleFrom(
          backgroundColor: Color(int.parse(parsed)),
          textStyle: const TextStyle(color: Colors.white));
      listColors.add(Container(
        padding: const EdgeInsets.only(right: 5),
        width: 60,
        child: ElevatedButton(
          child: selectedColor == c ? const Icon(Icons.check) : null,
          onPressed: () => {
            setState(() {
              String val = c;
              if (selectedColor == c) {
                val = '';
              }
              selectedColor = val;
            })
          },
          style: style,
        ),
      ));
    }

    return listColors;
  }

  void _reset() {
    _controller.clear();
    setState(() {
      disabledBtn = _controller.text.isEmpty;
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
          title: const Text('Wallz'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueAccent,
                    Colors.pinkAccent,
                  ],
                )),
                child: const Center(
                  child: Text('Wallpapers from wallhaven.cc',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          endIndent: 0,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: const Text('Rapid search',
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      const Expanded(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 50,
                                color: Colors.blueAccent,
                                icon: const Icon(Icons.punch_clock),
                                onPressed: () => {_searchLatest(context)},
                              ),
                              const Text('Latest')
                            ],
                          )),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 50,
                              color: Colors.redAccent,
                              icon: const Icon(Icons.diamond),
                              onPressed: () {
                                _searchToplist(context);
                              },
                            ),
                            const Text('Toplist')
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 50,
                              color: Colors.amber,
                              icon: const Icon(Icons.shuffle),
                              onPressed: () {
                                _searchRandom(context);
                              },
                            ),
                            const Text('Random')
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('Manual search',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: const Text('Screen ratio:'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CupertinoSegmentedControl(
                      unselectedColor: const Color.fromARGB(100, 31, 31, 31),
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
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text('Categories:'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: InputChip(
                              label: const Text('Generic'),
                              onSelected: (bool value) {
                                setState(() {
                                  if (!value) {
                                    if (animeFilter || peopleFilter) {
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
                              label: const Text('Anime'),
                              onSelected: (bool value) {
                                setState(() {
                                  if (!value) {
                                    if (genericFilter || peopleFilter) {
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
                              label: const Text('People'),
                              onSelected: (bool value) {
                                setState(() {
                                  if (!value) {
                                    if (genericFilter || animeFilter) {
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
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: const Text('Color:'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: _renderColors()),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _controller,
                      onChanged: (txt) => _onChange(txt),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(),
                        hintText: 'Enter the keyword to search',
                        suffixIcon: disabledBtn
                            ? null
                            : IconButton(
                                onPressed: _reset,
                                icon: const Icon(Icons.clear),
                              ),
                      ),
                      onSubmitted: (String value) => {_manualSearch(context)},
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () => _manualSearch(context),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 40, 40, 40)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.blueGrey))))),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
