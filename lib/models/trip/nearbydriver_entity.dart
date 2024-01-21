class NearbyDriver {
  String key;
  String serviceType;
  double rotation;
  double accuracy;
  double latitude;
  double longitude;

  NearbyDriver({
    required this.key,
    required this.serviceType,
    required this.latitude,
    required this.longitude,
    required this.rotation,
    required this.accuracy,
  });
}
