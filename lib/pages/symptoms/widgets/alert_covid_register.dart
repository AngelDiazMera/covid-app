import 'package:covserver/config/theme.dart';
import 'package:covserver/models/history_model.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/api/requests_symptom.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/services/providers/history_provider.dart';
import 'package:covserver/utils/handle_history_save.dart';
import 'package:covserver/widgets/custom_text_form_field.dart';
import 'package:covserver/widgets/date_picker_form.dart';
import 'package:covserver/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertCovidRegister extends StatefulWidget {
  final void Function() onAccepted;
  final SymptomsUser symptomsUser;

  const AlertCovidRegister(
      {Key? key, required this.onAccepted, required this.symptomsUser})
      : super(key: key);

  @override
  _AlertCovidRegisterState createState() => _AlertCovidRegisterState();
}

class _AlertCovidRegisterState extends State<AlertCovidRegister> {
  bool loading = false;
  bool reqError = false;
  bool areSympEmpty = false;
  bool finish = false;

  bool isAnonymReq = false;

  DateTime? covidDate;
  String remarks = '';
  final _controllerCovid = TextEditingController();

  Future<void> _makeRequest(HealthCondition hc, HistoryProvider hp) async {
    if (loading) return;
    setState(() => loading = true);

    SymptomsUser sympUs =
        SymptomsUser(covidDate: covidDate, remarks: remarks, isCovid: true);
    if (areSympEmpty) {
      sympUs.symptoms = widget.symptomsUser.symptoms;
      sympUs.symptomsDate = widget.symptomsUser.symptomsDate;
    }

    ////////////////////////////
    HistoryModel? history =
        await handleHistorySave(widget.symptomsUser, 'infected');
    if (history == null) return;
    hp.addRegister(history);
    ////////////////////////////

    bool updatedSymp = true;
    /*await saveSymptoms(newSymptom: sympUs, healthCondition: 'infected');

    if (!updatedSymp) {
      setState(() {
        reqError = true;
        loading = false;
      });
      return;
    }*/

    await notifyInfected(
        anonym: false,
        symptomsDate: covidDate!,
        onError: (String error) => print(error));

    Preferences.myPrefs.setCovid(true, covidDate!.toUtc().toString());
    Preferences.myPrefs.setNeedHCUpdate(false);

    hc.healthCondition = 'infected';
    setState(() {
      finish = true;
      loading = false;
    });
  }

  Future<void> _cancelRequest(HealthCondition hc) async {
    if (loading) return;
    setState(() => loading = true);

    bool updatedSymp = await deleteSymptoms();

    if (!updatedSymp) {
      setState(() {
        reqError = true;
        loading = false;
      });
      return;
    }

    Preferences.myPrefs.deleteCovid();
    Preferences.myPrefs.setNeedHCUpdate(false);

    hc.healthCondition = 'healthy';
    setState(() {
      finish = true;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() => areSympEmpty = widget.symptomsUser.symptoms.length == 0);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.symptomsUser);
    final hc = Provider.of<HealthCondition>(context);
    final hp = Provider.of<HistoryProvider>(context);

    // TODO: VALIDAR SI YA ESTÁ INFECTADO

    return AlertDialog(
      content: loading // If it's loading
          ? Loader()
          : finish
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Excelente',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                        'Se notificará a los usuarios que pudieron haber tenido contacto con usted.',
                        style: TextStyle(
                            color: applicationColors['font_light'],
                            fontSize: 18)),
                  ],
                )
              : hc.healthCondition == 'Contagiado'
                  ? Text(
                      'Usted ya se encuentra contagiado por Covid 19, ¿Desea reiniciar su estado?',
                      style: TextStyle(
                          color: applicationColors['font_light'], fontSize: 18))
                  : reqError
                      ? Text(
                          'Hubo un problema con la actualización. Inténtalo más tarde.')
                      : areSympEmpty
                          ? Text(
                              'No ha seleccionado síntomas, ¿Es usted asintomático?')
                          : Wrap(
                              // If the user has been found and assigned to a group
                              children: [
                                Text(
                                  'Antes de continuar...',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 25),
                                Text(
                                    'Se notificará a los usuarios que pudieron haber tenido contacto con usted.',
                                    style: TextStyle(
                                        color: applicationColors['font_light'],
                                        fontSize: 18)),
                                SizedBox(height: 15),
                                DateWidget(
                                    helper:
                                        'Seleccione la fecha en la que fue diagnosticado',
                                    label: 'Fecha de diagnóstico',
                                    controller: _controllerCovid,
                                    selectDate: _selectDateCovid),
                                CustomTextFormField(
                                  label: 'Comentarios',
                                  keyboardType: TextInputType.text,
                                  onChanged: _remarksOnChange,
                                  initialValue: remarks,
                                  icon: Icons.comment,
                                ),
                                SizedBox(height: 10),
                                CheckboxListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.all(0),
                                  checkColor:
                                      applicationColors['background_light_2'],
                                  activeColor:
                                      applicationColors['medium_purple'],
                                  value: isAnonymReq,
                                  onChanged: (bool? val) => setState(
                                      () => isAnonymReq = !isAnonymReq),
                                  title: Text(
                                    'Notificar de forma anónima',
                                    style: TextStyle(
                                        color: applicationColors['font_light']!
                                            .withOpacity(0.7),
                                        fontSize: 16),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                )
                              ],
                            ),
      actions: !loading
          ? areSympEmpty && hc.healthCondition != 'Contagiado'
              ? [
                  TextButton(
                    onPressed: () {
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
                    onPressed: () => setState(() => areSympEmpty = false),
                    child: Text(
                      "Sí, lo soy",
                      style: TextStyle(
                        color: applicationColors['medium_purple'],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]
              : finish && hc.healthCondition == 'Contagiado'
                  ? [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/'));
                        },
                        child: Text(
                          "Aceptar",
                          style: TextStyle(
                            color: applicationColors['medium_purple'],
                            fontSize: 16,
                          ),
                        ),
                      )
                    ]
                  : hc.healthCondition == 'Contagiado'
                      ? [
                          TextButton(
                            onPressed: () async {
                              await _cancelRequest(hc);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Aceptar",
                              style: TextStyle(
                                color: applicationColors['medium_purple'],
                                fontSize: 16,
                              ),
                            ),
                          )
                        ]
                      : [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                color: applicationColors['medium_purple'],
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (covidDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Debe seleccionar la fecha en la que fue diagnosticado.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                return;
                              }
                              await _makeRequest(hc, hp);
                              // widget.onAccepted();
                              // Navigator.pop(context);
                            },
                            child: Text(
                              "Aceptar",
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

  void _selectDateCovid(BuildContext context) async {
    const dateParser = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    DateTime today = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today.add(Duration(days: -120)),
      lastDate: today,
      locale: Locale('es', 'ES'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
                onPrimary: Colors.white, brightness: Brightness.light),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        String formatDate =
            '${picked.day} de ${dateParser[picked.month - 1]} del ${picked.year}';
        covidDate = picked;
        _controllerCovid.text = formatDate;
      });
    }
  }

  void _remarksOnChange(String value) {
    setState(() => remarks = value);
  }
}
