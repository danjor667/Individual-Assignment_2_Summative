import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylinafoot/utils/loader.dart';
import 'package:mylinafoot/utils/paiement_controller.dart';
import 'package:mylinafoot/utils/requete.dart';

class Paiement extends StatelessWidget {
  //
  String? titre;
  //
  PaiementController paiementController = Get.find();
  //
  Map match;
  Map p = {};
  //
  Paiement(this.match, this.titre, {super.key}) {
    print("Match::: $match");
    //
    List ds = match['date'].split("-");
    //
    //places.add({"place": "Test", "prix": 3000, "devise": "CDF"});
    //
    DateTime date =
    DateTime(int.parse(ds[2]), int.parse(ds[1]), int.parse(ds[0]));
    //
    d = DateFormat.yMMMEd().format(date);
    //
    if (match['prixPourtour'] != null || match['prixPourtour'] > 0) {
      //
      p = {"place": "Pourtour", "prix": match['prixPourtour'], "devise": "CDF"};
      places.add({
        "place": "Pourtour",
        "prix": match['prixPourtour'],
        "devise": "CDF"
      });
      //places.add("Pourtour (${match['prixPourtour']}) CDF");
    }
    //
    if (match['prixPprixTribuneLateralleourtour'] != null ||
        match['prixTribuneLateralle'] > 0) {
      places.add({
        "place": "Tribune Lateralle",
        "prix": match['prixTribuneLateralle'],
        "devise": "CDF"
      });
      //places.add("Tribune Lateralle (${match['prixTribuneLateralle']}) CDF");
    }
    //
    if (match['prixTribuneHonneur'] != null ||
        match['prixTribuneHonneur'] > 0) {
      places.add({
        "place": "Tribune Honneur",
        "prix": match['prixTribuneHonneur'],
        "devise": "CDF"
      });
      //places.add("Tribune Honneur (${match['prixTribuneHonneur']}) CDF");
    }
    //
    if (match['prixTribuneCentrale'] != null ||
        match['prixTribuneCentrale'] > 0) {
      places.add({
        "place": "Tribune Centrale",
        "prix": match['prixTribuneCentrale'],
        "devise": "CDF"
      });
      //places.add("Tribune Centrale (${match['prixTribuneCentrale']}) CDF");
    }
    //
    if (match['prixVIP'] != null || match['prixVIP'] > 0) {
      places.add(
          {"place": "Place VIP", "prix": match['prixVIP'], "devise": "CDF"});
      //places.add("Tribune Centrale (${match['prixTribuneCentrale']}) CDF");
    }
  }

