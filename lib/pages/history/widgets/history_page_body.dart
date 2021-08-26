import 'package:covserver/config/theme.dart';
import 'package:covserver/models/history_model.dart';
import 'package:covserver/services/database/db.dart';
import 'package:covserver/services/providers/history_provider.dart';
import 'package:covserver/widgets/text_symptom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_register_button.dart';

class HistoryPageBody extends StatefulWidget {
  HistoryPageBody({Key? key}) : super(key: key);

  @override
  _HistoryPageBodyState createState() => _HistoryPageBodyState();
}

class _HistoryPageBodyState extends State<HistoryPageBody> {
  List<HistoryModel> _history = [];
  bool isLoading = true;

  @override
  void initState() {
    _loadHistory();
    super.initState();
  }

  void _loadHistory() async {
    // await DBProvider.db.deleteHistory();
    final history = await DBProvider.db.getCompleteHistory();
    setState(() {
      _history = history;
      isLoading = false;
    });
  }

  Widget _buildRecomButton() => TextButton(
      onPressed: () {},
      child: Text(
        'Ver recomendaciones',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: applicationColors['medium_purple']),
      ),
      style: TextButton.styleFrom(
        primary: applicationColors['background_dark_2'],
      ));

  Widget _buildEmpty() {
    return Container(
      margin: EdgeInsets.all(35),
      child: Opacity(
        opacity: 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextSymptomPage(txt: 'Aún no ha realizado registros'),
            SizedBox(height: 10),
            Text(
              'Pulse el botón de la esquina para agregar tu primer registro.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: applicationColors['font_light']!.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            _buildRecomButton()
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<HistoryModel> history) {
    List<Widget> body = [
      TextSymptomPage(
        txt: 'Historial de síntomas',
      ),
      SizedBox(height: 10),
      Text('Seleccione un registro para ver más detalles.',
          style: TextStyle(
              color: applicationColors['font_light']!.withOpacity(0.7),
              fontSize: 16)),
      SizedBox(height: 15),
    ];

    history.reversed.toList().forEach((element) => body
      ..add(
        NewRegisterButton(onPressed: () {}, history: element),
      )
      ..add(SizedBox(height: 15)));

    body.add(_buildRecomButton());

    return ListView(
      padding: EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 85),
      children: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hp = Provider.of<HistoryProvider>(context);
    if (this.isLoading) return Container();

    hp.history = this._history;
    if (this._history.length == 0) return _buildEmpty();
    return _buildList(this._history);
  }
}
