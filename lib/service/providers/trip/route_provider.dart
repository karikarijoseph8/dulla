import 'package:flutter/material.dart';
import 'package:orbit/models/trip/car_category_entity.dart';
import 'package:orbit/models/trip/directiondetails.dart';
import '../../../models/trip/address.dart';

class RouteDataProvider extends ChangeNotifier {
  late Address pickUpLocation;
  late Address dropOffLocation;
  late double distance;
  late int tripTime;
  late CarCategoryEntity carAndPrice;
  late double tripFare;
  late DirectionDetails directionDetails;

  int ratingCnt = 0;

  ///RIDE ACCEPTED
  String _rideAccepted = "";

  String get getRideAccepted {
    return this._rideAccepted;
  }

  set setRideAccepted(String newVal) {
    this._rideAccepted = newVal;
    this.notifyListeners();
  }

  void ratingCount(int newRatingCount) {
    ratingCnt = newRatingCount;
    notifyListeners();
  }

  void updateTripFare(double newTripFare) {
    tripFare = newTripFare;
    notifyListeners();
  }

  void updateCarAndPrice(CarCategoryEntity newCarAndPrice) {
    carAndPrice = newCarAndPrice;
    notifyListeners();
  }

  void updateTripTime(int newTime) {
    tripTime = newTime;
    notifyListeners();
  }

  void updateDistance(double newDistance) {
    distance = newDistance;
    notifyListeners();
  }

  void updatePickupAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDestinationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }

  void updateDirectionDetails(DirectionDetails new_directionDetails) {
    directionDetails = new_directionDetails;
    notifyListeners();
  }
}
