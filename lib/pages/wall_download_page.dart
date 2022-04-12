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

  TransformationController _controller = TransformationController();
  bool isPortrait = true;
  int x = 0;
  int y = 0;


  @override
  void initState() {
    super.initState();
    x = widget.item.dimensionX;
    y = widget.item.dimensionY;
    bool isPortrait = y > x;
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

  Widget imageWidget(BuildContext context) {
    return Image.network(
      widget.item.path,
      height: MediaQuery.of(context).size.height,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            )
        );
      },
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