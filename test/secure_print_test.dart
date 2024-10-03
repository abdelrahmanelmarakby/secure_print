// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:secure_print/secure_print.dart'; // Adjust import if needed
// import 'package:secure_print/secure_print_platform_interface.dart';
// // Adjust this import to your actual example file path

// /// Create a mock class for SecurePrintPlatform
// class MockSecurePrintPlatform extends Mock implements SecurePrintPlatform {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   group('MyApp', () {
//     testWidgets('fetches and displays available printers',
//         (WidgetTester tester) async {
//       // Mock the SecurePrint methods
//       final mockPlatform = MockSecurePrintPlatform();
//       SecurePrintPlatform.instance = mockPlatform;

//       // Mock data
//       final List<String> mockPrinters = ['Printer1', 'Printer2'];

//       // Stub the methods
//       when(mockPlatform.getAvailablePrinters())
//           .thenAnswer((_) async => mockPrinters);

//       await tester.pumpWidget(MyApp());

//       // Verify the fetch printers button
//       await tester.tap(find.byType(FloatingActionButton));
//       await tester.pump();

//       // Verify that the printers are displayed
//       expect(find.text('Available Printers:'), findsOneWidget);
//       for (var printer in mockPrinters) {
//         expect(find.text(printer), findsOneWidget);
//       }
//     });

//     testWidgets('handles print PDF button press', (WidgetTester tester) async {
//       // Mock the SecurePrint methods
//       final mockPlatform = MockSecurePrintPlatform();
//       SecurePrintPlatform.instance = mockPlatform;

//       // Mock data
//       final List<String> mockPrinters = ['Printer1'];
//       final pdfData = Uint8List.fromList([1, 2, 3, 4]);
//       const printerName = 'Printer1';

//       // Stub the methods
//       when(mockPlatform.getAvailablePrinters())
//           .thenAnswer((_) async => mockPrinters);
//       when(mockPlatform.printPdf(pdfData, any)).thenAnswer((_) async {
//         return;
//       });

//       await tester.pumpWidget(MyApp());

//       // Fetch printers
//       await tester.tap(find.byType(FloatingActionButton));
//       await tester.pump();

//       // Press the print button
//       await tester.tap(find.byType(ElevatedButton));
//       await tester.pump();

//       // Verify printPdf method was called with correct parameters
//       verify(mockPlatform.printPdf(any, any)).called(1);
//     });
//   });
// }
