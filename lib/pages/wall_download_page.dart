import 'package:flutter/material.dart';
import 'package:wallz/models/wall_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wallz/widgets/details_bottom_sheet.dart';
import 'package:wallz/models/api_details_response.dart';
import 'package:wallz/api/wall_items_api.dart';

class WallDownloadPage extends StatefulWidget {
  const WallDownloadPage({Key? key, required this.item}) : super(key: key);

  final WallItem item;

  @override
  State<WallDownloadPage> createState() => _WallDownloadPageState();
}

class _WallDownloadPageState extends State<WallDownloadPage> {

  late ApiDetailsResponse responseDetails;

  @override
  void initState() {
    super.initState();
    getDetails(widget.item.id).then((res) {
      responseDetails = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Hero(
          tag: widget.item.id,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image(
                    image: NetworkImage(widget.item.thumbs.original),
                    fit: BoxFit.cover
                ),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              PhotoView(
                initialScale: PhotoViewComputedScale.covered * 1.0,
                enableRotation: false,
                enablePanAlways: false,
                imageProvider: CachedNetworkImageProvider(widget.item.path),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(0, 50, 20, 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 48, 48, 48)),
                    shadowColor: MaterialStateProperty.all(Colors.black)
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(19, 10, 10, 10),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              )
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (_) => DetailsBottomSheet(details: responseDetails.data,),
            );
          },
          child: const Icon(Icons.info),
          backgroundColor: Color.fromARGB(255, 48, 48, 48),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}