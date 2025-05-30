import 'package:app_zoologico/src/pages/animalInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logger/logger.dart'; // Asegúrate de tener el paquete logger

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final Logger _logger = Logger(printer: PrettyPrinter());
  final MobileScannerController _scannerController = MobileScannerController();

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código QR'),
        backgroundColor:
            Colors.green, // Mantén la consistencia con el tema de tu app
      ),
      body: MobileScanner(
        controller: _scannerController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            _logger.d('Código de barras/QR encontrado: ${barcode.rawValue}');
            if (barcode.rawValue != null) {
              // Regresa a la pantalla anterior, pasando el dato escaneado
              // Navigator.pop(context, barcode.rawValue);
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => AnimalInfoPage(animalId: barcode.rawValue!),
                ),
              );
              break; // Solo procesa el primer código detectado y sale
            }
          }
        },
      ),
    );
  }
}
