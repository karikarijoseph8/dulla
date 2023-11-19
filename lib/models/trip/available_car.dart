class AvailableCar {
  String placeName;
  double latitude;
  double longitude;
  String placeId;
  String placeFormattedAddress;

  AvailableCar({
    required this.placeId,
    required this.latitude,
    required this.longitude,
    required this.placeName,
    required this.placeFormattedAddress,
  });
}
