import 'package:flutter/material.dart';

final List<String> colors = [
  '660000', '990000', 'cc0000', 'cc3333', 'ea4c88', '993399', '663399', '333399',
  '0066cc', '0099cc', '66cccc', '77cc33', '669900', '336600', '666600', '999900',
  'cccc33', 'ffff00', 'ffcc33', 'ff9900', 'ff6600', 'cc6633', '996633', '663300',
  '000000', '999999', 'cccccc', 'ffffff', '424153'
];

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