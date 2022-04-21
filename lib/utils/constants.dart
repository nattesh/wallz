import 'package:flutter/material.dart';

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

Icon getOrientationIcon(int dimX, int dimY) {
  if(dimX > dimY) {
    return Icon(Icons.stay_current_landscape);
  } else if(dimX < dimY) {
    return Icon(Icons.stay_current_portrait);
  } else {
    return Icon(Icons.all_inclusive);
  }
}