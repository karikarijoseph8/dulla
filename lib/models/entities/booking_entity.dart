class BookingEntity {
  late String mybookingID;
  late String driverName;
  late String driverImg;
  late String driverCarName;
  late String driverPlateNumber;
  //trip
  late double distance;
  late int time;
  late double tripFare;
  late String tripStatus;
  late DateTime timeStamp;
  //pickUp
  late String pictLocationName;
  late String pictLocationAddress;
  late double pictLocationLatitude;
  late double pictLocationLongitube;

  //destination
  late String destinationName;
  late String destinationAddress;
  late double destinationLatitube;
  late double destinationLongitube;

  BookingEntity({
    required this.mybookingID,
    required this.driverName,
    required this.driverImg,
    required this.driverCarName,
    required this.driverPlateNumber,
    required this.distance,
    required this.time,
    required this.tripFare,
    required this.tripStatus,
    required this.timeStamp,
    //pickUp
    required this.pictLocationName,
    required this.pictLocationAddress,
    required this.pictLocationLatitude,
    required this.pictLocationLongitube,

    //destination
    required this.destinationName,
    required this.destinationAddress,
    required this.destinationLatitube,
    required this.destinationLongitube,
  });
}
