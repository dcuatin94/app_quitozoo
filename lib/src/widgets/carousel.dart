import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AnimalCarousel extends StatelessWidget {
  AnimalCarousel({super.key});
  final List<String> imgList = [
    'assets/galeria/caiman.jpg', // Reemplaza con la ruta de tu imagen
    'assets/galeria/supay.jpg', // Reemplaza con la ruta de tu imagen
    'assets/galeria/cuchucho.jpg', // Reemplaza con la ruta de tu imagen
  ];

  final List<String> descriptions = [
    'El caimán hallado lejos de su hábitat',
    'Supay',
    'Un cuchucho valiente',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: CarouselSlider.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index, realIndex) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    imgList[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    descriptions[index],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: 300,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.easeInOut,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
