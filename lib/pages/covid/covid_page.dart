import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/models/symptoms_user.dart';
import 'package:persistencia_datos/pages/covid/widgets/state_covid.dart';
import 'package:persistencia_datos/services/api/requests_symptom.dart';
import 'package:persistencia_datos/services/auth/my_symptom.dart';
import 'package:persistencia_datos/widgets/date_picker_form.dart';
import 'package:persistencia_datos/widgets/floatbutto_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/custom_form_covid.dart';
import 'package:intl/intl.dart';

class CovidPage extends StatefulWidget {
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  SymptomsUser _symptomsUser = SymptomsUser();
  String _infection = 'Bajo riesgo';
  Color _color;
  String _txt;
  String fechaCovid = '';
  bool loading = false;
  bool connectionFailed = false;
  final _controllerCovid = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferencesState();
  }

  _loadPreferencesState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _infection = (prefs.getString('Bajo riesgo') ?? 'En riesgo');
    });
  }

  _saveState(String key, dynamic val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(key, val);
    });
  }

  Future<bool> _makeInfected() async {
    setState(() => loading = false);
    bool areSymSaved = await MySymptom.mine.saveCovid(_symptomsUser);
    if (!areSymSaved) {
      setState(() {
        loading = false;
        connectionFailed = true;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;
    if (_infection == 'Bajo riesgo') {
      _txt = _infection;
      _color = Colors.greenAccent;
    } else {
      _txt = 'En riesgo';
      _color = Colors.redAccent;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Covid'),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? applicationColors['medium_purple']
            : applicationColors['medium_purple'],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 30.0),
          shrinkWrap: true,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: StateCovidPage(
                            estado: _txt,
                            estadoColor: _color,
                          ),
                        ),
                        CustomFormSymptom(
                            horizontalMargin: formMargin,
                            hasInfectionSelection: true,
                            infection: _infection,
                            onInfectionChange: (String value) {
                              setState(() {
                                _infection = value;
                                if (value == 'Bajo riesgo') {
                                  _symptomsUser.isCovid = false;
                                } else {
                                  _symptomsUser.isCovid = true;
                                }
                                _saveState('Bajo riesgo', value);
                              });
                            }),
                        SizedBox(
                          height: 50,
                        ),
                        DateWidget(
                            controller: _controllerCovid,
                            selectDate: _selectDateCovid),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: buildButton(),
                        ),
                      ],
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton() => ButtonWidget(onClicked: () async {
        _saveCovid();
        _makeInfected();
        Navigator.pushNamed(context, '/');
      });
  void _saveCovid() {
    SymptomsUser newCovid = SymptomsUser(
        isCovid: _symptomsUser.isCovid, covidDate: _symptomsUser.covidDate);
    MySymptom.mine.saveCovid(newCovid);
  }

  void _selectDateCovid(BuildContext context) async {
    _symptomsUser.covidDate = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2021),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                  primary: const Color.fromRGBO(72, 75, 235, 1),
                  onPrimary: Colors.white,
                  brightness: Brightness.light),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        });

    if (_symptomsUser.covidDate != null) {
      String formattedDate =
          DateFormat('dd-MM-yyy').format(_symptomsUser.covidDate);
      setState(() {
        fechaCovid = formattedDate;
        _controllerCovid.text = fechaCovid;
      });
    }
  }
}
