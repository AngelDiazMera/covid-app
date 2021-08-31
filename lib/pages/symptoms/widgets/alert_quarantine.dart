import 'package:covserver/config/theme.dart';
import 'package:covserver/models/history_model.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/api/requests_symptom.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/services/providers/history_provider.dart';
import 'package:covserver/utils/handle_history_save.dart';
import 'package:covserver/utils/handle_notification_risk.dart';
import 'package:covserver/widgets/custom_text_form_field.dart';
import 'package:covserver/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertQuarantine extends StatefulWidget {
  final SymptomsUser symptomsUser;

  AlertQuarantine({Key? key, required this.symptomsUser}) : super(key: key);

  @override
  _AlertQuarantineState createState() => _AlertQuarantineState();
}

class _AlertQuarantineState extends State<AlertQuarantine> {
  String hcState = '';
  bool loading = true;
  bool reqError = false;
  bool finish = false;

  String remarks = '';
  bool areSympEmpty = false;

  void _loadPrefs() async {
    String hc = await Preferences.myPrefs.getHealthCondition();
    setState(() {
      loading = false;
      hcState = hc;
    });
  }

  Future<void> _makeRequest(HealthCondition hc, HistoryProvider hp) async {
    if (loading) return;
    setState(() => loading = true);
    // verify if the user has exceeded 3 attempts per day limit
    var isAvailable = await Preferences.myPrefs.canMakeHistory();
    if (!isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sólo puede hacer 3 registros por día.')));
      setState(() {
        reqError = true;
        loading = false;
      });
      return;
    }

    SymptomsUser sympUs = SymptomsUser(remarks: remarks, isCovid: false);
    if (areSympEmpty) {
      sympUs.symptoms = widget.symptomsUser.symptoms;
      sympUs.symptomsDate = widget.symptomsUser.symptomsDate;
    }

    //await saveSymptoms(newSymptom: sympUs, healthCondition: 'risk');

    // Call to endpoint. If call is successful, saves on the database
    // and returns an HistoryModel instance. Else, return null;
    HistoryModel? history =
        await handleHistorySave(widget.symptomsUser, 'risk');
    if (history == null) {
      setState(() {
        reqError = true;
        loading = false;
      });
      return;
    }
    // Global state update
    hp.addRegister(history);

    // Preferences.myPrefs.setSymptoms(widget.symptomsUser.symptoms,
    //     remarks: remarks,
    //     symptomsDate: widget.symptomsUser.symptomsDate?.toUtc().toString());

    // End of the call
    setState(() {
      finish = true;
      loading = false;
      reqError = false;
      hcState = 'risk';
    });
  }

  @override
  void initState() {
    _loadPrefs();
    super.initState();
    setState(() => areSympEmpty = widget.symptomsUser.symptoms.length == 0);
  }

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);
    final hp = Provider.of<HistoryProvider>(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            // While getting prefs
            loading
                ? [Loader()]
                : finish
                    ? [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Excelente',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text('El estado se ha actualizado con éxito.',
                                style: TextStyle(
                                    color: applicationColors['font_light'],
                                    fontSize: 18)),
                          ],
                        )
                      ]
                    : reqError
                        ? [
                            Text(
                                'Hubo un problema con la actualización. Inténtalo más tarde.')
                          ]
                        : hcState == 'risk'
                            ? [
                                Text(
                                  'Lo sentimos',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Usted ya se encuentra en riesgo.',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: applicationColors['font_light']),
                                )
                              ]
                            : hcState == 'healthy'
                                ? [
                                    Text(
                                      'Información',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            'Al marcar esta opción, la aplicación te pondrá en ',
                                        style: TextStyle(
                                            color:
                                                applicationColors['font_light'],
                                            fontSize: 19),
                                        children: [
                                          TextSpan(
                                              text: 'estado de riesgo ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                            text:
                                                ' durante las siguientes dos semanas.',
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomTextFormField(
                                      label: 'Comentarios',
                                      keyboardType: TextInputType.text,
                                      onChanged: _remarksOnChange,
                                      initialValue: remarks,
                                      icon: Icons.comment,
                                    )
                                  ]
                                : [
                                    Text(
                                      'Lo sentimos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Usted ya se encuentra contagiado de Covid-19 y no puede registrar el riesgo.',
                                      style: TextStyle(
                                          fontSize: 19,
                                          color:
                                              applicationColors['font_light']),
                                    )
                                  ],
      ),
      actions: loading
          ? []
          : reqError || finish
              ? [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    },
                    child: Text(
                      "Está bien",
                      style: TextStyle(
                        color:
                            applicationColors['font_light']!.withOpacity(0.75),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]
              : hcState == 'healthy'
                  ? [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'CANCEL');
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: applicationColors['font_light']!
                                .withOpacity(0.75),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await _makeRequest(hc, hp);
                          handleNotificationRisk(context, hc);
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
                  : [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'CANCEL');
                        },
                        child: Text(
                          "Está bien",
                          style: TextStyle(
                            color: applicationColors['font_light']!
                                .withOpacity(0.75),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
    );
  }

  void _remarksOnChange(String value) {
    setState(() => remarks = value);
  }
}
