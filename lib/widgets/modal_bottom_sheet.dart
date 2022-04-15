import 'package:flutter/material.dart';
import 'package:wallz/models/details_data.dart';
import 'package:intl/intl.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallz/models/tag.dart';
import 'package:wallz/models/filters.dart';
import 'package:wallz/pages/list_walls_page.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({Key? key, required DetailsData this.details}) : super(key: key);

  final DetailsData details;

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {

  bool downloading = false;
  bool done = false;

  @override
  void initState() {
    super.initState();
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

  _searchByColors(List<String> colors, BuildContext context) {
    Filters filters = new Filters('portrait',
        '100', '100', '', '', colors[0].replaceAll('#', ''), '', '');
    _search(context, filters, 'By colors');
  }

  List<Widget> _renderColors(List<String> colors, BuildContext context) {
    List<Widget> rendered = [];
    colors.forEach((c) {
      String cleaned = c.replaceAll('#', '');
      String parsed = '0xFF' + cleaned;
      rendered.add(
          Container(
            width: 50,
            height: 20,
            margin: EdgeInsets.all(2),
            color: Color(int.parse(parsed)),
          )
      );
    });
    rendered.add(
      IconButton(
        onPressed: () => _searchByColors(colors, context),
        icon: Icon(
          Icons.search
        ),
      )
    );
    return rendered;
  }

  List<Widget> _renderTags(List<Tag> tags) {
    List<Widget> rendered = [];
    tags.forEach((t) {
      rendered.add(
          Text(' #' + t.name,
            style: TextStyle(
              color: Colors.white,
            ),
          )
      );
    });
    return rendered;
  }

  Widget _renderDownloadSection() {
    if(downloading) {
      return Container(
        height: 50,
        child:
          Center(
            child: CircularProgressIndicator(),
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
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blueAccent)
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
      color: Colors.blueGrey,
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
                      Icon(
                          Icons.remove_red_eye_sharp
                      ),
                      Text(' ' + widget.details.views.toString() + '  ',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      )
                    ],

                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Resolution' + ': ' + widget.details.resolution,
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Created at' + ': ' + DateFormat('dd-MM-yyyy').format(widget.details.createdAt),
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Colors' + ': ',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: _renderColors(widget.details.colors, context),
                    )
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
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 2,
                        spacing: 1,
                        children: _renderTags(widget.details.tags),
                      ),
                    ),
                  )
                ),
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