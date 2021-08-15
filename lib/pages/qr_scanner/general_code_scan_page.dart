import 'package:covserver/pages/qr_scanner/views/manual_view.dart';
import 'package:covserver/pages/qr_scanner/views/qr_view.dart';
import 'package:covserver/pages/qr_scanner/widgets/action_buttons.dart';
import 'package:flutter/material.dart';

import 'package:covserver/widgets/violet_background.dart';

class GeneralCodeScan extends StatefulWidget {
  @override
  _GeneralCodeScanState createState() => _GeneralCodeScanState();
}

class _GeneralCodeScanState extends State<GeneralCodeScan> {
  int _selectedIndex = 0;
  // Pages of the pageview
  final List _selectedPages = <Widget>[
    QRScanView(),
    ManualView(),
  ];

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: _selectedIndex);

    return Scaffold(
      body: Stack(
        children: [
          VioletBackground(),
          Container(
            height: MediaQuery.of(context).size.height - 75,
            child: PageView(
              controller: controller,
              children: _selectedPages as List<Widget>,
              scrollDirection: Axis.horizontal,
              onPageChanged: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          ActionButtons(
              pageController: controller, actualIndex: _selectedIndex),
        ],
      ),
    );
  }
}
