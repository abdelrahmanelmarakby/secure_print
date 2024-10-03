import Flutter
import UIKit
import CoreGraphics

public class SwiftSecurePrintPlugin: NSObject, FlutterPlugin {
    
    private var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftSecurePrintPlugin()
        instance.channel = FlutterMethodChannel(name: "secure_print", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "printPdf":
            guard
                let arguments = call.arguments as? [String: Any],
                let pdfData = arguments["pdfData"] as? FlutterStandardTypedData,
                let printerName = arguments["printerName"] as? String
            else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "PDF data or printer name is missing", details: nil))
                return
            }
            printPdf(pdfData: pdfData.data, printerName: printerName)
            result(nil)
        case "getAvailablePrinters":
            let printers = getAvailablePrinters()
            result(printers)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func printPdf(pdfData: Data, printerName: String) {
        // Create a print formatter from the PDF data
        let printFormatter = PDFPrintFormatter(data: pdfData)
        
        // Use a print interaction controller to present the print dialog
        let printController = UIPrintInteractionController.shared
        printController.printingItem = printFormatter
        
        // Configure the print job
        printController.printInfo = UIPrintInfo.printInfo()
        printController.printInfo.jobName = "PDF Print Job"
        
        // Display the print dialog
        printController.present(animated: true, completionHandler: nil)
    }
    
    private func getAvailablePrinters() -> [String] {
        // For iOS, fetching available printers is not straightforward.
        // This method will return an empty list as iOS does not provide direct access to printer names.
        return []
    }
}

// Helper class to create a print formatter from PDF data
private class PDFPrintFormatter: NSObject, UIPrintFormatter {
    private let data: Data
    
    init(data: Data) {
        self.data = data
        super.init()
    }
    
    override func draw(in rect: CGRect, with context: UIGraphicsContext) {
        if let pdfDocument = CGPDFDocument(data as CFData) {
            let pageCount = pdfDocument.numberOfPages
            for pageIndex in 1...pageCount {
                if let page = pdfDocument.page(at: pageIndex) {
                    context.drawPDFPage(page)
                }
            }
        }
    }
}
