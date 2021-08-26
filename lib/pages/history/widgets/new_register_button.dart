import 'package:covserver/config/theme.dart';
import 'package:covserver/models/history_model.dart';
import 'package:covserver/pages/symptom_history/symptom_history.dart';
import 'package:flutter/material.dart';

class NewRegisterButton extends StatelessWidget {
  final void Function() onPressed;
  final HistoryModel history;

  const NewRegisterButton(
      {Key? key, required this.onPressed, required this.history})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var splitedDate = this.history.time.toString().split(' ');

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        primary: applicationColors['input_light']!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPrimary: applicationColors['font_light']!.withOpacity(0.75),
      ),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SymptomHistory(history: history))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.calendar_today_rounded),
                SizedBox(width: 5),
                Text(splitedDate[0])
              ]),
              SizedBox(height: 5),
              Row(children: [
                Icon(Icons.watch_later_outlined),
                SizedBox(width: 5),
                Text(splitedDate[1].substring(0, 5))
              ])
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.radio_button_checked_rounded,
              ),
              SizedBox(width: 5),
              Text(this.history.parsedStatus),
            ],
          )
        ],
      ),
    );
  }
}
