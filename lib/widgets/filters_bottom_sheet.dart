import 'package:flutter/material.dart';
import 'package:wallz/models/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallz/utils/constants.dart';
import 'package:wallz/pages/list_walls_page.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({Key? key, required Filters this.filters, required String this.oldTitle}) : super(key: key);

  final Filters filters;
  final String oldTitle;

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {

  int selectedScreenSize = 0;

  @override
  void initState() {
    super.initState();
    if(widget.filters.ratios == 'portrait') {
      selectedScreenSize = 0;
    } else if(widget.filters.ratios == 'landscape') {
      selectedScreenSize = 2;
    } else {
      selectedScreenSize = 1;
    }
  }

  String _getOrientation() {
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

  Filters _newFilters() {
    var filters = widget.filters;
    filters.ratios = _getOrientation();
    return filters;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _newFilters());
        return false;
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
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
    );
  }
}