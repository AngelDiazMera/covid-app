import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';

class CalendarDialog extends StatelessWidget {
  final String dates;

  const CalendarDialog({Key? key, required this.dates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> eachDates = dates.split(',');

    List<Widget> columnBody = [
      Text(
          'Entre la fecha de visita de usted o el contagiado y dos horas después.')
    ];
    eachDates.forEach((date) {
      List<String> splDate = date.split(' ');
      String newDate = splDate[0];
      String time = splDate[1];
      columnBody.add(Container(
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            color: applicationColors['medium_purple']!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30)),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: applicationColors['dark_purple'],
                    ),
                    SizedBox(width: 5),
                    Text(
                      newDate,
                      style: TextStyle(
                          fontSize: 16,
                          color: applicationColors['medium_purple']),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_alarms,
                      color: applicationColors['dark_purple'],
                    ),
                    SizedBox(width: 5),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 16,
                          color: applicationColors['medium_purple']),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    });

    return AlertDialog(
      title: Text(
        'Fechas compartidas',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: columnBody,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(
                applicationColors['medium_purple']!.withOpacity(0.15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          child: Text(
            'OK',
            style: TextStyle(
                fontSize: 16, color: applicationColors['medium_purple']),
          ),
        ),
      ],
    );
  }
}
