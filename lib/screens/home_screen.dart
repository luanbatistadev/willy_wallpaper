import 'package:flutter/material.dart';
import 'package:willy_wallpaper/data/data.dart';
import 'package:willy_wallpaper/widgets/wallpaper_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color kAppBarColor = const Color(0x08082DFF);
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: kAppBarColor,
            title: const Text(
              'Willy WallPapers',
              style: TextStyle(fontFamily: 'Quicksand'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final wallpaper = listWallpapers[i];
                  return WallpaperCard(wallpaper: wallpaper);
                },
                childCount: listWallpapers.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
