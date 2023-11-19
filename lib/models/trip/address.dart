class Address {
  String placeName;
  double latitude;
  double longitude;
  String placeId;
  String placeFormattedAddress;

  Address({
    required this.placeId,
    required this.latitude,
    required this.longitude,
    required this.placeName,
    required this.placeFormattedAddress,
  });
}
