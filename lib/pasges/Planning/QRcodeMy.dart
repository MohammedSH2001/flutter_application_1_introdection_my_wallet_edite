import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(home: QRScannerScreen()));
}

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      print("Camera permission granted");
    } else {
      Get.snackbar("Error", "Camera permission denied");
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('QR Code Scanner'),
    ),
    body: FutureBuilder(
      future: _requestCameraPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    ),
  );
}


  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      Get.snackbar("QR Code Scanned", scanData.code ?? "No data found");
      controller.pauseCamera(); // لإيقاف الكاميرا بعد المسح
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
