import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylinafoot/utils/paiement.dart';
import 'package:mylinafoot/utils/requete.dart';
import 'programme_controller.dart';

class ProgrammeJournee extends GetView<ProgrammeController> {
  final int Jn;
  final String idCalendrier;
  final String categorie;

  ProgrammeJournee(this.idCalendrier, this.categorie, this.Jn, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        FutureBuilder<List>(
          future: controller.getAllMatchsDeLaJournee2(
              idCalendrier, categorie, "$Jn"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erreur lors du chargement des matchs.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List matchs = snapshot.data!;
              return Column(
                children: List.generate(
                  matchs.length,
                      (index) {
                    Map match = matchs[index];
                    List<String> ds = match['date'].split("-");
                    DateTime date = DateTime(
                        int.parse(ds[2]), int.parse(ds[1]), int.parse(ds[0]));
                    String formattedDate = DateFormat.yMMMEd().format(date);
                    return Card(
                      color: const Color(0xFFD9D9D9),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 120,
                        width: double.maxFinite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => Paiement(match, "Acheter le billet"));
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  /*Expanded(
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
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${Requete.url}/equipe/logo/${match['idEquipeA']}"),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            match['nomEquipeA'] ?? '',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),*/
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
                                  /*Expanded(
                                    flex: 7,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
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
                                          const SizedBox(height: 10),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: Colors.grey.shade400,
                                            ),
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "$formattedDate ${match['heure']}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color:
                                                      Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    match['stade'] ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "linafoot",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 5,
                                                      fontWeight:
                                                      FontWeight.bold,
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
                                  ),*/
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
                                  /*Expanded(
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
                                  ),*/
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text('No matches found.'),
              );
            }
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
