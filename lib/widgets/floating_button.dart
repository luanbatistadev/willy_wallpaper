import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:willy_wallpaper/overlay/asuka_overlay_service_impl.dart';
import 'package:willy_wallpaper/widgets/vertical_actions_button.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final menuIsOpen = ValueNotifier<bool>(false);
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toogleMenu() {
    menuIsOpen.value
        ? animationController.reverse()
        : animationController.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: VerticalActionButton(animation: animationController),
      clipBehavior: Clip.none,
      children: [
        isLoading
            ? FloatingActionButton(
                backgroundColor: Colors.black,
                heroTag: 'loading',
                child: const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              )
            : FloatingActionButton(
                backgroundColor: Colors.black,
                heroTag: 'menu',
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animationController,
                ),
                onPressed: () {
                  toogleMenu();
                },
              ),
        FloatingActionButton(
          heroTag: 'home',
          backgroundColor: Colors.black,
          child: const Icon(Icons.home),
          onPressed: () async {
            execute(Wallpaper.homeScreen());
          },
        ),
        FloatingActionButton(
          heroTag: 'lock',
          backgroundColor: Colors.black,
          child: const Icon(Icons.lock),
          onPressed: () async {
            execute(Wallpaper.lockScreen());
          },
        ),
        FloatingActionButton(
          heroTag: 'both',
          backgroundColor: Colors.black,
          child: const Text('Both'),
          onPressed: () async {
            execute(Wallpaper.bothScreen());
          },
        ),
      ],
    );
  }

  Future<void> execute(Future<String> function) async {
    try {
      setState(() {
        isLoading = true;
      });
      toogleMenu();
      final result = await function;
      log(result);
      AsukaOverlayServiceImpl().showSuccessSnackBar(result);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      AsukaOverlayServiceImpl().showErrorSnackBar('Wallpaper not set');
    }
  }
}
