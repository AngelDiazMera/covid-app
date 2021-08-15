import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class CovidKnowMore extends StatelessWidget {
  String asset;
  String url;
  String description;

  CovidKnowMore(
      {Key? key,
      required this.asset,
      required this.url,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = (MediaQuery.of(context).size.width - 200) * (0.09);
    return Container(
      margin: EdgeInsets.all(15),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color.fromRGBO(57, 72, 235, 1),
            Color.fromRGBO(99, 109, 240, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 15)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, top: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: fontSize,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color.fromRGBO(53, 66, 235, 1)),
                    onPressed: () => launchURL(url),
                    child: Text(
                      'Saber más',
                      style: TextStyle(fontSize: fontSize, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1 / 6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
