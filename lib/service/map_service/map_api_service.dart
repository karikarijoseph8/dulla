import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orbit/constants/app_keys.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/models/trip/directiondetails.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../data/hive/userhive.dart';
import '../../models/trip/address.dart';
import '../providers/trip/places_utility.dart';
import '../providers/trip/route_provider.dart';

class MapAPIService {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String placeName = "";
    // String url =
    // "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    final locData = boxLocationHive.get("key_location") as LocationHive;
    final double latitude = locData.latitude;
    final double longitude = locData.longitude;

    Uri uri = Uri.https("maps.googleapis.com", '/maps/api/geocode/json',
        {"latlng": "$latitude,$longitude", "key": googleApiKey});

    var response = await PlacesUtility.getRequest(uri);
    if (response != "ErrorResponse") {
      placeAddress = response["results"][0]["formatted_address"];
      placeName = extractParts(placeAddress);

      print("This is pickup reseponse[helper_page]: $response");

      Address userPickUpAddress = new Address(
          longitude: 0,
          latitude: 0,
          placeName: '',
          placeFormattedAddress: '',
          placeId: '');
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeName;

      // userPickUpAddress.placeFormattedAddress = placeAddress;
      // Provider.of<RouteDataProvider>(context, listen: false)
      //     .updatePickupAddress(userPickUpAddress);

      print("This is your pickup address: ${userPickUpAddress.placeName}");
      print("This is your pickup address: ${userPickUpAddress.placeName}");
    }

    return placeAddress;
  }

  static Future<void> searchCoordinateAddress2(BuildContext context) async {
    String placeAddress = "";
    String placeName = "";

    final locData = boxLocationHive.get("key_location") as LocationHive;

    final double latitude = locData.latitude;
    final double longitude = locData.longitude;

    Uri uri = Uri.https("maps.googleapis.com", '/maps/api/geocode/json',
        {"latlng": "$latitude,$longitude", "key": googleApiKey});

    var response = await PlacesUtility.getRequest(uri);
    if (response != "ErrorResponse") {
      placeAddress = response["results"][0]["formatted_address"];
      placeName = extractParts(placeAddress);

      print("This is pickup reseponse[helper_page]: $response");

      final userPickUpAddress = Address(
          longitude: 0,
          latitude: 0,
          placeName: '',
          placeFormattedAddress: '',
          placeId: '');

      userPickUpAddress.longitude = longitude;
      userPickUpAddress.latitude = latitude;
      userPickUpAddress.placeName = placeName;
      userPickUpAddress.placeFormattedAddress = placeAddress;

      //boxPickUpAddressHive.put("key_picupAddress", userPickUpAddress);
      Provider.of<RouteDataProvider>(context, listen: false)
          .updatePickupAddress(userPickUpAddress);

      print("This is your pickup address: ${userPickUpAddress.placeName}");
      print("This is your pickup address: ${userPickUpAddress.placeName}");
    }
  }

  static Future<DirectionDetails?> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    double startLatitude = startPosition.latitude;
    double startLongitude = startPosition.longitude;
    double endLatitude = endPosition.latitude;
    double endLongitude = endPosition.longitude;
    // String url =
    //   'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey';

    Uri uri = Uri.https("maps.googleapis.com", '/maps/api/directions/json', {
      "origin": "$startLatitude,$startLongitude",
      "destination": "$endLatitude,$endLongitude",
      "key": googleApiKey,
      //"traffic_model": "best_guess",
    });
    var response = await PlacesUtility.getRequest(uri);

    print("Direction Response: ${response}");

    if (response == 'failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails(
      encodedPoints: '',
      durationValue: 0,
      distanceText: '',
      distanceValue: 0,
      durationText: '',
    );

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int randInt = randomGenerator.nextInt(max);

    return randInt.toDouble();
  }

  //Sending the Notification
  static sendNotification(
      String token, context, String rideId, String driverName) async {
    print('Notification sent successfully');
    Map notificationMap = {
      'title': 'New Ride Request!',
      //'body': 'Destination, ${destination.placeName}'
      'body': "Hello $driverName, you have a new ride request."
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'rideID': rideId,
      'testMsg': 'This is testing'
    };

    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmServerKey',
    };

    final body = <String, dynamic>{
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token,
    };

    final response =
        await http.post(url, headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Error sending notification: ${response.body}');
    }

    // Uri uri = Uri.https(
    //     "maps.googleapis.com",
    //     'maps/api/place/autocomplete/json',
    //     {"input": query, "key": googleApiKey})
  }

  static String getFirstPartBeforeComma(String input) {
    // Split the input string by the comma
    List<String> parts = input.split(',');

    // Check if there is at least one part before the comma
    if (parts.isNotEmpty) {
      // Return the first part (trimmed to remove leading/trailing spaces)
      return parts.first.trim();
    } else {
      // Return an empty string if there are no parts before the comma
      return '';
    }
  }

  static String extractParts(String inputString) {
    List<String> parts = inputString.split(', ');

    if (parts.length >= 2) {
      String firstPart = parts[0];
      String secondPart = parts[1];
      return '$firstPart, $secondPart';
    } else {
      // Handle the case when there are not enough parts
      return inputString;
    }
  }
}
