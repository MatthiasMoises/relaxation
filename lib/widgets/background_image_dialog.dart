import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundImageDialog extends StatelessWidget {
  final String currentBackgroundImage;
  final Function updateBackgroundImageHandler;

  BackgroundImageDialog({
    required this.currentBackgroundImage,
    required this.updateBackgroundImageHandler,
  });

  final List backgroundImages = [
    'bkgnd_1.jpg',
    'bkgnd_2.jpg',
    'forest_1.jpg',
    'forest_2.jpg',
    'ocean_1.jpg',
    'ocean_2.jpg',
    'rain_1.jpg',
    'rain_2.jpg',
    'sunset_1.jpg',
    'sunset_2.jpg',
  ];

  void updateBackgroundImage(image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundImage', image);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 400,
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: backgroundImages.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/' + backgroundImages[index],
                      ),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                    if (currentBackgroundImage ==
                        'assets/images/' + backgroundImages[index])
                      Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  updateBackgroundImageHandler(backgroundImages[index]);
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
