import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class NewRegisterButton extends StatelessWidget {
  final void Function() onPressed;
  final DateTime time;
  final String risk;

  const NewRegisterButton(
      {Key? key,
      required this.onPressed,
      required this.time,
      required this.risk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      onPressed: this.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.calendar_today_rounded),
                SizedBox(width: 5),
                Text('24/08/2021')
              ]),
              SizedBox(height: 5),
              Row(children: [
                Icon(Icons.watch_later_outlined),
                SizedBox(width: 5),
                Text('18:13 p.m.')
              ])
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.radio_button_checked_rounded,
              ),
              SizedBox(width: 5),
              Text('Sin síntomas'),
            ],
          )
        ],
      ),
    );
    // return Ink(
    //   decoration: ShapeDecoration(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(18),
    //     ),
    //     color: Colors.amber,
    //   ),
    //   child: IconButton(
    //     onPressed: () {},
    //     icon: Icon(Icons.add),
    //   ),
    // );
  }
}
