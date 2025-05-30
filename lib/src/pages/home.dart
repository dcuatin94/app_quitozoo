import 'package:app_zoologico/src/pages/informativo_page.dart';
import 'package:app_zoologico/src/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:app_zoologico/src/pages/scanner_page.dart';
import 'package:app_zoologico/src/pages/animalInfoPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _lastScannedData;
  Future<void> _scanQRCodeAndShowAnimalInfo() async {
    final scannedData = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => ScannerPage()),
    );
    if (scannedData != null && scannedData.isNotEmpty) {
      setState(() {
        _lastScannedData = scannedData;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnimalInfoPage(animalId: scannedData),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se ha escaneado ningú animal'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Historias de Animales',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    shadows: const [
                      Shadow(
                          color: Colors.green,
                          offset: Offset(1, 1),
                          blurRadius: 1)
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            AnimalCarousel(),
            const SizedBox(
              height: 20,
            ),
            // const CardsRow(),
            InformativoPage(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: _scanQRCodeAndShowAnimalInfo,
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Escanear QR'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (_lastScannedData != null)
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Ultimo QR escaneado: $_lastScannedData',
                    style: TextStyle(fontSize: 16),
                  )),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
