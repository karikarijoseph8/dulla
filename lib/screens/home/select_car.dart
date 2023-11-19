import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/shimmer/shimmer.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/service/firebase_futures/future_futures.dart';
import 'package:provider/provider.dart';
import '../../components/buttons/submit_btn.dart';
import '../../components/customfont/customFonts.dart';
import '../../models/trip/car_category_entity.dart';
import '../../models/trip/directiondetails.dart';
import '../../models/trip/nearbydriver_entity.dart';
import '../../service/providers/trip/route_provider.dart';

class SelectCar extends StatefulWidget {
  const SelectCar(
      {super.key,
      required this.tripDirectionDetails,
      required this.backBtn_selectBtn});

  final DirectionDetails tripDirectionDetails;
  final VoidCallback backBtn_selectBtn;

  @override
  State<SelectCar> createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  late List<NearbyDriver> availableDrivers;
  late DatabaseReference availableCarRef;
  late StreamSubscription<DatabaseEvent> rideSubscription;

  @override
  Widget build(BuildContext context) {
    final RouteDataProvider routeDataProvider =
        Provider.of<RouteDataProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.backBtn_selectBtn,
                  child: Icon(Icons.arrow_back_rounded),
                ),
                SizedBox(
                  width: 68,
                ),
                Text(
                  "Select A Ride",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // Replace with your StreamCarCategory widgets
                    StreamCarCategory(
                      tripDirectionDetails: widget.tripDirectionDetails,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFEFEFE),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      print("Payment method Clicked");
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 26),
                            padding: EdgeInsets.only(right: 70),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Color(0xFFDFE2E5),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgIcons/payment_cash.svg",
                                  width: 26,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Cash",
                                  style: CustomFonts.poppins(
                                    color: AppColors.mainBlack,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgIcons/additional_settings.svg",
                                width: 24,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "Additional",
                                style: CustomFonts.poppins(
                                  color: AppColors.mainBlack,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: SubmitButton(
                      onPressed: () {
                        Navigator.pop(context, 'carSelected');
                      },
                      buttonText: 'ORDER',
                      btnColor: AppColors.mainYellow,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int calculateDuration() {
    final durationInMinutes =
        (widget.tripDirectionDetails.durationValue / 60).ceil();
    return durationInMinutes;
  }

  double calculateDistance() {
    double distanceInMeters =
        widget.tripDirectionDetails.distanceValue.toDouble();
    double distanceInKilometers = distanceInMeters / 1000;
    return distanceInKilometers;
  }
}

class StreamCarCategory extends StatefulWidget {
  const StreamCarCategory({
    super.key,
    required this.tripDirectionDetails,
  });

  final DirectionDetails tripDirectionDetails;

  @override
  State<StreamCarCategory> createState() => _StreamCarCategoryState();
}

class _StreamCarCategoryState extends State<StreamCarCategory> {
  int _selectedCardIndex = 0;
  late CarCategoryEntity carCat;
  late double tripFare;
  late DatabaseReference availableCarRef;
  late StreamSubscription<DatabaseEvent> rideSubscription;
  List<Map<dynamic, dynamic>> availableCarList = [];
  int taxiCars = 0;
  int flashCars = 0;
  int superCars = 0;
  int luxuryCars = 0;
  int keke = 0;
  int okada = 0;
  int availableCars = 0;

  ///////Car Catrgory List/////////
  List<Map<dynamic, dynamic>> eliteCarList = [];
  List<Map<dynamic, dynamic>> nearbyEliteCarList = [];

  void _handleCardTap(int cardIndex, CarCategoryEntity carCat,
      RouteDataProvider routeDataProvider) {
    setState(() {
      _selectedCardIndex = cardIndex;
      tripFare = calculateFare(carCat);

      routeDataProvider.updateCarAndPrice(carCat);
      routeDataProvider.updateTripFare(tripFare);

      print(carCat.categoryName);
      print(tripFare);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAvailableDrivers();
  }

  Future<void> fetchAvailableDrivers() async {
    final availableCarRef =
        FirebaseDatabase.instance.ref().child('availDrivers');
    final DatabaseEvent event = await availableCarRef.once();
    final DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      availableCarList.clear();
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        availableCarList.add(value);
      });

      setState(() {
        taxiCars = availableCarList.where((element) {
          return element['serviceType'] == 'Orbit Taxi';
        }).length;
      });

      flashCars = availableCarList.where((element) {
        return element['serviceType'] == 'Flash';
      }).length;

      superCars = availableCarList.where((element) {
        return element['serviceType'] == 'Super';
      }).length;
      luxuryCars = availableCarList.where((element) {
        return element['serviceType'] == 'Luxury';
      }).length;
      keke = availableCarList.where((element) {
        return element['serviceType'] == 'Keke';
      }).length;

      okada = availableCarList.where((element) {
        return element['serviceType'] == 'Okada';
      }).length;
      // return availableCarList;
    } else {
      // Data is empty
      // return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    //final db = Provider.of<Database>(context, listen: false);
    final futureDB = Provider.of<FirebaseFutures>(context, listen: false);
    final routeDataProvider =
        Provider.of<RouteDataProvider>(context, listen: false);

    return FutureBuilder<List<CarCategoryEntity>?>(
        future: futureDB.getCarCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final carCategoryData = snapshot.data;
            print("Category Data $carCategoryData");
            List<CarCategoryEntity> modifiedCarCategoryData =
                carCategoryData!.map(
              (carCategoryEntity) {
                if (carCategoryEntity.categoryName == 'Orbit Taxi') {
                  //availableCars = eliteCars;

                  return CarCategoryEntity(
                    categoryName: carCategoryEntity.categoryName,
                    baseFare: carCategoryEntity.baseFare,
                    perKilometerRate: carCategoryEntity.perKilometerRate,
                    perMinuteRate: carCategoryEntity.perMinuteRate,
                    imageURL: carCategoryEntity.imageURL,
                    availability: carCategoryEntity.availability,
                    availableCars: taxiCars,
                  );
                } else if (carCategoryEntity.categoryName == 'Flash') {
                  return CarCategoryEntity(
                    categoryName: carCategoryEntity.categoryName,
                    baseFare: carCategoryEntity.baseFare,
                    perKilometerRate: carCategoryEntity.perKilometerRate,
                    perMinuteRate: carCategoryEntity.perMinuteRate,
                    imageURL: carCategoryEntity.imageURL,
                    availability: carCategoryEntity.availability,
                    availableCars: flashCars,
                  );
                } else if (carCategoryEntity.categoryName == 'Super') {
                  return CarCategoryEntity(
                    categoryName: carCategoryEntity.categoryName,
                    baseFare: carCategoryEntity.baseFare,
                    perKilometerRate: carCategoryEntity.perKilometerRate,
                    perMinuteRate: carCategoryEntity.perMinuteRate,
                    imageURL: carCategoryEntity.imageURL,
                    availability: carCategoryEntity.availability,
                    availableCars: superCars,
                  );
                } else if (carCategoryEntity.categoryName == 'Luxury') {
                  return CarCategoryEntity(
                    categoryName: carCategoryEntity.categoryName,
                    baseFare: carCategoryEntity.baseFare,
                    perKilometerRate: carCategoryEntity.perKilometerRate,
                    perMinuteRate: carCategoryEntity.perMinuteRate,
                    imageURL: carCategoryEntity.imageURL,
                    availability: carCategoryEntity.availability,
                    availableCars: luxuryCars,
                  );
                } else if (carCategoryEntity.categoryName == 'Keke') {
                  return CarCategoryEntity(
                    categoryName: carCategoryEntity.categoryName,
                    baseFare: carCategoryEntity.baseFare,
                    perKilometerRate: carCategoryEntity.perKilometerRate,
                    perMinuteRate: carCategoryEntity.perMinuteRate,
                    imageURL: carCategoryEntity.imageURL,
                    availability: carCategoryEntity.availability,
                    availableCars: keke,
                  );
                } else if (carCategoryEntity.categoryName == 'Okada') {
                  return CarCategoryEntity(
                    categoryName: carCategoryEntity.categoryName,
                    baseFare: carCategoryEntity.baseFare,
                    perKilometerRate: carCategoryEntity.perKilometerRate,
                    perMinuteRate: carCategoryEntity.perMinuteRate,
                    imageURL: carCategoryEntity.imageURL,
                    availability: carCategoryEntity.availability,
                    availableCars: okada,
                  );
                }

                return CarCategoryEntity(
                  categoryName: carCategoryEntity.categoryName,
                  baseFare: carCategoryEntity.baseFare,
                  perKilometerRate: carCategoryEntity.perKilometerRate,
                  perMinuteRate: carCategoryEntity.perMinuteRate,
                  imageURL: carCategoryEntity.imageURL,
                  availability: carCategoryEntity.availability,
                  availableCars: availableCars,
                );
              },
            ).toList();

            print("Modified Elite Cars $modifiedCarCategoryData ");

            return Column(
                children:
                    List.generate(modifiedCarCategoryData.length, (index) {
              final carCat = modifiedCarCategoryData[index];
              return CarCategoryCard(
                carCategoryEntity: carCat,
                tripFare: calculateFare(carCat),
                isSelected: _selectedCardIndex == index,
                onTap: () => _handleCardTap(index, carCat, routeDataProvider),
              );
            }));
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text("Error While ${snapshot.error}"),
              ),
            );
          }

          return Row(
            children: [
              ShimmerCard(),
              ShimmerCard(),
              ShimmerCard(),

              //Center(child: CircularProgressIndicator()),
            ],
          );
        });
  }

  int generateRandomNumber() {
    // Generate a random number between 1 and 10
    Random random = Random();
    int randomNumber = random.nextInt(10) + 1;
    return randomNumber;
  }

  double calculateFare(
    CarCategoryEntity carCategory,
  ) {
    final rideDurationMinutes =
        (widget.tripDirectionDetails.durationValue / 60).ceil();

    double distanceInMeters =
        widget.tripDirectionDetails.distanceValue.toDouble();
    // Convert the distance from meters to kilometers (1 km = 1000 meters)
    double rideDistanceKilometers = distanceInMeters / 1000;

    // Calculate fare based on base fare, per-minute rate, and per-kilometer rate
    double fare = carCategory.baseFare +
        (rideDurationMinutes * carCategory.perMinuteRate) +
        (rideDistanceKilometers * carCategory.perKilometerRate);

    return fare;
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: Shimmer(
        width: 88,
        height: 82,
      ),
    );
  }
}

