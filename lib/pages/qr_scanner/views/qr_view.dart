import 'dart:io';

import 'package:covserver/config/theme.dart';
import 'package:covserver/pages/qr_scanner/widgets/alert_code_fount.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanView extends StatefulWidget {
  @override
  _QRScanViewState createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final qrKey = GlobalKey(debugLabel: 'QR'); // Key

  QRViewController? controller;

  String code = ''; // Code found
  bool loading = false; // If it's doing the request

  @override
  void dispose() {
    // Stops the camera and disposes the barcode stream
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    // To prevent camera to stop in Android and iOS
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
      setState(() => code = '');
    }
    controller!.resumeCamera();
  }

  Future<bool> _restartQRSearch() async {
    setState(() {
      code = '';
      loading = false;
    });
    await controller!.resumeCamera();
    return true;
  }

  /// Show AlertCodeFound to handle the api request.
  /// Also, handles the camera due to the recursive calls.
  void _makeRequest() async {
    if (loading) return;
    setState(() => loading = true);

    await controller!.pauseCamera();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
          child: AlertCodeFound(
            code: code,
            onAccepted: _restartQRSearch,
          ),
          onWillPop: _restartQRSearch),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If everything's ready to make a request
    if (code != '') _makeRequest();

    return SafeArea(
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            Positioned(bottom: 10, child: buildResult()),
            Positioned(top: 10, child: buildControlButtons())
          ],
        ),
      ),
    );
  }

  // Build the Qr Camera view
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        // Shape design
        overlay: QrScannerOverlayShape(
          borderRadius: 15,
          borderLength: 20,
          borderWidth: 10,
          borderColor: applicationColors['input_light']!,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ), // Scanning area
      );

  // To control the scanned area
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    // Listen qr scan
    controller.scannedDataStream.listen((barcode) {
      RegExp codeRegEx = RegExp(r'[M,V]{1}-\w+-\d{4}');

      // Find the code into the decoded qr
      var matches = codeRegEx.allMatches(barcode.code);

      if (matches.length > 0) {
        final matchedCode = matches.elementAt(0).group(0);
        setState(() => code = matchedCode ?? '');
      }
    });
  }

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: applicationColors['background_dark_1']!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          code != '' ? 'Código $code encontrado' : 'Escaneé un código',
          maxLines: 3,
          style: TextStyle(
              color: applicationColors['input_light']!.withOpacity(0.5)),
        ),
      );

  // Flash and toggle camera buttons
  Widget buildControlButtons() => Container(
        width: MediaQuery.of(context).size.width * 0.4,
        constraints: BoxConstraints(maxWidth: 150),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: applicationColors['background_dark_1']!.withOpacity(0.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              // Handle the actual status of the flash
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null)
                    return Icon(
                        snapshot.data!
                            ? Icons.flash_on_rounded
                            : Icons.flash_off_rounded,
                        color:
                            applicationColors['input_light']!.withOpacity(0.5));
                  return Container();
                },
              ),
            ),
            IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              // Handle camera existance
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null)
                    return Icon(Icons.switch_camera_rounded,
                        color:
                            applicationColors['input_light']!.withOpacity(0.5));
                  return Container();
                },
              ),
            ),
          ],
        ),
      );
}
