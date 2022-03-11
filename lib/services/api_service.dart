import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "https://api.coindesk.com/v1/";



  Future<dynamic> getCurrentPrice() async {
    var responseJson = {};

    var url = Uri.parse(_baseUrl + "bpi/currentprice.json");

    try {
      final response = await http.get(url);

      responseJson = _response(response);
    } on SocketException {
      return responseJson;
    }
    return responseJson;
  }

  // default response handler
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        return response.body.toString();
      case 401:
        return response.body.toString();
      case 403:
        return response.body.toString();
      case 500:
        return response.body.toString();
      default:
        return response.body.toString();
    }
  }
}
