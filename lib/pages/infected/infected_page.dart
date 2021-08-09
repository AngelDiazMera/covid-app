import 'package:flutter/material.dart';

import 'package:covserver/pages/infected/widgets/member_alert_data.dart';
import 'package:covserver/pages/infected/widgets/visit_alert_data.dart';
import 'package:covserver/pages/infected/widgets/action_buttons.dart';
import 'package:covserver/pages/infected/widgets/alert_header.dart';
import 'package:covserver/pages/infected/widgets/alert_icon.dart';

import 'package:covserver/services/api/requests.dart';

/// Page displayed when handle infected notifications
class InfectedPage extends StatefulWidget {
  @override
  _InfectedPageState createState() => _InfectedPageState();
}

class _InfectedPageState extends State<InfectedPage> {
  // Flags
  bool loading = true;
  bool isRequesting = false;
  // Data retrieved from api
  Map? alert = new Map();

  /// Loads the data making a request to the api
  void loadAlert(Map args) async {
    if (!loading) return;
    if (isRequesting) return;
    setState(() => isRequesting = true);
    Map? data =
        await getAlertData(args['userRef'], args['groupRef'], args['anonym']);
    setState(() {
      alert = data;
      loading = false;
      isRequesting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Data from the notification
    final Map args =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>? ??
            {};
    // Get data from server
    loadAlert(args);
    // Sizes
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Container(), // To fit stack
          AlertHeader(loading: loading), // Violet background
          AlertIcon(loading: loading), // Rotated alert icon
          Positioned(
            // Draws the requested data
            width: screenWidth,
            height: (screenHeight * 4 / 7) - (125 / 2) - 80,
            top: (screenHeight * 3 / 7) + (125 / 2),
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              curve: Curves.easeInQuart,
              opacity: loading ? 0.0 : 1.0,
              child: args['type'] == 'visit_infection'
                  ? VisitAlertData(alert: alert!, args: args)
                  : MemberAlertData(alert: alert!, args: args),
            ),
          ),
          ActionButtons(loading: loading), // Action buttons
        ],
      ),
    );
  }
}
