


import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Requete extends GetConnect {
  //Behold our online API
  static String url = "https://mylinafootbackendserveur-9c1d6014e77f.herokuapp.com/";

  //
  Future<http.Response> getE(String path) async {
    var response = await http.get(Uri.parse("$url/$path"));
    return response;
  }

  Future<Response> getEEE(String path) async {
    var response = await get("$url/$path");
    return response;
  }

  Future<Response> postE(String path, var e) async {
    var response = await post("$url/$path", e);
   return response;
  }

  Future<http.Response> putE(String path, Map e) async {
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    var response = await http.put(Uri.parse("$url/$path"), body: e);
    return response;
  }

  Future<http.Response> deleteE(String path, dynamic e) async {
    //var url = Uri.parse("${Connexion.lien}$path");
    var response = await http.delete(Uri.parse("$url/$path"));
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return response;
  }
}
