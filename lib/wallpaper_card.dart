import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:willy_wallpaper/data/data.dart';
import 'package:willy_wallpaper/screens/fullscreen.dart';

class WallpaperCard extends StatelessWidget {
  final WallPaper wallpaper;
  const WallpaperCard({Key? key, required this.wallpaper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreen(
              imageurl: wallpaper.highQuality,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: wallpaper.lowQuality,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
