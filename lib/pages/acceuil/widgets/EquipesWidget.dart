import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Importation pour la mise en cache
import '../../../utils/loader.dart';
import '../../../utils/requete.dart';
import 'EquipeController.dart';

class EquipesWidget extends StatefulWidget {
  @override
  _EquipesWidgetState createState() => _EquipesWidgetState();
}

class _EquipesWidgetState extends State<EquipesWidget> {
  final EquipeController controller = Get.put(EquipeController());  // Utilisation de Get pour instancier le contrôleur
  final ScrollController _scrollController = ScrollController();  // Pour gérer le défilement et la pagination
  RxString mot = "".obs;

  @override
  void initState() {
    super.initState();
    controller.getAllEquipes();  // Charger les équipes au démarrage

    // Détection du bas de la liste pour charger plus d'équipes
    _scrollController.addListener(() {
      double position = _scrollController.position.pixels;
      double maxScroll = _scrollController.position.maxScrollExtent;

      // Détecte 90% de la fin du scroll pour déclencher le chargement
      if (position >= (maxScroll * 0.9) && !controller.isLoading && controller.hasMore) {
        print("Presque à la fin du scroll, chargement de la page suivante...");
        controller.loadMoreEquipes(); // Charger la page suivante
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();  // N'oubliez pas de nettoyer le ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        child: controller.obx(
              (state) {
            return Column(
              children: [
                Expanded(
                  child: Obx(
                        () => ListView.builder(
                      controller: _scrollController,  // Utilisation du ScrollController pour gérer la pagination
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.equipes.length,
                      itemBuilder: (context, index) {
                        Map equipe = controller.equipes[index];
                        if ("${equipe['nom']}".contains(mot.value)) {
                          return Container(
                            width: MediaQuery.of(context).size.height * 0.08,
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: Color(0xFFE9E6E6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Utilisation de CachedNetworkImage pour mise en cache et affichage avec placeholder
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: "${Requete.url}/equipe/logo/${equipe['id']}",
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(), // Loader pendant le chargement
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error), // Icone en cas d'erreur
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
                if (controller.isLoading) CircularProgressIndicator(), // Affiche un indicateur de chargement si nécessaire
              ],
            );
          },
          onEmpty: Container(),
          onError: (error) {
            return const Center(
              child: Text("Une erreur s'est produite lors du chargement des informations"),
            );
          },
          onLoading: Loader.loadingW(),
        ),
      ),
    );
  }
}
