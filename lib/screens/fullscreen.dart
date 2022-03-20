import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:willy_wallpaper/widgets/floating_button.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({Key? key, required this.imageurl}) : super(key: key);
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  bool isActive = false;
  bool downloading = false;

  @override
  void initState() {
    super.initState();
    imageDownload(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isActive = !isActive;
      }),
      child: Scaffold(
        floatingActionButton: const FloatingButton(),
        body: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: widget.imageurl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> imageDownload(
    BuildContext context,
  ) async {
    final progressString = Wallpaper.imageDownloadProgress(widget.imageurl);
    progressString.listen(
      (data) {
        log("DataReceived: " + data);
      },
      onDone: () async {
        setState(() {});
        log("Task Done");
      },
      onError: (error) {
        setState(() {});
        log("Some Error");
      },
    );
  }
}
