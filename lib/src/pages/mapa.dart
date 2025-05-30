// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<MapaScreen> {
  bool _isExpanded = false;
  bool _isExpanded2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text(
          "Mapa del Lugar",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isExpanded ? MediaQuery.of(context).size.width : 300,
                height: _isExpanded ? MediaQuery.of(context).size.height : 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Image.asset(
                    'assets/galeria/mapa.png',
                    fit: BoxFit.contain,
                    height: double.infinity,
                  ),
                )),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded2 = !_isExpanded2;
              });
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isExpanded2 ? MediaQuery.of(context).size.width : 300,
                height: _isExpanded2 ? MediaQuery.of(context).size.height : 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Image.asset(
                    'assets/galeria/mapa2.png',
                    fit: BoxFit.contain,
                    height: double.infinity,
                  ),
                )),
          ),
        )
      ],
    ));
  }
}
