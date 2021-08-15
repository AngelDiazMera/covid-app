import 'package:covserver/config/theme.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/api/requests_symptom.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/utils/handle_notification_risk.dart';
import 'package:covserver/widgets/custom_text_form_field.dart';
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

  Future<void> _makeRequest(HealthCondition hc) async {
    if (loading) return;
    setState(() => loading = true);

    SymptomsUser sympUs = SymptomsUser(remarks: remarks, isCovid: false);
    if (areSympEmpty) {
      sympUs.symptoms = widget.symptomsUser.symptoms;
      sympUs.symptomsDate = widget.symptomsUser.symptomsDate;
    }

    bool updatedSymp =
        await saveSymptoms(newSymptom: sympUs, healthCondition: 'risk');

    if (!updatedSymp) {
      setState(() {
        reqError = true;
        loading = false;
      });
      return;
    }

    Preferences.myPrefs.setSymptoms(widget.symptomsUser.symptoms,
        remarks: remarks,
        symptomsDate: widget.symptomsUser.symptomsDate?.toUtc().toString());

    setState(() {
      finish = true;
      loading = false;
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

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            // While getting prefs
            loading
                ? [
                    Text(
                      'Cargando...',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ]
                // If is infected
                : reqError
                    ? [
                        Text(
                            'Hubo un problema con la actualización. Inténtalo más tarde.')
                      ]
                    : finish
                        ? [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Excelente',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text('El estado se ha actualizado con éxito.',
                                    style: TextStyle(
                                        color: applicationColors['font_light'],
                                        fontSize: 18)),
                              ],
                            )
                          ]
                        : hcState == 'infected'
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
                                  'Usted ya se encuentra contagiado de Covid-19 y no puede registrar el riesgo.',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: applicationColors['font_light']),
                                )
                              ]
                            // If is healthy or in risk
                            : [
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
                                        color: applicationColors['font_light'],
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
                                ),
                              ],
      ),
      actions: reqError || finish || hcState == 'infected'
          ? [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'CANCEL');
                },
                child: Text(
                  "Está bien",
                  style: TextStyle(
                    color: applicationColors['font_light']!.withOpacity(0.75),
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
                  "Cancelar",
                  style: TextStyle(
                    color: applicationColors['font_light']!.withOpacity(0.75),
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await _makeRequest(hc);
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
            ],
    );
  }

  void _remarksOnChange(String value) {
    setState(() => remarks = value);
  }
}
