import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:secure_print/secure_print.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Print Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _printers = [];

  @override
  void initState() {
    super.initState();
    _fetchPrinters();
  }

  Future<void> _fetchPrinters() async {
    try {
      final printers = await SecurePrint.getAvailablePrinters();
      setState(() {
        _printers = printers;
      });
    } catch (e) {
      print('Failed to get printers: $e');
    }
  }

  Future<void> _printPdf() async {
    // Simulate PDF data (you should replace this with actual PDF data)
    final pdfData = Uint8List.fromList(List.generate(100, (index) => index));

    // Use the first available printer or show a message if no printers are available
    if (_printers.isNotEmpty) {
      final printerName = _printers[0];
      try {
        await SecurePrint.printPdf(pdfData, printerName);
        print('Print job sent successfully');
      } catch (e) {
        print('Failed to print PDF: $e');
      }
    } else {
      print('No available printers found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Print Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _printPdf,
              child: const Text('Print PDF'),
            ),
            const SizedBox(height: 20),
            const Text('Available Printers:'),
            ..._printers.map((printer) => Text(printer)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPrinters,
        tooltip: 'Fetch Printers',
        child: const Icon(Icons.print),
      ),
    );
  }
}
