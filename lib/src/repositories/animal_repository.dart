import 'package:app_zoologico/src/model/animal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class AnimalRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger = Logger(printer: PrettyPrinter());

  AnimalRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Método para obtener un animal por su Document ID de Firestore
  Future<AnimalInfo> getAnimalById(String animalId) async {
    try {
      _logger.i('Fetching animal with ID: $animalId from Firestore');
      final docSnapshot =
          await _firestore.collection('animals').doc(animalId).get();
      if (docSnapshot.exists) {
        _logger.i('Animal ${docSnapshot.id} fetched successfully.');
        AnimalInfo animalInfo = AnimalInfo.fromFirestore(docSnapshot);
        String imageUrl = animalInfo.imageUrl;
        _logger.i('Animal: $imageUrl');
        return AnimalInfo.fromFirestore(docSnapshot);
      } else {
        _logger.w('Animal with ID: $animalId not found in Firestore.');
        throw Exception('Animal no encontrado.');
      }
    } catch (e) {
      _logger.e('Error fetching animal from Firestore: $e');
      throw Exception('Fallo al cargar el animal desde Firestore: $e');
    }
  }
}
