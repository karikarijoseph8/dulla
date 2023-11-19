class CarCategoryEntity {
  String categoryName;
  double baseFare;
  double perKilometerRate;
  double perMinuteRate;
  String imageURL;
  bool availability;
  int availableCars;

  CarCategoryEntity({
    required this.categoryName,
    required this.baseFare,
    required this.perKilometerRate,
    required this.perMinuteRate,
    required this.imageURL,
    required this.availability,
    required this.availableCars,
  });
}
