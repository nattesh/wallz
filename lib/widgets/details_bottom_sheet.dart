import 'package:flutter/material.dart';
import 'package:wallz/models/details_data.dart';
import 'package:intl/intl.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallz/models/tag.dart';
import 'package:wallz/models/filters.dart';
import 'package:wallz/pages/list_walls_page.dart';
import 'package:wallz/utils/extensions.dart';
import 'package:wallz/utils/constants.dart';
import 'package:wallz/models/query_filter.dart';

class DetailsBottomSheet extends StatefulWidget {
  const DetailsBottomSheet({Key? key, required DetailsData this.details, required Filters this.filters}) : super(key: key);

  final DetailsData details;
  final Filters filters;

  @override
  State<DetailsBottomSheet> createState() => _DetailsBottomSheetState();
}

class _DetailsBottomSheetState extends State<DetailsBottomSheet> {

  bool downloading = false;
  bool done = false;
  late Filters searchFilters;

  @override
  void initState() {
    super.initState();
    searchFilters = widget.filters;
  }

  void _saveNetworkImage(BuildContext context) async {
    _startDownloading();
    String path = widget.details.path;
    await GallerySaver.saveImage(path);
    _endDownloading();
  }

  void _startDownloading() {
    setState(() {
      downloading = true;
    });
  }

  void _endDownloading() {
    setState(() {
      downloading = false;
      done = true;
    });
  }

  _search(BuildContext context, Filters filters, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListWallPage(title: title, filters: filters,)),
    );
  }

  _searchByColor(String color, BuildContext context) {
    QueryFilter query = QueryFilter('', '', '');
    Filters newFilters = Filters(widget.filters.ratios, widget.filters.categories, '100', '', '', '', query);
    newFilters.colors = color.replaceAll('#', '');
    _search(context, newFilters, 'By color');
  }

  _searchByTag(String tag, BuildContext context) {
    QueryFilter query = QueryFilter(tag, '', '');
    Filters newFilters = Filters(widget.filters.ratios, widget.filters.categories, '100', '', '', '', query);
    _search(context, newFilters, tag.capitalize());
  }

  _searchForSimilar(String like, BuildContext context) {
    QueryFilter query = QueryFilter('', '', like);
    Filters newFilters = Filters(widget.filters.ratios, widget.filters.categories, '100', '', '', '', query);
    _search(context, newFilters, 'Similar');
  }

  _searchByUser(String username, BuildContext context) {
    QueryFilter query = QueryFilter('', username, '');
    Filters newFilters = Filters(widget.filters.ratios, widget.filters.categories, '100', '', '', '', query);
    _search(context, newFilters, 'By user: ${username}');
  }

  List<Widget> _renderColors(List<String> colors, BuildContext context) {
    List<Widget> rendered = [];
    colors.forEach((c) {
      String cleaned = c.replaceAll('#', '');
      String parsed = '0xFF' + cleaned;
      rendered.add(
        Padding (
          padding: EdgeInsets.only(right: 5),
          child: RaisedButton(
            onPressed: () => _searchByColor(c, context),
            textColor: Color(int.parse(parsed)),
            color: Color(int.parse(parsed)),
          ),
        ),
      );
    });
    return rendered;
  }

  List<Widget> _renderTags(List<Tag> tags, BuildContext context) {
    List<Widget> rendered = [];
    tags.forEach((t) {
      rendered.add(
        ElevatedButton(
          child: Text(t.name),
          onPressed: () => _searchByTag(t.name, context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)
              )
            )
          )
        )
      );
      rendered.add(Padding(
        padding: EdgeInsets.all(3),
      ));
    });
    return rendered;
  }

  Widget _renderDownloadSection() {
    if(downloading) {
      return Container(
        height: 50,
        child:
          Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
      );
    } else {
      if(done) {
        return Container(
          height: 50,
          child: Center(
            child: Text('DONE!',
              style: TextStyle(
                fontSize: (15)
              ),
            ),
          ),
        );
      } else {
        return ElevatedButton(
          child: Text('DOWNLOAD'),
          onPressed: () => _saveNetworkImage(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)
              )
            )
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 8 / 5,
      child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: double.infinity,
                child: _renderDownloadSection(),
              )
            ),
            Column (
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Details',
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      children: [
                        Text('Uploader' + ': ',
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 32,
                          child: Image.network(widget.details.uploader.avatar.large),
                        ),
                        Text(' ' + widget.details.uploader.username,
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => _searchByUser(widget.details.uploader.username, context),
                        ),
                      ],
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Row (
                    children: [
                      Icon(
                        Icons.thumb_up
                      ),
                      Text(' ' + widget.details.favorites.toString() + '    ',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Icon(
                          Icons.remove_red_eye_sharp
                      ),
                      Text(' ' + widget.details.views.toString() + '  ',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      getOrientationIcon(widget.details.dimensionX, widget.details.dimensionY),
                      Text(' ' + widget.details.resolution,
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Colors' + ': ',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _renderColors(widget.details.colors, context),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Tags' + ': ',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _renderTags(widget.details.tags, context),
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => _searchForSimilar(widget.details.id.toString(), context),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          Text(' Search for similar'),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)
                          )
                        )
                      ),
                    ),
                  )
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ),
          ]
      ),
    );
  }
}