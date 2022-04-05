import 'package:flutter/material.dart';
import 'package:wallz/models/wall_item.dart';
import 'package:wallz/api/wall_items_api.dart';
import 'package:wallz/pages/wall_download_page.dart';

class ListWalls extends StatefulWidget {

  const ListWalls({Key? key, required this.walls, required this.onePage}) : super(key: key);

  final List<WallItem> walls;
  final bool onePage;

  @override
  State<ListWalls> createState() => _ListWallsState();
}

class _ListWallsState extends State<ListWalls> {

  int requestPage = 1;
  int renderedPage = 0;
  double offset = 0;
  bool isLastPage = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    this.isLastPage = widget.onePage;
    _scrollController.addListener(() {

      double currentPos = _scrollController.offset;
      double maxPos = _scrollController.position.maxScrollExtent;

      if(offset == 0) {
        offset = maxPos - 1;
      }

      bool gotTriggerPoint = currentPos > (maxPos - offset);
      bool isLastPageRendered = requestPage == renderedPage;

      if(gotTriggerPoint && isLastPageRendered && !isLastPage) {
        loadNewPage();
      }
    });
  }

  void loadNewPage() async {
    requestPage++;
    var res = await getData(requestPage);
    isLastPage = requestPage == res.meta.lastPage;
    _addItems(res.data, isLastPage);
  }

  void _addItems(List<WallItem> newItems, bool lastPage) {
    setState(() {
      isLastPage = lastPage;
      widget.walls.addAll(newItems);
    });
  }


  List<Widget> itemList() {
    List<Widget> result = [];

    widget.walls.forEach((element) {
      var src = element.thumbs.original;
      var img = Image(
          image: NetworkImage(src),
          fit: BoxFit.cover
      );

      result.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WallDownloadPage(item: element,);
            }));
          },
          child: Hero(
              tag: element.id,
              child: img
          )
        ));
    });
    renderedPage++;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      controller: _scrollController,
      slivers: <Widget> [
        SliverPadding(
          padding: const EdgeInsets.all(5),
          sliver: SliverGrid.count(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              children: itemList()
          ),
        ),
      ],
    );
  }
}