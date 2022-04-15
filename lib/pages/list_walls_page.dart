import 'package:flutter/material.dart';
import 'package:wallz/api/wall_items_api.dart';
import 'package:wallz/models/api_response.dart';
import 'package:wallz/models/filters.dart';
import 'package:wallz/widgets/list_walls_widget.dart';

class ListWallPage extends StatefulWidget {
  const ListWallPage({Key? key, required this.title, required this.filters}) : super(key: key);

  final String title;
  final Filters filters;

  @override
  State<ListWallPage> createState() => _ListWallPageState();
}

class _ListWallPageState extends State<ListWallPage> {

  late Future<ApiResponse> data;

  @override
  void initState() {
    super.initState();
    data = getData(1, widget.filters);
  }

  _goHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.filters.colors.isNotEmpty ?
      Color(int.parse('0xff' + widget.filters.colors))
          : null,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.filters.colors.isNotEmpty ?
          Color(int.parse('0xff' + widget.filters.colors))
          : null,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => _goHome(context),
          )
        ],
      ),
      body: FutureBuilder(
          future: data,
          builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;
              if(data != null && data.data != null && data.data.length > 0) {
                return ListWalls(walls: data.data, onePage: data.meta.lastPage == 1, filters: widget.filters,);
              } else {
                return Center(child: Text('No results found'));
              }
            } else {
              return Center(child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ));
            }
          }),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}