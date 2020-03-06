import 'dart:convert';
import 'dart:io';

import 'package:foodapptask/consts/exports.dart';

class FetchData {
  getDataFromAPI() {
    List<Map<String, dynamic>> responseBody = [];
    HttpClient client = HttpClient();
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
          print(valueJson[0]);
          responseBody.add(valueJson[0]);
          responseBloc.valueStreamSink.add(responseBody);
        });
      });
    });
  }
}
