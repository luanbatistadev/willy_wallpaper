import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

import 'i_overlay_service.dart';

class AsukaOverlayServiceImpl implements IOverlayService {
  @override
  Future<void> showSuccessSnackBar(String content) async {
    final snackBar = TADSCustomSnackBar.success(content);

    Asuka.showSnackBar(snackBar);
  }

  @override
  Future<void> showErrorSnackBar(String content) async {
    final snackBar = TADSCustomSnackBar.error(content);

    Asuka.showSnackBar(snackBar);
  }
}

class TADSCustomSnackBar extends SnackBar {
  TADSCustomSnackBar({
    Key? key,
    required String content,
    required Color color,
    required IconData? icon,
  }) : super(
          key: key,
          duration: const Duration(seconds: 4),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () => Asuka.hideCurrentSnackBar(),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );

  factory TADSCustomSnackBar.success(String content) =>
      TADSCustomSnackBar(content: content, color: Colors.black, icon: Icons.check);

  factory TADSCustomSnackBar.error(String content) =>
      TADSCustomSnackBar(content: content, color: Colors.black, icon: Icons.error);
}