class CustomRadioButton extends StatefulWidget {
  final bool isSelected;
  final Function(bool) onSelect;

  CustomRadioButton({required this.isSelected, required this.onSelect});

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Container(
        width: 22.0,
        height: 22.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                widget.isSelected ? AppColors.mainYellow : AppColors.mainYellow,
            width: 2.5,
          ),
          color: widget.isSelected ? AppColors.mainYellow : Colors.transparent,
        ),
        child: widget.isSelected
            ? Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class CarCategoryCard extends StatelessWidget {
  const CarCategoryCard({
    super.key,
    required this.carCategoryEntity,
    required this.tripFare,
    required this.isSelected,
    required this.onTap,
  });
  final CarCategoryEntity carCategoryEntity;
  final double tripFare;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    print("Modified Elite Cars1 ${carCategoryEntity.availableCars}");
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: isSelected
                ? EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 9)
                : EdgeInsets.only(top: 9, bottom: 9),
            margin: isSelected ? null : EdgeInsets.only(left: 10, right: 10),
            decoration: isSelected
                ? BoxDecoration(
                    color: Color(0xFFFFFCF2),
                    border: Border.all(
                      color: AppColors.mainYellow, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                  )
                : BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFEEEEEE), // Color of the border
                        width: 1.0, // Thickness of the border
                      ),
                    ),
                    // border: Border.all(
                    //   color: AppColors.mainYellow, // Border color
                    //   width: 1.0, // Border width
                    // ),
                    // borderRadius: BorderRadius.circular(10.0), // Border radius
                  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // Image.asset(
                    //   // "assets/icons/yellow_car_export.png",
                    //   "assets/icons/black_car_icon.png",
                    //   width: 72,
                    // )

                    Image.network(carCategoryEntity.imageURL,
                        width:
                            //  carCategoryEntity.categoryName == 'Pragya' ? 72 : 72,
                            72),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carCategoryEntity.categoryName,
                          style: CustomFonts.poppins(
                            color: carCategoryEntity.availableCars == 0
                                ? AppColors.blurredSubTitleTextColor
                                : AppColors.mainBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                carCategoryEntity.availableCars == 0
                                    ? "Busy"
                                    : "min",
                                style: CustomFonts.poppins(
                                  fontSize: 14,
                                  color: carCategoryEntity.availableCars == 0
                                      ? AppColors.blurredSubTitleTextColor
                                      : Color(0xFF747682),
                                  //fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgIcons/profile_icon.svg",
                                  width: 10,
                                  color: carCategoryEntity.availableCars == 0
                                      ? AppColors.blurredSubTitleTextColor
                                      : null,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("",
                                    style: CustomFonts.poppins(
                                      fontSize: 14,
                                      color: carCategoryEntity.availableCars ==
                                              0
                                          ? AppColors.blurredSubTitleTextColor
                                          : Color(0xFF747682),
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            // if (carCategoryEntity.best_save == true)
                            //   Text(
                            //     "Best save",
                            //     style: CustomFonts.poppins(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w600,
                            //       color: AppColors.mainYellow,
                            //     ),
                            //   ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  "GHS ${tripFare.round()}",
                  style: CustomFonts.poppins(
                    color: carCategoryEntity.availableCars == 0
                        ? AppColors.blurredTitleTextColor
                        : AppColors.mainBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
