import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../config/constants.dart';

class CatImageDialog extends StatelessWidget {
  final String baseUrl = Constants.cataasUrl;
  final int reqCount;

  CatImageDialog({required this.reqCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dialog(
          child: Container(
            width: 350,
            height: 350,
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: "$baseUrl/cat?req=$reqCount",
                    imageErrorBuilder: (context, error, stackTrage) => Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(8.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.red),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.clear,
            size: 26.0,
          ),
        ),
      ],
    );
  }
}
