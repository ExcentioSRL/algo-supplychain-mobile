import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: QRCodeWidget(),
    );
  }
}

class QRCodeWidget extends StatefulWidget {
  const QRCodeWidget({super.key});

  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {

  final GlobalKey key = GlobalKey(debugLabel: 'qr');
  QRViewController? controller;
  String result = "";


  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData){
      setState(() {
       result = scanData.code!; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplychain qr code reader"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: key,
              onQRViewCreated: _onQRViewCreated,

            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Ownership history of the product: $result",
                style: const TextStyle(
                  fontSize: 18,
                  
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}