import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// All the header widget
class CustomHeader extends StatelessWidget {
  final double top;
  final Widget child;
  final Widget header;

  const CustomHeader({Key key, this.top = -50, this.child, this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 600;
    double width = MediaQuery.of(context).size.width;

    BorderRadius radius = BorderRadius.only(
        bottomLeft: Radius.circular(size / 2),
        bottomRight: Radius.circular(size / 2));

    return Positioned(
      top: this.top,
      left: (-size + width) / 2,
      child: Container(
        height: size / 2,
        width: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromRGBO(57, 72, 235, 1),
            Color.fromRGBO(99, 109, 240, 1),
          ]),
          borderRadius: radius,
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 15)
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: (size - width) / 2),
            child: _HeaderContent(
                top: this.top, child: this.child, header: this.header),
          ),
        ),
      ),
    );
  }
}

// Widget which draws the content of the header
class _HeaderContent extends StatelessWidget {
  final double top;
  final Widget child;
  final Widget header;

  const _HeaderContent({Key key, @required this.top, this.child, this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: -top + 20),
        _drawAppBar(width), // Button to switch the mode
        this.child
      ],
    );
  }

  // Draws dark theme button
  Widget _drawAppBar(double width) {
    return Container(
      width: width,
      height: 50,
      child: this.header,
    );
  }
}
