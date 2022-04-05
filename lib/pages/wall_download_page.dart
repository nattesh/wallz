import 'package:flutter/material.dart';
import 'package:wallz/models/wall_item.dart';

class WallDownloadPage extends StatelessWidget {
  const WallDownloadPage({Key? key, required this.item}) : super(key: key);

  final WallItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Image(
        image: NetworkImage(item.path),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

}