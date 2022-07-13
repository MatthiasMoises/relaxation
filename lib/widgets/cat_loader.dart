import 'package:flutter/material.dart';

import './cat_image_dialog.dart';

class CatLoader extends StatefulWidget {
  @override
  _CatLoaderState createState() => _CatLoaderState();
}

class _CatLoaderState extends State<CatLoader> {
  int _reqCount = 0;

  Future _loadRandomCatImage() async {
    setState(() {
      _reqCount++;
    });

    await showDialog(
      context: context,
      builder: (_) => Dismissible(
        key: Key(_reqCount.toString()),
        child: CatImageDialog(
          reqCount: _reqCount,
        ),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          Navigator.pop(context);
          _loadRandomCatImage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.pets,
        size: 80.0,
        color: Colors.white,
      ),
      onTap: _loadRandomCatImage,
    );
  }
}
