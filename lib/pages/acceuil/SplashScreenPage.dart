import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mylinafoot/pages/acceuil/BottomNavigationBarPage.dart';
import 'package:mylinafoot/pages/programme/programme_controller.dart';
import 'widgets/ConnectionErrorPage.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final ProgrammeController programmeController = Get.put(ProgrammeController());


  @override
  void initState() {
    super.initState();
    initializeDateFormatting('Fr');
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      // Charger les données en arrière-plan
      await programmeController.getCalendrier();
      await programmeController.getAfficherWithStatus(programmeController.currentCalendrierId.value);

      // Naviguer vers la page d'accueil une fois les données chargées
      _navigateToHomePage();
    } catch (e) {
      print("Erreur lors du chargement des données : $e");
      Get.offAll(() => ConnectionErrorPage());
    }
  }

  void _navigateToHomePage() {
    // Attendre 2 secondes pour simuler le temps de chargement
    Future.delayed(Duration(seconds: 1), () {
      Get.offAll(() => BottomNavigationBarPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.37),
              Image.asset(
                'assets/mylinafoot.jpg',
                height: 100, // Taille fixe
                width: 100, // Taille fixe
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.24),
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sponsorisé par:",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.107,
                      decoration: BoxDecoration(
                        //color: Colors.yellow,
                        image: DecorationImage(
                            image: ExactAssetImage("assets/illicocash png.png"),
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}