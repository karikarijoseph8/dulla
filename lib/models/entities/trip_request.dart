class TripRequestEntity {
  late String riderName;
  late DateTime requestTime;
  late double distance;
  late int duration;
  late double tripFare;
  late double carCategory;

  TripRequestEntity({
    required this.riderName,
    required this.requestTime,
    required this.distance,
    required this.duration,
    required this.tripFare,
    required this.carCategory,
  });
}
