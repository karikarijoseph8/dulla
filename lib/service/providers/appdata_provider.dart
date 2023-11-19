import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppDataProvider extends ChangeNotifier {
  int _selectedFAQ = 0;

  int get geSelectedFAQ {
    return this._selectedFAQ;
  }

  set setSelectedFAQ(int newVal) {
    this._selectedFAQ = newVal;
    this.notifyListeners();
  }

/////////////////////////////////////////////////
/////////////////CURRENT LOCATION////////////////
/////////////////////////////////////////////////
  late Position _currentPosition;

  Position get getCurrentLocation {
    return _currentPosition;
  }

  set setCurrentLocation(Position newVal) {
    _currentPosition = newVal;
    notifyListeners();
  }
}
