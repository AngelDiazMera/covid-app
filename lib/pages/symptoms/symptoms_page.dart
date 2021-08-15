import 'package:covserver/config/theme.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/pages/symptoms/widgets/alert_covid_register.dart';
import 'package:covserver/pages/symptoms/widgets/alert_quarantine.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/widgets/settings_header.dart';
import 'package:covserver/widgets/super_fab.dart';
import 'package:flutter/material.dart';
import 'package:covserver/pages/symptoms/widgets/text_symptom.dart';
import 'package:covserver/pages/symptoms/widgets/symptoms_form.dart';
import 'package:provider/provider.dart';

class SymptomsPage extends StatefulWidget {
  final bool? fullHeight;

  const SymptomsPage({Key? key, this.fullHeight = false}) : super(key: key);

  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  SymptomsUser _symptomsUser = new SymptomsUser();
  bool saveSymptoms = false;

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: SettingsHeader(name: 'Síntomas'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  child: TextSymptomPage(
                    txt: '¿Tienes algún síntoma?',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SymptomForm(
                  fullHeight: widget.fullHeight!,
                  symptomsUser: _symptomsUser,
                  trigger: saveSymptoms,
                  updateDate: (DateTime date) =>
                      setState(() => _symptomsUser.covidDate = date),
                  setTrigger: (bool val) => setState(() => saveSymptoms = val),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: widget.fullHeight! ? 15 : 95, right: 15),
                child: ExpandableFab(
                  onTap: () async {
                    await Preferences.myPrefs
                        .setSymptoms(_symptomsUser.symptoms);
                  },
                  distance: 125.0,
                  children: [
                    ActionButton(
                      title: Text(
                        'Ver recomendaciones',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/recommendations'),
                      icon: Icon(Icons.library_books),
                    ),
                    ActionButton(
                      title: Text(
                        'Ponerme en cuarentena',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertQuarantine(
                            symptomsUser: _symptomsUser,
                          ),
                        );
                      }, //{setState(() => saveSymptoms = true)},
                      icon: Icon(Icons.timelapse_rounded),
                    ),
                    ActionButton(
                      title: Text(
                        'Estoy contagiado',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertCovidRegister(
                            symptomsUser: _symptomsUser,
                            onAccepted: () {
                              hc.healthCondition = 'infected';
                            },
                          ),
                        );
                      },
                      // Navigator.pushNamed(context, '/register_covid'),
                      icon: Icon(Icons.sick),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
