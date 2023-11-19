// import 'dart:math';
// import 'package:firebase_database/firebase_database.dart';

// class GeoFire {
//   final DatabaseReference _geoRef;

//   GeoFire(String path) : _geoRef = FirebaseDatabase.instance.ref().child(path);

//   // Add a location for a specific ID
//   Future<void> setLocation(String id, double latitude, double longitude) async {
//     await _geoRef.child(id).set({
//       'latitude': latitude,
//       'longitude': longitude,
//     });
//   }

//   // Remove the location for a specific ID
//   Future<void> removeLocation(String id) async {
//     await _geoRef.child(id).remove();
//   }

//   // Query locations within a specified radius from a point
//   Stream<List<String>> queryAtLocation(double lat, double lng, double radius) {
//     final center = GeoFirePoint(lat, lng);
//     final boundingBox = center.boundingBox(radius);

//     final query = _geoRef
//         .orderByChild('latitude')
//         .startAt(boundingBox['minLat'])
//         .endAt(boundingBox['maxLat']);

//     final Stream<List<String>> resultStream =
//         query.onValue.map((DatabaseEvent event) {
//       final Map<String, dynamic> data =
//           event.snapshot.value as Map<String, dynamic>;
//       final List<String> result = [];

//       if (data != null) {
//         data.forEach((id, locationData) {
//           final double locationLat = locationData['latitude'];
//           final double locationLng = locationData['longitude'];

//           final distance =
//               center.distance(GeoFirePoint(locationLat, locationLng));
//           if (distance <= radius) {
//             result.add(id);
//           }
//         });
//       }

//       return result;
//     });

//     return resultStream;
//   }
// }

// class GeoFirePoint {
//   final double latitude;
//   final double longitude;

//   GeoFirePoint(this.latitude, this.longitude);

//   Map<String, double> boundingBox(double radius) {
//     final degreesPerRadian = 180.0 / 3.14159265359;
//     final earthRadiusInMeters = 6371000.0;
//     final lat = latitude;
//     final lon = longitude;

//     final distance = radius / earthRadiusInMeters;
//     final minLat = lat - distance * degreesPerRadian;
//     final maxLat = lat + distance * degreesPerRadian;
//     final minLon =
//         lon - distance * degreesPerRadian / cos(lat * (3.14159265359 / 180));
//     final maxLon =
//         lon + distance * degreesPerRadian / cos(lat * (3.14159265359 / 180));

//     return {
//       'minLat': minLat,
//       'maxLat': maxLat,
//       'minLon': minLon,
//       'maxLon': maxLon,
//     };
//   }

//   double distance(GeoFirePoint other) {
//     final dLat = (other.latitude - latitude) * (3.14159265359 / 180);
//     final dLon = (other.longitude - longitude) * (3.14159265359 / 180);

//     final lat1 = latitude * (3.14159265359 / 180);
//     final lat2 = other.latitude * (3.14159265359 / 180);

//     final a = sin(dLat / 2) * sin(dLat / 2) +
//         sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);

//     final c = 2 * atan2(sqrt(a), sqrt(1 - a));

//     final earthRadiusInMeters = 6371000.0;
//     return earthRadiusInMeters * c;
//   }
// }

import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:geohash_plus/geohash_plus.dart';

class GeoService {
  final DatabaseReference _geoRef;
  final StreamController<Map<String, String?>> _geoQueryController =
      StreamController<Map<String, String?>>.broadcast();

  static const String onKeyEntered = 'onKeyEntered';
  static const String onKeyExited = 'onKeyExited';
  static const String onKeyMoved = 'onKeyMoved';
  static const String onGeoQueryReady = 'onGeoQueryReady';

  GeoService(String path)
      : _geoRef = FirebaseDatabase.instance.ref().child(path);

  Stream<Map<String, String?>> get geoQueryStream => _geoQueryController.stream;

  Future<void> setLocation(String id, double latitude, double longitude) async {
    final geohashA = GeoHash.encode(latitude, longitude, precision: 11);

    await _geoRef.child(id).set({
      'latitude': latitude,
      'longitude': longitude,
      'geoHash': geohashA.hash,
    });
  }

  // Remove the location for a specific ID
  Future<void> removeLocation(String id) async {
    await _geoRef.child(id).remove();
  }

  // Query locations within a specified radius from a point
  Stream<dynamic> queryAtLocation(double lat, double lng, double radius) {
    final center = GeoServicePoint(lat, lng);
    final boundingBox = center.boundingBox(radius);

    final query = _geoRef
        .orderByChild('latitude')
        .startAt(boundingBox['minLat'])
        .endAt(boundingBox['maxLat']);

    query.onValue.listen((event) {
      final Map<String, dynamic>? data =
          event.snapshot.value as Map<String, dynamic>?;

      if (data != null) {
        data.forEach((id, locationData) {
          final double locationLat = locationData['latitude'];
          final double locationLng = locationData['longitude'];

          final distance =
              center.distance(GeoServicePoint(locationLat, locationLng));

          if (distance <= radius) {
            // Emit events based on your criteria
            _emitGeoQueryEvent(onKeyEntered, id);
          } else {
            // Emit onKeyExited event for locations outside the radius
            _emitGeoQueryEvent(onKeyExited, id);
          }
        });

        // Emit onGeoQueryReady event when the query is complete
        _emitGeoQueryEvent(onGeoQueryReady, null);
      }
    });

    return Stream
        .empty(); // Return an empty stream for the queryAtLocation method
  }

  // Emit a GeoQuery event to the stream controller
  void _emitGeoQueryEvent(String eventType, String? key) {
    _geoQueryController.add({'eventType': eventType, 'key': key});
  }
}

class GeoServicePoint {
  final double latitude;
  final double longitude;

  GeoServicePoint(this.latitude, this.longitude);

  Map<String, double> boundingBox(double radius) {
    final degreesPerRadian = 180.0 / 3.14159265359;
    final earthRadiusInMeters = 6371000.0;
    final lat = latitude;
    final lon = longitude;

    final distance = radius / earthRadiusInMeters;
    final minLat = lat - distance * degreesPerRadian;
    final maxLat = lat + distance * degreesPerRadian;
    final minLon =
        lon - distance * degreesPerRadian / cos(lat * (3.14159265359 / 180));
    final maxLon =
        lon + distance * degreesPerRadian / cos(lat * (3.14159265359 / 180));

    return {
      'minLat': minLat,
      'maxLat': maxLat,
      'minLon': minLon,
      'maxLon': maxLon,
    };
  }

  double distance(GeoServicePoint other) {
    final dLat = (other.latitude - latitude) * (3.14159265359 / 180);
    final dLon = (other.longitude - longitude) * (3.14159265359 / 180);

    final lat1 = latitude * (3.14159265359 / 180);
    final lat2 = other.latitude * (3.14159265359 / 180);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final earthRadiusInMeters = 6371000.0;
    return earthRadiusInMeters * c;
  }
}
