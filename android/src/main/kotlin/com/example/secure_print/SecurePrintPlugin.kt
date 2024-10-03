
package com.example.secure_print

import android.content.Context
import android.print.PrintJob
import android.print.PrintManager
import android.graphics.pdf.PdfDocument
import android.os.Bundle
import android.os.CancellationSignal
import android.print.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.io.FileOutputStream
import java.io.IOException
import android.os.ParcelFileDescriptor

class SecurePrintPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "secure_print")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getAvailablePrinters" -> getAvailablePrinters(result)
            "printPdf" -> {
                val pdfData = call.argument<ByteArray>("pdfData")
                val printerName = call.argument<String>("printerName")
                if (pdfData != null && printerName != null) {
                    printPdf(pdfData, printerName, result)
                } else {
                    result.error("INVALID_ARGUMENT", "pdfData or printerName missing", null)
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun getAvailablePrinters(result: MethodChannel.Result) {
        val printManager = context.getSystemService(Context.PRINT_SERVICE) as PrintManager
        val printJobs: List<PrintJob> = printManager.printJobs

        // Extracting the IDs or names of the printers
        val printerNames = printJobs.map { it.info ?: "Unknown Printer" }
        result.success(printerNames)
    }

    private fun printPdf(pdfData: ByteArray, printerName: String, result: Result) {
        val printManager = context.getSystemService(Context.PRINT_SERVICE) as PrintManager
        val printDocumentAdapter = object : PrintDocumentAdapter() {
            override fun onLayout(
                oldAttributes: PrintAttributes?,
                newAttributes: PrintAttributes?,
                cancellationSignal: CancellationSignal?,
                callback: PrintDocumentAdapter.LayoutResultCallback?,
                extras: Bundle?
            ) {
                callback?.onLayoutFinished(
                    PrintDocumentInfo.Builder("document.pdf")
                        .setContentType(PrintDocumentInfo.CONTENT_TYPE_DOCUMENT)
                        .build(),
                    true
                )
            }

            override fun onWrite(
                pages: Array<out PageRange>?,
                destination: ParcelFileDescriptor?,
                cancellationSignal: CancellationSignal?,
                callback: PrintDocumentAdapter.WriteResultCallback?
            ) {
                try {
                    FileOutputStream(destination?.fileDescriptor).use { output ->
                        output.write(pdfData)
                        callback?.onWriteFinished(arrayOf(PageRange.ALL_PAGES))
                    }
                } catch (e: IOException) {
                    callback?.onWriteFailed(e.message)
                }
            }
        }

        printManager.print(printerName, printDocumentAdapter, PrintAttributes.Builder().build())
        result.success(null)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
