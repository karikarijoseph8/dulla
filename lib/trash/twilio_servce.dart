import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../../constants/app_keys.dart';

class TwilioService {
  String accountSid = twilioSID;
  String authToken = twilioAuthToken;
  String from = twilioPhone;

  Future<String> sendTwilioSMS(String to) async {
    final String code = (1000 + Random().nextInt(9000)).toString();
    String body =
        "$code is your Orbit verification code. Please do not share with anyone.";
    final Uri uri = Uri.parse(
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json');

    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken'));

    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth,
    };

    final Map<String, String> data = {
      'To': to,
      'From': from,
      'Body': body,
    };

    final http.Response response =
        await http.post(uri, headers: headers, body: data);

    if (response.statusCode == 201) {
      print('SMS sent successfully.');

      return code;
    } else {
      print('Failed to send SMS. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return 'SMS-FAILED';
    }
  }
}
