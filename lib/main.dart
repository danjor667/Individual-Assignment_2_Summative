import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mylinafoot/utils/paiement_controller.dart';
import 'pages/acceuil/widgets/EquipeController.dart';
import 'pages/programme/programme_controller.dart';
import 'pages/acceuil/SplashScreenPage.dart';

void main() async {
  //
  ProgrammeController programmeController = Get.put(ProgrammeController());
  //
  PaiementController paiementController = Get.put(PaiementController());
  //
  EquipeController equipeController = Get.put(EquipeController());
  //
  await GetStorage.init();
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //
  var box = GetStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    //box.erase();
    //
    return GetMaterialApp(
        title: 'Linafoot',
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          colorScheme: const ColorScheme.dark(primary: Colors.red),
          textTheme: const TextTheme(
            titleSmall: TextStyle(fontSize: 10),
          ),
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),

          useMaterial3: true,
          //cardColor: Colors.white,
        ),
        home:
            //Paiement()
            //Login(3),
            SplashScreenPage()
            
        //Accueil(),
        );
  }
}
