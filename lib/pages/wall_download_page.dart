import 'package:flutter/material.dart';
import 'package:wallz/models/wall_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wallz/widgets/modal_bottom_sheet.dart';

class WallDownloadPage extends StatefulWidget {
  const WallDownloadPage({Key? key, required this.item}) : super(key: key);

  final WallItem item;

  @override
  State<WallDownloadPage> createState() => _WallDownloadPageState();
}

class _WallDownloadPageState extends State<WallDownloadPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: CircularProgressIndicator()
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
            builder: (_) => ModalBottomSheet(item: widget.item,),
          );
        },
        child: const Icon(Icons.info),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
    );
  }
}