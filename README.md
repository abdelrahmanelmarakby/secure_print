# secure_print

`secure_print` is a Flutter plugin that enables secure in-memory PDF printing. This plugin ensures that PDFs are printed directly from memory without allowing the option to save or share the file, making it ideal for applications requiring stringent document security.

## Features

- **In-Memory PDF Handling**: Directly print PDFs from memory, avoiding saving to disk.
- **Secure Printing**: Prevents users from saving or sharing the PDF, ensuring that it can only be printed.
- **Cross-Platform**: Supports both Android and iOS platforms.

## Getting Started

To use `secure_print` in your Flutter project, follow these steps:

### 1. Add Dependency

Add the `secure_print` dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  secure_print: ^0.0.1
```

### 2. Import the Package

Import the secure_print package in your Dart code:

```dart
import 'package:secure_print/secure_print.dart';
```

### 3. Usage

Here is an example of how to use the secure_print plugin to print a PDF from in-memory data:

```dart
import 'package:flutter/material.dart';
import 'package:secure_print/secure_print.dart';

class PrintExample extends StatelessWidget {
  final Uint8List pdfData; // Your PDF data as a Uint8List

  PrintExample({required this.pdfData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure Print Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await SecurePrint.printPdf(pdfData);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('PDF sent to printer')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to print PDF: $e')),
              );
            }
          },
          child: Text('Print PDF'),
        ),
      ),
    );
  }
}
```

### 4. Platform-Specific Configuration

Ensure your project is configured to use the secure_print plugin. Follow platform-specific setup instructions if needed.

- Android: Ensure your Android project includes the necessary permissions and configurations for printing.
  
- iOS: Make sure your iOS project is configured to handle the printing functionalities provided by the plugin.

### 5. Contribution

Contributions are welcome! If you have suggestions, improvements, or bug fixes, please create an issue or submit a pull request.

Fork the repository.
Create a feature branch (git checkout -b feature-branch).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Create a new Pull Request.

### Contact

For further assistance or inquiries, please contact <team@AbwabDigital.com>.
