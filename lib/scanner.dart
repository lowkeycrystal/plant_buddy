import 'dart:io';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const PlantScanner());
}

class PlantScanner extends StatelessWidget {
  const PlantScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ScanQRPage(),
    );
  }
}

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({Key? key}) : super(key: key);

  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State {
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Barcode? result;
//in order to get hot reload to work.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: onQRViewCreated,
                  overlay: QrScannerOverlayShape(
//customizing scan area
                    borderWidth: 10,
                    // ignore: prefer_const_constructors
                    borderColor: Color.fromARGB(255, 33, 243, 82),
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.flip_camera_ios,
                              color: Color.fromARGB(255, 33, 243, 82),
                            ),
                            onPressed: () async {
                              await controller.flipCamera();
                            }),
                        IconButton(
                            icon: const Icon(
                              Icons.flash_on,
                              color: Color.fromARGB(255, 33, 243, 82),
                            ),
                            onPressed: () async {
                              await controller.toggleFlash();
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(3.0),
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: result != null
                    ? Column(
                        children: [
                          Text('Code: ${result!.code}'),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text('Format: ${result!.format}'),
                        ],
                      )
                    : const Text('Scan'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController p1) {
//called when View gets created.
    // ignore: unnecessary_this
    this.controller = p1;

    controller.scannedDataStream.listen((scanevent) {
      setState(() {
//UI gets created with new QR code.
        result = scanevent;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
