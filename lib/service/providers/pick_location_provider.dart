import 'package:flutter/material.dart';
import 'package:orbit/constants/app_keys.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/trip/address.dart';
import 'package:orbit/service/providers/trip/places_utility.dart';

class PickLocationProvider with ChangeNotifier {
  // late Address _pickupAddress;
  Address _pickupAddress = Address(
    longitude: 0,
    latitude: 0,
    placeName: '',
    placeFormattedAddress: '',
    placeId: '',
  );

  String _placeAddress = "";
  String _placeName = "";

  String get placeAddress => _placeAddress;
  String get placeName => _placeName;

  Future<void> getData() async {
    final locData = boxLocationHive.get("key_location") as LocationHive;

    final double latitude = locData.latitude;
    final double longitude = locData.longitude;

    Uri uri = Uri.https(
      "maps.googleapis.com",
      '/maps/api/geocode/json',
      {"latlng": "$latitude,$longitude", "key": googleApiKey},
    );

    var response = await PlacesUtility.getRequest(uri);
    if (response != "failed") {
      _placeAddress = response["results"][0]["formatted_address"];
      _placeName = extractParts(_placeAddress);
      print("This is pickup reseponse[helper_page]: $response");
      final addressData = Address(
        placeId: '',
        latitude: latitude,
        longitude: longitude,
        placeName: _placeName,
        placeFormattedAddress: _placeAddress,
      );

      _pickupAddress = addressData;
      notifyListeners();
    }
  }

  Address get getCurrentLocation {
    return _pickupAddress;
  }

  set setPickupLocation(Address newAddress) {
    _pickupAddress = newAddress;
    notifyListeners();
  }
}

String extractParts(String inputString) {
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
