import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme.dart';

class PageIndexViewer extends StatelessWidget {
  final List selectedPages;
  int selectedPage;

  PageIndexViewer({Key key, this.selectedPages, this.selectedPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double marginTop = MediaQuery.of(context).size.height - 100;
    return Positioned(
      top: marginTop,
      left: 35,
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _drawDots(),
        ),
      ),
    );
  }

  _drawDots() {
    List<Widget> dots = [];
    selectedPages.asMap().forEach((index, element) {
      dots.add(_PageDot(isSelected: this.selectedPage == index));
      if (index != selectedPages.length - 1) dots.add(SizedBox(width: 15));
    });
    return dots;
  }
}

class _PageDot extends StatelessWidget {
  final bool isSelected;

  const _PageDot({Key key, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dotSize = 10;
    return Container(
      height: dotSize,
      width: dotSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dotSize / 2),
          color: this.isSelected ? Colors.white : applicationColors['lila']),
    );
  }
}
