import 'package:covserver/config/theme.dart';
import 'package:covserver/pages/qr_scanner/widgets/alert_code_fount.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ManualView extends StatefulWidget {
  @override
  _ManualViewState createState() => _ManualViewState();
}

class _ManualViewState extends State<ManualView> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    double separation = (MediaQuery.of(context).size.height - 475) / 6;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.5 * separation),
              Container(
                constraints: BoxConstraints(maxHeight: 200, minHeight: 100),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/draw_qr.png'))),
              ),
              SizedBox(height: separation),
              Text(
                'Código manual',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              SizedBox(height: 15),
              Text(
                '¿No pudiste escanear el QR? ingresa el código manualmente',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: separation),
              CustomTextFormField(
                label: 'Código',
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  setState(() => code = value);
                },
                backgroundColor:
                    applicationColors['input_light']!.withOpacity(0.85),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () async {
                  RegExp codeRegEx = RegExp(r'[m,v]{1}-\w+-\d{4}');
                  bool isValid = codeRegEx.hasMatch(code.toLowerCase());

                  if (!isValid) {
                    final snackBar =
                        SnackBar(content: Text('El código no es válido.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }

                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertCodeFound(
                      code: code,
                    ),
                  );
                },
                child: Text(
                  'Registrarme',
                  style: TextStyle(fontSize: 14),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  primary: applicationColors['input_light'],
                  backgroundColor: applicationColors['dark_purple']!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
