import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final PageController pageController;
  final int actualIndex;

  const ActionButtons(
      {Key? key, required this.pageController, required this.actualIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double marginTop = MediaQuery.of(context).size.height - 75;

    return Positioned(
      top: marginTop,
      child: Container(
        // Width of the screen with padding
        width: MediaQuery.of(context).size.width - 70,
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _drawPageButton(0, Icons.qr_code_rounded),
            _drawPageButton(1, Icons.app_registration_rounded),
          ],
        ),
      ),
    );
  }

  Widget _drawPageButton(int toPage, IconData icon) => TextButton(
        onPressed: () {
          pageController.animateToPage(toPage,
              duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
        },
        child: Icon(
          icon,
          size: actualIndex == toPage ? 36 : 32,
          color: applicationColors['background_light_1']!
              .withOpacity(actualIndex == toPage ? 1 : 0.5),
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(15),
            primary: applicationColors['lila'],
            shape: CircleBorder()),
      );
}
