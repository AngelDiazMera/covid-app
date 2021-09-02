import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/pages/symptoms/widgets/alert_covid_register.dart';
import 'package:covserver/pages/symptoms/widgets/alert_periodic_record.dart';
import 'package:covserver/pages/symptoms/widgets/alert_quarantine.dart';
import 'package:covserver/pages/symptoms/widgets/alert_restablish.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/widgets/loader.dart';
import 'package:covserver/widgets/settings_header.dart';
import 'package:covserver/widgets/super_fab.dart';
import 'package:flutter/material.dart';
import 'package:covserver/widgets/text_symptom.dart';
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
  bool loading = true;

  void _init() async {
    List<String> temp = await Preferences.myPrefs.getSymptoms();
    String? symptomsDate = await Preferences.myPrefs.getSymptomsDate();
    setState(() {
      _symptomsUser.symptomsDate = symptomsDate != null && symptomsDate != ''
          ? DateTime.parse(symptomsDate)
          : null;
      _symptomsUser.symptoms = temp;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    if (loading) return Scaffold();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: SettingsHeader(name: 'Síntomas', needGoBack: true),
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
                      danger: true,
                      title: Text(
                        'Restablecer estado de salud',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertRestablish(),
                        );
                      }, //{setState(() => saveSymptoms = true)},
                      icon: Icon(Icons.restart_alt_rounded),
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
                    ActionButton(
                      title: Text(
                        'Me siento en riesgo',
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
                        'Registro periódico',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertPeriodicRecord(
                            symptomsUser: _symptomsUser,
                          ),
                        );
                      },
                      icon: Icon(Icons.save_rounded),
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
