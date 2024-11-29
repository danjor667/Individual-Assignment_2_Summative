import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mylinafoot/utils/requete.dart';
import 'package:http/http.dart' as http;

class PaiementController extends GetxController {
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  Future<Map> payerBiller(Map billet) async {
    //
    http.Response response = await requete.getE("");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      return jsonDecode(response.body);
    } else {
      //
      return {};
    }
  }

  //
  payerDirect(Map billet) async {
    //
    http.Response response = await requete.getE("");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      return response.body;
    } else {
      //
      return {};
    }
  }

  //
  Future<List> payerVerification(Map billet, String titre) async {
    //
    Response response = titre == "Acheter le billet"
        ? await requete.postE("paiement/billet", billet)
        : await requete.postE("paiement/direct", billet);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (titre == "Acheter le billet") {
        print("rep: ${response.body}");
        //
        List billets = box.read("billets") ?? [];
        //
        //La reponse quee je reçois est une liste de billet(s)
        List lbs = response.body;
        for (var billet in lbs) {
          //
          billets.add(billet);
        }
        //
        box.write("billets", billets);
        //
        Get.back();

        if (lbs.length == 1) {
          //

          Get.snackbar(
              "Succès", "Billet acheté! voir dans profile, Bon match.");
        } else {
          Get.snackbar(
              "Succès", "Billets achetés, ! voir dans profile, Bon match.");
        }
        //
      } else {
        //
        print("rep: ${response.body}");
        //
        List directs = box.read("directs") ?? [];
        //
        //La reponse quee je reçois est une liste de billet(s)
        List lbs = response.body;
        for (var billet in lbs) {
          //
          directs.add(billet);
        }
        //
        box.write("directs", directs);
        //
        Get.back();

        if (lbs.length == 1) {
          //

          // Get.snackbar(
          // "Succès", "Billet acheté! voir dans profile, Bon match.");
          Get.dialog(
            Center(
              child: Card(
                elevation: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Billet acheté avec succès cliquez sur voir",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
          //
        } else {
          // Get.snackbar(
          //     "Succès", "Billets achetés, ! voir dans profile, Bon match.");
          Get.dialog(
            Center(
              child: Card(
                elevation: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Billet(s) achetés avec succès cliquez sur voir",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          //
                          Get.back();
                          //
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
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Voir",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.qr_code)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          //
        }
      }
      return response.body;
    } else {
      Map e = response.body;
      Get.back();
      Get.snackbar("Erreur", "${e['respcodedesc']}",
          colorText: Colors.white, backgroundColor: Colors.red);
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      //
      return [];
    }
  }
  //

  Future<Map> sendOTP(Map data) async {
    Response response = await requete.postE(
        "paiement/otp?telephone=${data['telephone']}&montant=${data['montant']}&devise=${data['devise']}",
        data);
    //844182365//Jonathan
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      Get.back();
      print("response: ${response.statusCode}");
      print("response: ${response.body}");
      return response.body;
    } else {
      //
      print("response: ${response.statusCode}");
      print("response: ${response.body}");
      Get.back();
      return {"place": response.body};
    }
    //844182365
  }
  //
}
