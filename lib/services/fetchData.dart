import 'dart:convert';
import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:foodapptask/consts/exports.dart';
// import 'package:http/http.dart' as http;

class FetchData {
  List<Map<String, dynamic>> getDataFromAPI() {
    var responseBody;
    // try {
    //   http.get(fetchDataURL).then((value){
    //     responseBody = jsonDecode(value.body);
    //   });
    // } catch (e) {
    //   log(e);
    // }
    // Future.delayed(Duration.zero);
    // return responseBody;
    HttpClient client = new HttpClient();
    // Dio dio = new Dio();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request;
    client.getUrl(Uri.parse(fetchDataURL)).then((value) {
      request = value;
      HttpClientResponse response;
      request.close().then((value) {
        response = value;
        String reply;
        response.transform(utf8.decoder).join().then((value) {
          reply = value;

          List<dynamic> valueJson = json.decode(reply);
          print(jsonEncode(valueJson));
          responseBody = jsonEncode(valueJson);
          // return responseBody;
        });
      });
    });
    return responseBody;
  }
}
