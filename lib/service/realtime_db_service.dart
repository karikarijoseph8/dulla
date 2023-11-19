import 'package:firebase_database/firebase_database.dart';

class RealtimeDBService {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<void> terminatedRide(String rideID) async {
    await ref.child('rideRequest/$rideID').update({
      'status': 'terminated',
    });
  }

  // Future<void> setDriverServiceType(
  //   String serviceType,
  //   String driverID,
  // ) async {
  //   await ref.child('availDrivers/$driverID').update({
  //     'serviceType': serviceType,
  //   });
  // }
}
