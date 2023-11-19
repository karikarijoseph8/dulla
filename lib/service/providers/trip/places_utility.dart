import 'dart:convert';

import 'package:http/http.dart' as http;

class PlacesUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}

    return null;
  }

  static Future<dynamic> getRequest(Uri url) async {
    http.Response response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }
}
