import 'package:covserver/pages/infected/widgets/alert_make_infected.dart';
import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';

class ActionButtons extends StatelessWidget {
  final int alarmId = 0;
  final int notifId = 0;
  final bool loading;

  const ActionButtons({Key? key, this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To handle health condition provider

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: screenHeight - 80,
      width: screenWidth - 70,
      child: AnimatedOpacity(
        duration: Duration(seconds: 1),
        curve: Curves.easeInQuart,
        opacity: loading ? 0.0 : 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(255, 255, 255, 1)),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                foregroundColor: MaterialStateProperty.all<Color?>(
                    applicationColors['medium_purple']),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                        width: 2, color: applicationColors['medium_purple']!),
                  ),
                ),
              ),
              child: const Text("Descartar"),
            ),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertMakeInfected(),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.all<Color?>(
                  applicationColors['medium_purple'],
                ),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                foregroundColor: MaterialStateProperty.all<Color?>(
                    applicationColors['font_dark']),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: const Text("Estoy en riesgo"),
            ),
          ],
        ),
      ),
    );
  }
}
