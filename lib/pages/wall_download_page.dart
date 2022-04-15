import 'package:flutter/material.dart';
import 'package:wallz/models/wall_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wallz/widgets/modal_bottom_sheet.dart';
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
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              )
            ),
            PhotoView(
              initialScale: PhotoViewComputedScale.covered * 1.0,
              enableRotation: false,
              enablePanAlways: false,
              imageProvider: CachedNetworkImageProvider(widget.item.path),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
         // onPressed: () => _saveNetworkImage(context),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (_) => ModalBottomSheet(details: responseDetails.data,),
          );
        },
        child: const Icon(Icons.info),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
    );
  }
}