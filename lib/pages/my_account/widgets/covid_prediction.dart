import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidPrediction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fontSize = (MediaQuery.of(context).size.width - 200) * (0.09);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
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
                    'Herramienta para ver probabilidad de contagio',
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
                    onPressed: _launchURL,
                    child: Text(
                      'Saber más',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5)
                ],
              ),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/facemask_guy.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url =
      'https://www.zeit.de/wissen/gesundheit/2020-11/coronavirus-aerosols-infection-risk-hotspot-interiors?utm_referrer=https%3A%2F%2Fwww.rtve.es%2F';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
