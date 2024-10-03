// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:secure_print/secure_print_method_channel.dart';
// import 'package:mockito/mockito.dart';

// class MockMethodChannel extends Mock implements MethodChannel {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   group('MethodChannelSecurePrint', () {
//     const MethodChannel channel = MethodChannel('secure_print');
//     final MockMethodChannel mockChannel = MockMethodChannel();

//     setUp(() {
//       // Replace the method channel with a mock
//       channel.setMockMethodCallHandler((MethodCall methodCall) async {
//         switch (methodCall.method) {
//           case 'printPdf':
//             return '';
//           case 'getAvailablePrinters':
//             return ['Printer1', 'Printer2'];
//           default:
//             throw PlatformException(
//               code: 'Unimplemented',
//               details:
//                   'secure_print for method ${methodCall.method} is not implemented',
//             );
//         }
//       });
//     });

//     test('printPdf calls the correct method channel', () async {
//       final pdfData = Uint8List.fromList([1, 2, 3, 4]);
//       const printerName = 'Printer1';

//       await MethodChannelSecurePrint().printPdf(pdfData, printerName);

//       verify(mockChannel.invokeMethod('printPdf', {
//         'pdfData': pdfData,
//         'printerName': printerName,
//       })).called(1);
//     });

//     test('getAvailablePrinters calls the correct method channel', () async {
//       final printers = await MethodChannelSecurePrint().getAvailablePrinters();

//       expect(printers, ['Printer1', 'Printer2']);
//       verify(mockChannel.invokeMethod('getAvailablePrinters')).called(1);
//     });
//   });
// }
