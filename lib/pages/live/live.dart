import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mylinafoot/utils/paiement.dart';
import '../../utils/loader.dart';
import '../../utils/requete.dart';
import '../programme/programme_controller.dart';
import 'direct2.dart';
import 'direct.dart';
import 'direct3.dart';
import 'live_controller.dart';

class Live extends GetView<LiveController> {
  //
  String? idCalendrier;
  Live(this.idCalendrier);
  //
  ProgrammeController programmeController = Get.find();
  var box = GetStorage();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      //color: Colors.red, // Status bar color
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: [
      //       Colors.black,
      //       Colors.black,
      //       Colors.black,
      //       Colors.black,
      //       Colors.black,
      //     ],
      //   ),
      // ),
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Loader.backgroundColor,
          appBar: AppBar(
            title: const Text("Match en direct"),
            centerTitle: true,
            backgroundColor: Loader.backgroundColor,
          ),
          body: FutureBuilder(
            future: programmeController.getAllJourneeDeLaSaison2(idCalendrier!),
            builder: (c, t) {
              //
              if (t.hasData) {
                List matchs = t.data as List;
                List tris = triJournee(matchs);
                return ListView(
                  padding: EdgeInsets.all(10),
                  children: List.generate(
                    matchs.length,
                    (index) {
                      //
                      List directs = box.read("directs") ?? [];

                      //
                      bool suivre = false;
                      //
                      Map match = matchs[index];
                      //
                      directs.forEach((element) {
                        //
                        if (element['id'] == match['id']) {
                          suivre = true;
                        }
                      });
                      //
                      List ds = match['date'].split("-");
                      //
                      DateTime date = DateTime(
                          int.parse(ds[2]), int.parse(ds[1]), int.parse(ds[0]));
                      //
                      var d = DateFormat.yMMMEd().format(date);
                      //
                      return Card(
                        //color: Colors.white,
                        color: Colors.black,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 120,
                          width: double.maxFinite,
                          child: InkWell(
                            onTap: () {
                              //
                              if (!suivre) {
                                Get.to(Paiement(match, "Acheter direct"));
                              } else {
                                //suivre le direct
                                Get.to(Direct3());
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            //color: Colors.red,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${Requete.url}/equipe/logo/${match['idEquipeA']}"),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${match['nomEquipeA']}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        suivre
                                            ? Align(
                                                alignment: Alignment.topCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.play_circle,
                                                    color:
                                                        Colors.green.shade900,
                                                    size: 25,
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "JOURNEE ${match['journee']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade400),
                                          child: Column(children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "$d ${match['heure']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${match['stade']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "linafoot",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            //color: Colors.red,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${Requete.url}/equipe/logo/${match['idEquipeB']}"),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${match['nomEquipeB']}", //nomEquipeA
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (t.hasError) {
                return Container();
              }
              return Center(
                child: Container(
                  height: 40,
                  width: 40,
                  child: const CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List triJournee(List tab) {
    for (int i = 0; i < tab.length - 1; i++) {
      int index = i;
      for (int j = i + 1; j < tab.length; j++) {
        if (tab[j]['journee'] < tab[index]['journee']) {
          index = j;
        }
      }

      Map min = tab[index];
      tab[index] = tab[i];
      tab[i] = min;
    }
    return tab;
  }
}
