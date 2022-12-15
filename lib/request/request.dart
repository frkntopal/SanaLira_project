import 'dart:convert';
import "package:http/http.dart" as http;

import '../model/model.dart';

class SanaliraRequest {
  Future<BankModel> getSanaliraData() async {
    var client = http.Client();
    var _liraRequest;

    try {
      var response =
          await client.get(Uri.parse('https://api.sanalira.com/assignment'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        _liraRequest = BankModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return _liraRequest;
    }

    return _liraRequest;
  }
}
