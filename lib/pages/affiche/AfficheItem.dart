import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mylinafoot/utils/paiement.dart';
import 'package:mylinafoot/utils/requete.dart';

import '../live/live_controller.dart';

class AfficheItem extends GetView<LiveController> {
  final Map match;

  AfficheItem(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List directs = box.read("directs") ?? [];
    bool suivre = directs.any((element) => element['id'] == match['id']);

    DateTime date = _parseDate(match['date']);
    String formattedDate = DateFormat.yMMMEd('fr').format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.12,
          width: double.maxFinite,
          child: InkWell(
            onTap: () {
              Get.to(() => Paiement(match, "Achat du billet"));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bloc pour l'équipe A
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

                // Bloc central pour l'information du match
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (suivre)
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Icon(
                                Icons.play_circle,
                                color: Colors.green.shade900,
                                size: 25,
                              ),
                            ),
                          ),
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
                                  "$formattedDate à ${match['heure']}",
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

                // Bloc pour l'équipe B
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
      ),
    );
  }

  DateTime _parseDate(String dateString) {
    List<String> ds = dateString.split("-");
    return DateTime(int.parse(ds[2]), int.parse(ds[1]), int.parse(ds[0]));
  }
}
