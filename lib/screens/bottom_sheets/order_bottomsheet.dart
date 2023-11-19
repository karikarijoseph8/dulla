import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/home/select_car_card.dart';
import 'package:orbit/components/shimmer/shimmer.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/trip/car_category_entity.dart';
import 'package:orbit/models/trip/directiondetails.dart';
import 'package:orbit/service/firebase_futures/future_futures.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../service/providers/trip/route_provider.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({
    super.key,
    required this.onOrderPressed,
  });

  final VoidCallback onOrderPressed;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      maxHeight: 400,
      minHeight: 400,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(18.0),
        topLeft: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .5,
      panelSnapping: true,
      backdropEnabled: false,
      boxShadow: const [
        BoxShadow(
          spreadRadius: 6,
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.05),
        )
      ],
      body: Container(),
      panelBuilder: (controller) => ConfirmPanelWidget(
        onOrderPressed: onOrderPressed,
      ),
    );
  }
}

class ConfirmPanelWidget extends StatelessWidget {
  const ConfirmPanelWidget({
    super.key,
    required this.onOrderPressed,
  });
  final VoidCallback onOrderPressed;
  @override
  Widget build(BuildContext context) {
    Padding(padding: EdgeInsets.zero);
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 12,
          ),
          PickUpDestinationCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Divider(
                  thickness: 1, // Set the thickness of the divider
                  color: Color(0xFFEEEEEE), //Set the color of the divider
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Payment method Clicked");
            },
            child: Container(
              //margin: EdgeInsets.only(left: 20, right: 20),
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
          SizedBox(
            height: 20,
          ),
          StreamCarCategory(),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: SubmitButton(
              onPressed: onOrderPressed,
              buttonText: 'ORDER',
              btnColor: AppColors.mainYellow,
            ),
          ),
        ],
      ),
    );
  }
}

class PickUpDestinationCard extends StatelessWidget {
  const PickUpDestinationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RouteDataProvider routeDataProvider =
        Provider.of<RouteDataProvider>(context, listen: false);
    //double distance = routeDataProvider.distance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 14,
            ),
            Container(
              width: 18, // Adjust the width as needed
              height: 18, // Adjust the height as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Makes it a circular container
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFCC3B), Color(0xFFF8B71C)],
                ),
              ),
              child: Center(
                child: Container(
                  width: 8, // Adjust the width of the centered white container
                  height:
                      8, // Adjust the height of the centered white container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Makes it a circular container
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 18, // Adjust the width as needed
              height: 18, // Adjust the height as needed
              decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes it a circular container
                  color: Color(0xFFBAB9B7)),
              child: Center(
                child: Container(
                  width: 8, // Adjust the width of the centered white container
                  height:
                      8, // Adjust the height of the centered white container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Makes it a circular container
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PickUpTile(
                routeDataProvider: routeDataProvider,
              ),
              SizedBox(
                height: 20,
              ),
              DestinationTile(
                routeDataProvider: routeDataProvider,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PickUpTile extends StatelessWidget {
  const PickUpTile({
    super.key,
    required this.routeDataProvider,
  });

  final RouteDataProvider routeDataProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routeDataProvider.pickUpLocation.placeName,
                  style: CustomFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  // truncate(address.placeFormattedAddress, 40, omission: "..."),
                  routeDataProvider.pickUpLocation.placeFormattedAddress,
                  style: CustomFonts.poppins(
                    // color: AppColors.greyMessages2,
                    // color: Color(0xFF636773),666563
                    color: Color(0xFF666563),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            // SvgPicture.asset(
            //   "assets/svgIcons/confirmtrip_order_edit.svg",
            //   width: 16,
            // )
          ],
        ),
      ),
    );
  }
}

class DestinationTile extends StatelessWidget {
  const DestinationTile({
    super.key,
    required this.routeDataProvider,
  });

  final RouteDataProvider routeDataProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routeDataProvider.dropOffLocation.placeName,
                  style: CustomFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  //truncate(address.placeFormattedAddress, 40, omission: "..."),
                  routeDataProvider.dropOffLocation.placeFormattedAddress,
                  style: CustomFonts.poppins(
                    //color: AppColors.greyMessages2,
                    //color: Color(0xFF636773),666563
                    color: Color(0xFF666563),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            // SvgPicture.asset(
            //   "assets/svgIcons/confirmtrip_order_edit.svg",
            //   width: 16,
            // )
          ],
        ),
      ),
    );
  }
}

class StreamCarCategory extends StatefulWidget {
  const StreamCarCategory({
    super.key,
  });

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
      tripFare = calculateFare(carCat, routeDataProvider.directionDetails);
      routeDataProvider.updateTripFare(tripFare);
      routeDataProvider.updateCarAndPrice(carCat);
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

    DirectionDetails tripDirectionDetails = routeDataProvider.directionDetails;
    print("Direction Details:${tripDirectionDetails.distanceValue}");

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

            return Container(
              height: 82,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      List.generate(modifiedCarCategoryData.length, (index) {
                    final carCat = modifiedCarCategoryData[index];
                    // return CarCategoryCard(
                    //   carCategoryEntity: carCat,
                    //   tripFare: calculateFare(carCat),
                    //   isSelected: _selectedCardIndex == index,
                    //   onTap: () => _handleCardTap(index, carCat, routeDataProvider),
                    // );

                    return SelectCarCard(
                      carCat: carCat,
                      isSelected: _selectedCardIndex == index,
                      onTap: () =>
                          _handleCardTap(index, carCat, routeDataProvider),
                      tripFare: calculateFare(carCat, tripDirectionDetails),
                    );
                  })),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text("Error While ${snapshot.error}"),
              ),
            );
          }

          //return Text("Loading");

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
      CarCategoryEntity carCategory, DirectionDetails tripDirectionDetails) {
    final rideDurationMinutes =
        (tripDirectionDetails.durationValue / 60).ceil();

    double distanceInMeters = tripDirectionDetails.distanceValue.toDouble();
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
      margin: EdgeInsets.only(left: 16),
      child: Shimmer(
        width: 88,
        height: 82,
      ),
    );
  }
}
