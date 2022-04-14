import 'package:flutter/material.dart';
import 'package:wallz/models/wall_item.dart';
import 'package:intl/intl.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({Key? key, required WallItem this.item}) : super(key: key);

  final WallItem item;

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
    String path = widget.item.path;
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

  List<Widget> _renderColors(List<String> colors) {
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
      height: 330,
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
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Resolution' + ': ' + widget.item.resolution,
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Created at' + ': ' + DateFormat('dd-MM-yyyy').format(widget.item.createdAt),
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
                      children: _renderColors(widget.item.colors),
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