import 'dart:typed_data';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'secure_print_method_channel.dart';

abstract class SecurePrintPlatform extends PlatformInterface {
  /// Constructs a SecurePrintPlatform.
  SecurePrintPlatform() : super(token: _token);

  static final Object _token = Object();

  static SecurePrintPlatform _instance = MethodChannelSecurePrint();

  /// The default instance of [SecurePrintPlatform] to use.
  ///
  /// Defaults to [MethodChannelSecurePrint].
  static SecurePrintPlatform get instance => _instance;

  /// Platform-specific implementations should set this to their implementation.
  static set instance(SecurePrintPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> printPdf(Uint8List pdfData, String printerName);

  Future<List<String>> getAvailablePrinters();
}
