// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({super.key});

  @override
  _PageNotFound createState() => _PageNotFound();
}

class _PageNotFound extends State<PageNotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página no encontrada'),
      ),
      body: const Center(
        child: Text('404 Página no encontrada'),
      ),
    );
  }
}
