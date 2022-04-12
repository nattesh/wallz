import 'package:flutter/material.dart';
import 'package:wallz/models/wall_item.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

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

  void _saveNetworkImage(BuildContext context) async {
    String path = widget.item.path;
    await GallerySaver.saveImage(path);
    _showToast(context);
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Downloaded'),
        action: SnackBarAction(label: 'Hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
          initialScale: PhotoViewComputedScale.covered * 1.0,
          enableRotation: false,
          enablePanAlways: false,
          imageProvider: CachedNetworkImageProvider(widget.item.path),
        )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _saveNetworkImage(context),
          child: const Icon(Icons.downloading),
          backgroundColor: Colors.blueAccent,
      ),
    );
  }
}