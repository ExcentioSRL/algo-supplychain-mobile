import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:supplychain_mobileapp/data_visualization.dart';
import 'package:supplychain_mobileapp/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final GlobalKey key = GlobalKey(debugLabel: 'qr');
  QRViewController? controller;
  bool showCamera = true;
  Stock? result;
  List<String>? historyNames;
  List<String>? historyWallets;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("Siamo qua!");
      setState(() {
        result = stockFromJson(scanData.code!);
        historyNames = result?.historyNames;
        historyWallets = result?.historyWallets;
        print("QUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII: $showCamera");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplychain qr code reader"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if(result != null){
                  result = null;
                }else{
                  //IL RISULTATO PRECEDENTE?
                }
              });
            },
            icon: result != null ? const Icon(Icons.qr_code) : const Icon(Icons.abc),
          )
        ],
      ),
      body: result == null ? 
        QRView(
          key: key,
          onQRViewCreated: _onQRViewCreated,
        ) : 
        DataVisualization(historyNames!,historyWallets!)
    );
  }
}