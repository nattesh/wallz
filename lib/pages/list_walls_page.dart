import 'package:flutter/material.dart';
import 'package:wallz/api/wall_items_api.dart';
import 'package:wallz/models/api_response.dart';
import 'package:wallz/models/filters.dart';
import 'package:wallz/widgets/list_walls_widget.dart';
import 'package:wallz/widgets/filters_bottom_sheet.dart';

class ListWallPage extends StatefulWidget {
  const ListWallPage({Key? key, required this.title, required this.filters}) : super(key: key);

  final String title;
  final Filters filters;

  @override
  State<ListWallPage> createState() => _ListWallPageState();
}

class _ListWallPageState extends State<ListWallPage> {

  late Future<ApiResponse> data;
  late Filters filters;

  @override
  void initState() {
    super.initState();
    filters = widget.filters;
    data = getData(1, filters);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Filters? res = await showModalBottomSheet<Filters>(
            context: context,
            builder: (_) => FiltersBottomSheet(filters: widget.filters, oldTitle: widget.title,)
          );

          if(res != null) {
            filters = res;
            setState(() {
              data = getData(1, filters);
            });
          }
        },
        child: Icon(Icons.filter_list),
        backgroundColor: widget.filters.colors.isNotEmpty ?
            Color(int.parse('0xff' + widget.filters.colors))
            : Color.fromARGB(255, 48, 48, 48),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data;
            if(data != null && data.data != null && data.data.length > 0) {
              return ListWalls(walls: data.data, lastPage: data.meta.lastPage, filters: widget.filters,);
            } else {
              return Center(child: Text('No results found'));
            }
          } else {
            return Center(child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ));
          }
        }),
    );
  }
}