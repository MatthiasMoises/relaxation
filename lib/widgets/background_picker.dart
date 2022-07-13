import 'package:flutter/material.dart';

import 'background_image_dialog.dart';

class BackgroundPicker extends StatelessWidget {
  final String currentBackgroundImage;
  final Function updateBackgroundImageHandler;

  BackgroundPicker({
    required this.currentBackgroundImage,
    required this.updateBackgroundImageHandler,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.photo,
        size: 80.0,
        color: Colors.white,
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) => BackgroundImageDialog(
            currentBackgroundImage: currentBackgroundImage,
            updateBackgroundImageHandler: updateBackgroundImageHandler,
          ),
        );
      },
    );
  }
}
