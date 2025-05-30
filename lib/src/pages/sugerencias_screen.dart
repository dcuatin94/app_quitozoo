import 'package:app_zoologico/src/helpers/sql_helper.dart';
import 'package:app_zoologico/src/model/sugerencia_model.dart';
import 'package:flutter/material.dart';

class SugerenciasScreen extends StatefulWidget {
  const SugerenciasScreen({super.key});

  @override
  SugerenciasScreenState createState() => SugerenciasScreenState();
}

class SugerenciasScreenState extends State<SugerenciasScreen> {
  int _rating = 0; // Calificación seleccionada
  final TextEditingController _sugerenciaController = TextEditingController();
  List<Sugerencia> _sugerencias =
      []; // Lista para almacenar sugerencias cargadas

  // Método para cargar las sugerencias desde SQLite
  Future<void> _loadSugerencias() async {
    final data = await SQLHelper.getAllSugerencias();
    setState(() {
      _sugerencias = data;
    });
  }

  // Método para agregar una nueva sugerencia
  Future<void> _addSugerencia() async {
    if (_sugerenciaController.text.isNotEmpty) {
      final nuevaSugerencia = Sugerencia(
        rating: _rating,
        texto: _sugerenciaController.text,
      );

      await SQLHelper.insertSugerencia(nuevaSugerencia);

      if (!mounted) return; // Verifica si el widget sigue montado

// Limpia el controlador de texto y reinicia el valor de la calificación
      _sugerenciaController.clear();
      _rating = 0; // Reinicia la calificación

      await _loadSugerencias(); // Cargar sugerencias

// Verifica nuevamente si el widget sigue montado antes de mostrar el SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comentario guardado con éxito!')),
        );
      }
    } else {
      if (!mounted) return; // Verifica si el widget sigue montado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, escribe una sugerencia.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSugerencias(); // Cargar sugerencias al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comentarios y Sugerencias"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        // Envuelve todo el contenido en un scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Califica tu experiencia",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      size: 32,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1; // Actualizar calificación
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _sugerenciaController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Escribe tu sugerencia aquí",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addSugerencia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("Enviar",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              SizedBox(
                // Limita la altura de la ListView
                height:
                    200, // Puedes ajustar este valor según el espacio que desees
                child: ListView.builder(
                  shrinkWrap:
                      true, // Deja que la ListView se adapte al espacio disponible
                  physics:
                      NeverScrollableScrollPhysics(), // Desactiva el scroll propio de la ListView
                  itemCount: _sugerencias.length,
                  itemBuilder: (context, index) {
                    final sugerencia = _sugerencias[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 32,
                        ),
                        title: Text("Calificación: ${sugerencia.rating}"),
                        subtitle: Text(sugerencia.texto),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
