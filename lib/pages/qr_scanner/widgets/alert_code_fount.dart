import 'package:covserver/config/theme.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:flutter/material.dart';

class AlertCodeFound extends StatefulWidget {
  final String code;
  final Function? onAccepted;

  const AlertCodeFound({Key? key, required this.code, this.onAccepted})
      : super(key: key);

  @override
  _AlertCodeFoundState createState() => _AlertCodeFoundState();
}

class _AlertCodeFoundState extends State<AlertCodeFound> {
  bool notFound = false;
  bool loading = false;
  Map? response;

  @override
  void initState() {
    super.initState();
    _makeRequest();
  }

  /// Make the request to the api
  void _makeRequest() async {
    // Prevent multiple calls
    if (loading) return;
    setState(() => loading = true);
    // Api request
    Map? res = await assignToGroup(widget.code);
    // Response handling
    if (res != null) setState(() => response = res);
    if (res?['group'] == null) setState(() => notFound = true);

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    String assignType =
        widget.code.toUpperCase().startsWith('M') ? 'miembro' : 'visitante';

    return AlertDialog(
      content: loading // If it's loading
          ? Text('Cargando')
          : notFound // If the user has not been found
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hubo un problema',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      response?['msg'],
                      style: TextStyle(
                          color: applicationColors['font_light'], fontSize: 19),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Column(
                  // If the user has been found and assigned to a group
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Encontramos el grupo',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Se ha unido a ${response?['group']['concatName']} como $assignType.',
                      style: TextStyle(
                          color: applicationColors['font_light'], fontSize: 19),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
      actions: !loading
          ? [
              TextButton(
                onPressed: () {
                  if (widget.onAccepted != null) widget.onAccepted!();
                  if (notFound)
                    Navigator.pop(context);
                  else
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: Text(
                  "Está bien",
                  style: TextStyle(
                    color: applicationColors['medium_purple'],
                    fontSize: 16,
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}