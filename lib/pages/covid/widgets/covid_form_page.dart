import 'package:flutter/material.dart';
import 'package:persistencia_datos/data/symptoms.dart';
import 'package:persistencia_datos/pages/recomendaciones/covid/recomendation_covid_page.dart';
import 'package:persistencia_datos/services/auth/my_symptom.dart';
import 'package:persistencia_datos/widgets/date_picker_form.dart';
import 'package:persistencia_datos/pages/covid/widgets/state_covid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistencia_datos/widgets/floatbutto_widget.dart';
import 'custom_form_covid.dart';
import 'package:persistencia_datos/models/symptoms_user.dart';
import 'package:intl/intl.dart';

class SymptomFormPage extends StatefulWidget {
  @override
  _SymptomFormPageState createState() => _SymptomFormPageState();
}

class _SymptomFormPageState extends State<SymptomFormPage> {
  SymptomsUser _symptomsUser = SymptomsUser();
  String _infection = 'Bajo riesgo';
  Color _color;
  String _txt;
  DateTime covidDate;
  bool covid = false;
  String fechaCovid = '';
  final _controllerCovid = TextEditingController();
  /*Map<String, dynamic> _formData = {
    'isCovid': false,
    'covidDate': '',
  };
*/
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
                                _saveState('Bajo riesgo', value);
                              });
                            }),
                        SizedBox(
                          height: 50,
                        ),
                        DateWidget(
                            controller: _controllerCovid,
                            selectDate: _selectDateCovid), //DateWidget(),
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

  void _signCovid() {
    /*_formData['isCovid'] = _symptomsUser.isCovid;
    _formData['covidDate'] = _symptomsUser.covidDate;
    // _formData['isCovid'] = _symptomsUser.isCovid;
    //_symptomsUser.isCovid = _formData['isCovid'];
    SymptomsUser newSymptom = SymptomsUser(
        isCovid: _symptomsUser.isCovid, covidDate: _symptomsUser.covidDate);
    MySymptom.mine.saveMySymptom(newSymptom);
    print(_formData);
    print(newSymptom.covidDate);
    //User newUser = new User.fromJson(_formData);*/
  }

  Widget buildButton() => ButtonWidget(onClicked: () async {
        _signCovid();
        _pantallaform(context);
      });
  void _pantallaform(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true, //Para el clikc afuera y salir
        builder: (context) {
          return CovidPage();
        });
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
