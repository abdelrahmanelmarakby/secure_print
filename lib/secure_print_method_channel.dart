import 'package:flutter/services.dart';
import 'secure_print_platform_interface.dart';

/// An implementation of [SecurePrintPlatform] that uses method channels.
class MethodChannelSecurePrint extends SecurePrintPlatform {
  static const MethodChannel _channel = MethodChannel('secure_print');

  @override
  Future<void> printPdf(Uint8List pdfData, String printerName) async {
    try {
      await _channel.invokeMethod('printPdf', {
        'pdfData': pdfData,
        'printerName': printerName,
      });
    } on PlatformException catch (e) {
      throw Exception('Failed to print PDF: ${e.message}');
    }
  }

  @override
  Future<List<String>> getAvailablePrinters() async {
    try {
      final List<dynamic> printerList =
          await _channel.invokeMethod('getAvailablePrinters');
      return printerList.cast<String>();
    } on PlatformException catch (e) {
      throw Exception('Failed to get available printers: ${e.message}');
    }
  }
}
