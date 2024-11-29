import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mylinafoot/utils/requete.dart';
import '../../sqlitestorage_data_in_local/DatabaseHelper.dart';

class ProgrammeController extends GetxController with StateMixin<List> {
  Requete requete = Requete();

  RxInt currentCalendrierId = 0.obs;
  RxList affiches = <Map>[].obs;
  RxMap equipeA = {}.obs;
  RxInt journee = 0.obs;
  RxMap equipeB = {}.obs;
  RxMap commissaire = {}.obs;
  RxMap arbitreCentrale = {}.obs;
  RxMap arbitreAssitant1 = {}.obs;
  RxMap arbitreAssitant2 = {}.obs;
  RxMap arbitreProtocolaire = {}.obs;

  int currentPage = 1;
  int pageSize = 6;
  bool isLoading = false;
  bool hasMore = true;

  // Timer pour Debouncing
  Timer? _debounceTimer;

  Future<List> getAllJourneeDeLaSaison(String idCalendrier, String categorie) async {
    try {
      http.Response response = await requete.getE("match/All/journee/$idCalendrier/$categorie");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print("Erreur lors du chargement des journées : $e");
      return [];
    }
  }

  Future<List> getAllJourneeDeLaSaison2(String idCalendrier) async {
    try {
      http.Response response = await requete.getE("match/all/$idCalendrier");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {print("Erreur lors du chargement des journées : $e");
    return [];
    }
  }

  Future<void> getAllMatchsDeLaJournee(String idCalendrier, String categorie, String journee) async {
    change([], status: RxStatus.loading());
    try {
      http.Response response = await requete.getE("match/All/match/$idCalendrier/$categorie/$journee");
      if (response.statusCode == 200 || response.statusCode == 201) {
        change(jsonDecode(response.body), status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    } catch (e) {
      print("Erreur lors du chargement des matchs : $e");
      change([], status: RxStatus.error("Erreur lors du chargement"));
    }
  }

  Future<List> getAllMatchsDeLaJournee2(String idCalendrier, String categorie, String journee) async {
    change([], status: RxStatus.loading());
    try {
      http.Response response = await requete.getE("match/All/match/$idCalendrier/$categorie/$journee");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print("Erreur lors du chargement des matchs : $e");
      return [];
    }
  }

  Future<void> getCalendrier() async {
    try {
      http.Response response = await requete.getE("calendrier/actuel");
      if (response.statusCode == 200 || response.statusCode == 201) {
        currentCalendrierId.value = jsonDecode(response.body);
      } else {
        currentCalendrierId.value = 0;
      }
    } catch (e) {
      print("Erreur lors du chargement du calendrier : $e");
      currentCalendrierId.value = 0;
      rethrow;
    }
  }

  /*Future<void> getAfficher(int idCalendrier) async {
    if (isLoading || !hasMore) return;
    isLoading = true;

    try {
      final response = await http.get(Uri.parse('${Requete.url}/match/allaffiches/$idCalendrier?page=$currentPage&pageSize=$pageSize'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAffiches = List<Map<String, dynamic>>.from(data);

        if (newAffiches.isNotEmpty) {
          affiches.addAll(newAffiches);
          currentPage++;
        } else {
          hasMore = false;
        }
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle error
      print('Error during request: $e');
    } finally {
      isLoading = false;
      update();
    }
  }*/

  /*Future<Map<String, dynamic>> getAfficherWithStatus(int idCalendrier) async {
    try {
      http.Response response = await requete.getE("match/allaffiches/$idCalendrier?page=$currentPage&pageSize=$pageSize");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("Données reçues: $data");
        affiches.value = List<Map<String, dynamic>>.from(data);
        return {'status': response.statusCode, 'data': affiches};
      } else {
        affiches.clear();
        return {'status': response.statusCode};
      }
    } catch (e) {
      print("Veuillez vérifier votre connexion internet ! : $e");
      affiches.clear();
      return {'status': 500, 'error': e.toString()};
    }
  }*/
  // Méthode de pagination optimisée avec debouncing et retries
  Future<void> getAfficher(int idCalendrier, {int retryCount = 0}) async {
    if (isLoading || !hasMore) return;
    isLoading = true;

    try {
      final response = await http.get(Uri.parse('${Requete.url}/match/allaffiches/$idCalendrier?page=$currentPage&pageSize=$pageSize'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAffiches = List<Map<String, dynamic>>.from(data);

        if (currentPage == 1) {
          // Efface les anciennes données lors du premier appel
          affiches.clear();
        }

        if (newAffiches.isNotEmpty) {
          // Ajouter les nouvelles affiches à la liste actuelle
          affiches.addAll(newAffiches);

          // Stocker les nouvelles données dans SQLite
          await DatabaseHelper().insertProgramme(idCalendrier, jsonEncode(affiches), 'programme');

          // Incrémenter la page courante pour la prochaine pagination
          currentPage++;
        } else {
          hasMore = false; // Aucune donnée supplémentaire disponible
        }
      } else {
        throw Exception('Erreur de réponse: ${response.statusCode}');
      }
    } catch (e) {
      // Retry avec exponential backoff
      if (retryCount < 3) {
        await Future.delayed(Duration(seconds: 2 * retryCount));
        getAfficher(idCalendrier, retryCount: retryCount + 1);
      } else {
        print('Erreur après plusieurs tentatives: $e');
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  // Méthode avec Status, pagination, retries, et debouncing
  Future<Map<String, dynamic>> getAfficherWithStatus(int idCalendrier,
      {int retryCount = 0}) async {
    if (isLoading || !hasMore)
      return {'status': 500, 'error': 'Already loading or no more data'};
    isLoading = true;

    try {
      final response = await requete.getE(
          "match/allaffiches/$idCalendrier?page=$currentPage&pageSize=$pageSize");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("Données reçues: $data");

        // Ajouter les nouvelles affiches à la liste actuelle
        affiches.addAll(List<Map<String, dynamic>>.from(data));

        // Stocker les nouvelles données dans SQLite
        await DatabaseHelper().insertProgramme(
            idCalendrier, jsonEncode(affiches), 'programme');

        // Incrémenter la page courante
        currentPage++;

        return {'status': response.statusCode, 'data': affiches};
      } else {
        throw Exception('Erreur de réponse: ${response.statusCode}');
      }
    } catch (e) {
      // Retry avec exponential backoff
      if (retryCount < 3) {
        await Future.delayed(Duration(seconds: 2 * retryCount));
        return await getAfficherWithStatus(
            idCalendrier, retryCount: retryCount + 1);
      } else {
        print('Erreur après plusieurs tentatives: $e');
        return {'status': 500, 'error': e.toString()};
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  // Debounce pour les appels multiples
  void getAffichesDebounced(int idCalendrier) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      getAfficher(idCalendrier);
    });
  }
}