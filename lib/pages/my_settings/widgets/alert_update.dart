import 'package:covserver/config/theme.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/widgets/loader.dart';
import 'package:flutter/material.dart';

class AlertUpdate extends StatefulWidget {
  final User newUser;
  final void Function() onAccepted;

  const AlertUpdate({Key? key, required this.newUser, required this.onAccepted})
      : super(key: key);

  @override
  _AlertUpdateState createState() => _AlertUpdateState();
}

class _AlertUpdateState extends State<AlertUpdate> {
  bool loading = true;
  bool reqError = false;

  Future<void> _getDataByAPI() async {
    Map? updatedUser = await updateUser(widget.newUser);
    if (updatedUser == null) setState(() => reqError = true);
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    _getDataByAPI();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: loading // If it's loading
          ? Loader()
          : reqError
              ? Text(
                  'Hubo un problema con la actualización. Inténtalo más tarde.')
              : Column(
                  // If the user has been found and assigned to a group
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '¡Excelente!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Los datos se actualizaron correctamente',
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
                  widget.onAccepted();
                  Navigator.pop(context);
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
