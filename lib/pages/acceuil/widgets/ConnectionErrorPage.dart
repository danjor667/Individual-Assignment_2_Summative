import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../SplashScreenPage.dart';
import 'ButtonReutilisable.dart';

class ConnectionErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          // Ajoutez un SizedBox pour contrôler la taille
          height: 100, // Définissez la hauteur souhaitée
          width: 150, //Définissez la largeur souhaitée
          child: Image.asset(
            'assets/mylinafoot2logo.png',
            fit: BoxFit.contain, // Assurez-vous que l'image est contenue dans le SizedBox
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 80, 80),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 100, color: Color(0xFF3A3838)),
            SizedBox(height: 20),
            Text(
              'Veuillez vérifier votre connexion internet!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF3A3838)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            ButtonReutilisableWidget(
              text: "Réessayer",
              borderWidth: 2,
              color: Colors.red,
              onPressed: () {
                Get.offAll(SplashScreenPage()); // Recommence depuis le splash screen
                },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
