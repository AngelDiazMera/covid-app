import 'package:covserver/config/theme.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/widgets/loader.dart';
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
  String step = 'find';
  bool loading = false;
  bool connectionFailed = false;
  Map response = new Map();

  @override
  void initState() {
    super.initState();
    _makeRequest('find');
  }

  /// Make the request to the api
  void _makeRequest(String type) async {
    Map<String, Function> request = {
      'find': getGroup,
      'update': assignToGroup,
    };

    bool hasError = false;
    // Prevent multiple calls
    if (loading) return;
    setState(() => loading = true);
    // Api request
    Map? res = await request[type]!(widget.code,
        onError: (String err) => hasError = true);
    // Error handler
    if (hasError) {
      setState(() {
        connectionFailed = true;
        loading = false;
      });
      return;
    }
    // Api response
    setState(() {
      response = res!;
      loading = false;
    });
  }

  /// Draw alert content when wants to find a group
  Widget _drawStep1Body(String assignType) => Column(
        // If the user has been found and assigned to a group
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Encontramos el grupo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '¿Desea unirse al grupo ${response['group']['concatName']} como $assignType?',
            style:
                TextStyle(color: applicationColors['font_light'], fontSize: 19),
            textAlign: TextAlign.center,
          ),
        ],
      );

  /// Draw alert content when register
  Widget _drawStep2Body(String assignType) => Column(
        // If the user has been found and assigned to a group
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Excelente',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Se ha unido a ${response['group']['concatName']} como $assignType.',
            style:
                TextStyle(color: applicationColors['font_light'], fontSize: 19),
            textAlign: TextAlign.center,
          ),
        ],
      );

  /// Draw action buttons when an error occurs
  List<Widget> _drawErrorActions() => [
        TextButton(
          onPressed: () {
            if (widget.onAccepted != null) widget.onAccepted!();
            Navigator.pop(context);
          },
          child: Text(
            "Está bien",
            style: TextStyle(
              color: applicationColors['medium_purple'],
              fontSize: 16,
            ),
          ),
        )
      ];

  /// Draw action buttons when wants to find a group
  List<Widget> _drawStep1Actions() => [
        TextButton(
          onPressed: () {
            if (widget.onAccepted != null) widget.onAccepted!();
            Navigator.pop(context);
          },
          child: Text(
            "No, cancelar",
            style: TextStyle(
              color: applicationColors['medium_purple'],
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() => step = 'update');
            _makeRequest('update');
          },
          child: Text(
            "Sí",
            style: TextStyle(
              color: applicationColors['medium_purple'],
              fontSize: 16,
            ),
          ),
        ),
      ];

  /// Draw action buttons when register
  List<Widget> _drawStep2Actions(bool notFound) => [
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
      ];

  /// Draw alert content if the user was not found
  Widget _drawNotFound() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hubo un problema',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            response['msg'],
            style:
                TextStyle(color: applicationColors['font_light'], fontSize: 19),
            textAlign: TextAlign.center,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    String assignType =
        widget.code.toUpperCase().startsWith('M') ? 'miembro' : 'visitante';

    bool notFound = response.containsKey('msg') && response['group'] == null;

    return AlertDialog(
      content: connectionFailed
          ? Text(
              'Parece que hubo un problema con el servidor. Inténtalo más tarde.')
          : loading // If it's loading
              ? Loader()
              : notFound // If the user has not been found
                  ? _drawNotFound()
                  : step == 'find'
                      ? _drawStep1Body(assignType)
                      : _drawStep2Body(assignType),
      actions: connectionFailed
          ? _drawErrorActions()
          : !loading
              ? notFound
                  ? _drawStep2Actions(notFound)
                  : step == 'find'
                      ? _drawStep1Actions()
                      : _drawStep2Actions(notFound)
              : null,
    );
  }
}
