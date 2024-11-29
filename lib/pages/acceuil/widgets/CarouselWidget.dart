import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatelessWidget {

  //
  RxInt currentIndex = 0.obs;
  //

  List<Widget> carouselItems = [
    Image.asset(
      "assets/illicocash png.png",
      fit: BoxFit.cover, // Remplit le conteneur sans déformation
    ),
    Image.asset(
      "assets/pub_illicocash.jpg",
      fit: BoxFit.cover, // Remplit le conteneur sans déformation
    ),
    //Image.asset("assets/LOGO VERTICAL HD.png"),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft, // Début du dégradé en haut à gauche
          end: Alignment.bottomRight, // Fin du dégradé en bas à droite
          colors: [
            const Color(0xFFD33B3B), // Première couleur (rouge foncé)
            const Color(0xFF000000), // Deuxième couleur (noir)
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sports_baseball_rounded,
                          color: Colors.black,
                          size: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Text(
                            "Football",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Vivez les  merveilles du championat. Restez connecté avec mylinafoot app.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: 200,
                        width: 100,
                        child: Image.asset("assets/LOGO VERTICAL HD.png")
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text("Prêt !"),
              ],
            ),
          ],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.27),
        Container(
          height: Get.size.height / 3.8,
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.47,
              autoPlay: true,
              viewportFraction: 0.91,
              autoPlayAnimationDuration: const Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            items: carouselItems.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    elevation: 1,
                    child: Container(
                      //padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      child: item, // Affiche l'élément du carrousel (image ou design personnalisé)
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
