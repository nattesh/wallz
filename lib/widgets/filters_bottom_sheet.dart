import 'package:flutter/material.dart';
import 'package:wallz/models/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallz/utils/constants.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet(
      {Key? key, required this.filters, required this.oldTitle})
      : super(key: key);

  final Filters filters;
  final String oldTitle;

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  int selectedScreenSize = 0;
  String sortSelect = '';
  String sortingOrder = 'desc';
  bool genericFilter = true;
  bool animeFilter = false;
  bool peopleFilter = false;

  @override
  void initState() {
    super.initState();
    if (widget.filters.ratios == 'portrait') {
      selectedScreenSize = 0;
    } else if (widget.filters.ratios == 'landscape') {
      selectedScreenSize = 2;
    } else {
      selectedScreenSize = 1;
    }

    sortSelect =
        widget.filters.sorting.isEmpty ? 'date_added' : widget.filters.sorting;
    sortingOrder = widget.filters.order;
    genericFilter = widget.filters.categories[0] == '1';
    animeFilter = widget.filters.categories[1] == '1';
    peopleFilter = widget.filters.categories[2] == '1';
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text('Upload date'), value: "date_added"),
      const DropdownMenuItem(child: Text('Relevance'), value: "relevance"),
      const DropdownMenuItem(child: Text('Random'), value: "random"),
      const DropdownMenuItem(child: Text('Views'), value: "views"),
      const DropdownMenuItem(child: Text('Favorites'), value: "favorites"),
      const DropdownMenuItem(child: Text('Toplist'), value: "toplist"),
    ];
    return menuItems;
  }

  Widget getIconBySorting() {
    return sortingOrder == 'asc'
        ? const Icon(Icons.arrow_downward)
        : const Icon(Icons.arrow_upward);
  }

  Filters _newFilters() {
    var filters = widget.filters;
    filters.ratios = _getRatio();
    filters.sorting = sortSelect;
    filters.order = sortingOrder;
    filters.categories = _getCategories();
    return filters;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, null);
        return false;
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Filters',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: const Text('Sort by:'),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 12 * 9,
                            child: DropdownButton(
                              isExpanded: true,
                              value: sortSelect,
                              items: dropdownItems,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) {
                                    sortSelect = value;
                                  }
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: getIconBySorting(),
                            onPressed: () {
                              setState(() {
                                sortingOrder =
                                    sortingOrder == 'asc' ? 'desc' : 'asc';
                              });
                            },
                          )
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: const Text('Screen ratio:'),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
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
                      )),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: const Text('Categories:'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputChip(
                            label: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('Generic'),
                            ),
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
                            label: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('Anime'),
                            ),
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
                            label: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('People'),
                            ),
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
                  Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () =>
                              {Navigator.pop(context, _newFilters())},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 40, 40, 40)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.blueGrey))))))
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context, null),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
