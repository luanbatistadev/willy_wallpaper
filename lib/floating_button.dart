import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
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
        FloatingActionButton(
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
          heroTag: 'save',
          backgroundColor: Colors.black,
          child: const Icon(Icons.save),
          onPressed: () {
            toogleMenu();
          },
        ),
        FloatingActionButton(
          heroTag: 'home',
          backgroundColor: Colors.black,
          child: const Icon(Icons.home),
          onPressed: () async {
            await Wallpaper.homeScreen();
          },
        ),
        FloatingActionButton(
          heroTag: 'lock',
          backgroundColor: Colors.black,
          child: const Icon(Icons.lock),
          onPressed: () async {
            await Wallpaper.lockScreen();
          },
        ),
        FloatingActionButton(
          heroTag: 'Both',
          backgroundColor: Colors.black,
          child: const Text('Both'),
          onPressed: () async {
            await Wallpaper.bothScreen();
          },
        ),
      ],
    );
  }
}