  final formKey = GlobalKey<FormState>();
  final telephone = TextEditingController();
  final nombrePlace = TextEditingController();
  final typePlace = TextEditingController();
  final opt = TextEditingController();
  //
  List places = [];
  RxInt place = 0.obs;
  //
  RxBool showOTP = false.obs;
  //
  var d;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titre!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 80, 80),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all( 12.0),
                      child: Text(
                        'Ma rencontre',
                        style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Card(
                  color: const Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "${Requete.url}/equipe/logo/${match['idEquipeA']}",
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.height * 0.06,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.005,
                                ),
                                Text(
                                  "${match['nomEquipeA']}",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF3A3838),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "JOURNÉE ${match['journee']}",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3A3838),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFB0B0B0),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "$d ${match['heure']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF3A3838),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${match['stade']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Linafoot",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "${Requete.url}/equipe/logo/${match['idEquipeB']}",
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.height * 0.06,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${match['nomEquipeB']}",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF3A3838),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all( 12.0),
                      child: Text(
                        'Payer par :',
                        style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    //color: Colors.yellow,
                    image: DecorationImage(
                        image: ExactAssetImage("assets/illicocash png.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all( 12.0),
                      child: Text(
                        'Téléphone :',
                        style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                /*Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Téléphone",
                    style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),*/
                //
                TextFormField(
                  controller: telephone,
                  //textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3A3838), // Change the text color here
                  ),
                  //autofocus: true,
                  //focusNode: FocusNode(skipTraversal: true),
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "Veuilliez inserer votre numéro de téléphone";
                    } else if (e.length >= 10) {
                      return "Le numéro n'est pas correct !";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefix: const Text(
                      '00243 ',
                      style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFF3A3838)), // Change this color
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFF3A3838),)

                    ),
                    prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF3A3838),),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                titre! == "Acheter le billet"
                    ? Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Place",
                    style: textStyle,
                  ),
                )
                    : Container(),
                titre! == "Acheter le billet"
                    ? Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Obx(
                          () => DropdownButton(
                        onChanged: (e) {
                          //
                          place.value = e as int;
                          p = places[place.value];
                          //
                        },
                        value: place.value,
                        items: List.generate(
                          places.length,
                              (index) => DropdownMenuItem(
                            value: index,
                            child: Text(
                                "${places[index]['place']} (${places[index]['prix']} ${places[index]['devise']} )"),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                titre! == "Acheter le billet"
                    ? Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Nombre de billets",
                    style: textStyle,
                  ),
                )
                    : Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Achat du direct",
                    style: TextStyle(color: Color(0xFF3A3838), fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                titre! == "Acheter le billet"
                    ? TextFormField(
                  controller: nombrePlace,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  //autofocus: true,
                  //focusNode: FocusNode(skipTraversal: true),
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "Veuilliez inserer votre numéro de téléphone";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.chair),
                  ),
                )
                    : Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "3000 CDF",
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Payer en toute sécurité",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    //
                    Loader.loading();
                    //
                    Map x = titre! == "Acheter le billet"
                        ? {
                      "id": match['id'],
                      "journee": match['journee'],
                      "nomEquipeA": match['nomEquipeA'],
                      "nomEquipeB": match['nomEquipeB'],
                      "date": match['date'],
                      "heure": match['heure'],
                      "stade": match['stade'],
                      "place": p['place'],
                      "telephone": "00243${telephone.text}",
                      "nombrePlace": nombrePlace.text,
                      //"montant": 3000,
                      "montant": double.parse('${p['prix']}') *
                          int.parse(nombrePlace.text),
                      "devise": p['devise'],
                      "qrcode": mdpGenerer(),
                    }
                        : {
                      "id": match['id'],
                      "journee": match['journee'],
                      "nomEquipeA": match['nomEquipeA'],
                      "nomEquipeB": match['nomEquipeB'],
                      "date": match['date'],
                      "heure": match['heure'],
                      "stade": match['stade'],
                      "place": "Direct",
                      "telephone": "00243${telephone.text}",
                      "nombrePlace": 1,
                      "montant": 1500,
                      "devise": "CDF",
                      "qrcode": mdpGenerer(),
                    };
                    //
                    print("x: $x");
                    //
                    Map reponse = await paiementController.sendOTP(x);
                    print("reponse 1: $reponse");
                    //Approuvé
                    if (reponse["respcodedesc"] == "Client introuvable") {
                      //
                      Get.snackbar(
                        "Oups",
                        "Vous n'etes pas client ILLICOCASH Veuillez-vous enregistrer dans un shop ILLICOCASH",
                        colorText: Colors.white,
                        backgroundColor: Colors.red.shade900,
                      );
                    } else if (reponse["place"] != null) {
                      //
                      Get.snackbar(
                        "Oups",
                        reponse["place"],
                        colorText: Colors.white,
                        backgroundColor: Colors.red.shade900,
                      );
                    } else if (reponse["respcodedesc"] ==
                        "Source de transaction inconnue") {
                      Get.snackbar(
                        "Oups",
                        reponse["respcodedesc"],
                        colorText: Colors.white,
                        backgroundColor: Colors.red.shade900,
                      );
                      /**
                       *
                       */
                    } else if (reponse["respcodedesc"] ==
                        "Le solde de ce compte est insuffisant. Veuillez contacter le call center au 4488 pour plus d' informations.") {
                      Get.snackbar(
                        "Oups",
                        reponse["respcodedesc"],
                        colorText: Colors.white,
                        backgroundColor: Colors.red.shade900,
                      );
                      /**
                       * Le solde de ce compte est insuffisant. Veuillez contacter le call center au 4488 pour plus d' informations.
                       */
                    } else if (reponse["respcode"] == "00" ||
                        reponse["respcode"] == 00) {
                      //
                      TextEditingController otp = TextEditingController();
                      //Get.snackbar("Succès", "Vous-avez reçu un code veuillez ");
                      Get.dialog(
                        Material(
                          color: Colors.transparent,
                          child: Center(
                            child: Card(
                              elevation: 1,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 300,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Veuillez inserer le code que vous avez reçu par SMS",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      controller: otp,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 5),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        prefixIcon: const Icon(Icons.numbers),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              //
                                              Get.back();
                                              Loader.loading();
                                              //
                                              x['otp'] = otp.text;
                                              x["qrcode"] = mdpGenerer();
                                              x['referencenumber'] =
                                              reponse["referencenumber"];
                                              //
                                              paiementController
                                                  .payerVerification(
                                                  x, titre!);
                                            },
                                            style: ButtonStyle(
                                              fixedSize:
                                              MaterialStateProperty.all(
                                                const Size(
                                                  double.maxFinite,
                                                  45,
                                                ),
                                              ),
                                              shape:
                                              MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                ),
                                              ),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 0, 90, 23),
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.maxFinite,
                                              child: const Text(
                                                "Valider",
                                                style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              //
                                              Get.back();
                                            },
                                            style: ButtonStyle(
                                              fixedSize:
                                              MaterialStateProperty.all(
                                                const Size(
                                                  double.maxFinite,
                                                  45,
                                                ),
                                              ),
                                              shape:
                                              MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                ),
                                              ),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  Loader.backgroundColor),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.maxFinite,
                                              child: const Text(
                                                "Annuler",
                                                style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      //
                      //  "Le solde de ce compte est insuffisant. Veuillez contacter le call center au 4488 pour plus d' informations.") {

                    Get.snackbar(
                        "Oups",
                        reponse["respcodedesc"],
                        colorText: Colors.white,
                        backgroundColor: Colors.red.shade900,
                      );
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(
                        double.maxFinite,
                        45,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 80, 80), // Wrap the Color here
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    child: const Text(
                      "Envoyer",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
            //)
          ),
        ),
      ),
    );
  }

  TextStyle textStyle = const TextStyle(
    color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400
  );
  //
  String mdpGenerer() {
    //
    var r = Random();
    //
    DateTime d = DateTime.now();
    //
    String mdp =
        "${d.year}${d.month}${d.day}${d.hour}${d.minute}${d.second}${d.millisecond}${d.microsecond}";
    return mdp;
  }
}
