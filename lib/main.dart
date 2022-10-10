import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:willy_wallpaper/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Willy Wallpapers',
      debugShowCheckedModeBanner: false,
      builder: Asuka.builder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          accentColor: Colors.black,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
