import 'dart:convert'; // Importez dart:convert
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../sqlitestorage_data_in_local/DatabaseHelper.dart';
import '../../../utils/requete.dart';

class EquipeController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  final DatabaseHelper dbHelper = DatabaseHelper();

  int currentPage = 1;
  final int pageSize = 10;
  RxList equipes = <dynamic>[].obs;
  bool isLoading = false;  // Indique si un chargement est en cours
  bool hasMore = true;  // Indique s'il y a plus de pages à charger

  Future<void> getAllEquipes({bool loadMore = false}) async {
    if (isLoading || !hasMore) return;  // Empêche les appels multiples ou s'il n'y a plus de pages à charger
    isLoading = true;  // Démarre le chargement

    if (!loadMore) {
      currentPage = 1;  // Réinitialiser la page si ce n'est pas un chargement de plus
      //equipes.clear();  // Réinitialiser les équipes si c'est un nouveau chargement
    }

    final String url = "equipe/All/afficher?page=$currentPage&pageSize=$pageSize";
    print("Appel API: $url");  // Debug pour vérifier l'URL

    http.Response httpResponse = await requete.getE(url);

    if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
      List<dynamic> equipeList = jsonDecode(httpResponse.body);

      if (equipeList.isNotEmpty) {
        equipes.addAll(equipeList);  // Ajoute les équipes récupérées à la liste
        currentPage++;  // Incrémente la page pour la prochaine requête
        print("Page $currentPage chargée.");
      } else {
        hasMore = false;  // Arrêter de charger s'il n'y a plus de résultats
        print("Toutes les pages sont chargées.");
      }

      change(equipes, status: RxStatus.success());
    } else {
      print("Erreur: ${httpResponse.statusCode}");
      change([], status: RxStatus.error("Erreur lors du chargement des équipes."));
    }

    isLoading = false;  // Fin du chargement
  }

  Future<void> loadMoreEquipes() async {
    print("Chargement de la page suivante: $currentPage");
    await getAllEquipes(loadMore: true);
  }

}
