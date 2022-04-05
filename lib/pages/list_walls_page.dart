import 'package:flutter/material.dart';
import 'package:wallz/api/wall_items_api.dart';
import 'package:wallz/models/api_response.dart';
import 'package:wallz/widgets/list_walls/list_walls_widget.dart';

class ListWallPage extends StatefulWidget {
  const ListWallPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListWallPage> createState() => _ListWallPageState();
}

class _ListWallPageState extends State<ListWallPage> {

  late Future<ApiResponse> data;

  @override
  void initState() {
    super.initState();
    newSearch();
  }

  void newSearch() {
    data = getData(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:FutureBuilder(
          future: data,
          builder:
              (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;
              if(data != null && data.data != null && data.data.length > 0) {
                return ListWalls(walls: data.data, onePage: data.meta.lastPage == 1,);
              } else {
                return Center(child: Text('No results found'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}