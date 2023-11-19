// import 'dart:async';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:orbit/components/shimmer/shimmer.dart';
// import 'package:orbit/constants/app_colors.dart';
// import 'package:provider/provider.dart';
// import '../../components/buttons/submit_btn.dart';
// import '../../components/customfont/customFonts.dart';
// import '../../models/trip/car_category_entity.dart';
// import '../../models/trip/directiondetails.dart';
// import '../../models/trip/nearbydriver_entity.dart';
// import '../../service/providers/trip/route_provider.dart';
// import '../../service/streams/stream_provider.dart';

// class SelectCar extends StatefulWidget {
//   const SelectCar(
//       {super.key,
//       required this.tripDirectionDetails,
//       required this.backBtn_selectBtn});

//   final DirectionDetails tripDirectionDetails;
//   final VoidCallback backBtn_selectBtn;

//   @override
//   State<SelectCar> createState() => _SelectCarState();
// }

// class _SelectCarState extends State<SelectCar> {
//   late List<NearbyDriver> availableDrivers;
//   late DatabaseReference availableCarRef;
//   late StreamSubscription<DatabaseEvent> rideSubscription;

//   @override
//   Widget build(BuildContext context) {
//     final RouteDataProvider routeDataProvider =
//         Provider.of<RouteDataProvider>(context, listen: false);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 15, right: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: widget.backBtn_selectBtn,
//                   child: Icon(Icons.arrow_back_rounded),
//                 ),
//                 SizedBox(
//                   width: 68,
//                 ),
//                 Text(
//                   "Select A Ride",
//                   style: GoogleFonts.poppins(
//                       fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 20),
//                     // Replace with your StreamCarCategory widgets
//                     StreamCarCategory(
//                       tripDirectionDetails: widget.tripDirectionDetails,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 2),
//             decoration: BoxDecoration(
//               color: Color(0xFFF5F5F5),
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(20.0),
//                 topLeft: Radius.circular(20.0),
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xFFFEFEFE),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20.0),
//                   topLeft: Radius.circular(20.0),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       print("Payment method Clicked");
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(left: 20, right: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 26),
//                             padding: EdgeInsets.only(right: 70),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 right: BorderSide(
//                                   color: Color(0xFFDFE2E5),
//                                   width: 2.0,
//                                 ),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   "assets/svgIcons/payment_cash.svg",
//                                   width: 26,
//                                 ),
//                                 SizedBox(
//                                   width: 16,
//                                 ),
//                                 Text(
//                                   "Cash",
//                                   style: CustomFonts.poppins(
//                                     color: AppColors.mainBlack,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/svgIcons/additional_settings.svg",
//                                 width: 24,
//                               ),
//                               SizedBox(
//                                 width: 16,
//                               ),
//                               Text(
//                                 "Additional",
//                                 style: CustomFonts.poppins(
//                                   color: AppColors.mainBlack,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     height: 50,
//                     child: SubmitButton(
//                       onPressed: () {
//                         Navigator.pop(context, 'carSelected');
//                       },
//                       buttonText: 'ORDER',
//                       btnColor: AppColors.mainYellow,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   int calculateDuration() {
//     final durationInMinutes =
//         (widget.tripDirectionDetails.durationValue / 60).ceil();
//     return durationInMinutes;
//   }

//   double calculateDistance() {
//     double distanceInMeters =
//         widget.tripDirectionDetails.distanceValue.toDouble();
//     double distanceInKilometers = distanceInMeters / 1000;
//     return distanceInKilometers;
//   }
// }

// class StreamCarCategory extends StatefulWidget {
//   const StreamCarCategory({
//     super.key,
//     required this.tripDirectionDetails,
//   });

//   final DirectionDetails tripDirectionDetails;

//   @override
//   State<StreamCarCategory> createState() => _StreamCarCategoryState();
// }

// class _StreamCarCategoryState extends State<StreamCarCategory> {
//   int _selectedCardIndex = 0;
//   late CarCategoryEntity carCat;
//   late double tripFare;
//   late DatabaseReference availableCarRef;
//   late StreamSubscription<DatabaseEvent> rideSubscription;
//   List<Map<dynamic, dynamic>> availableCarList = [];
//   int eliteCars = 0;
//   int luxuryCars = 0;
//   int taxiCars = 0;
//   int flashCars = 0;
//   int comfortCars = 0;
//   int extraCars = 0;
//   int pragyaCars = 0;
//   int motorCars = 0;
//   int availableCars = 0;

//   ///////Car Catrgory List/////////
//   List<Map<dynamic, dynamic>> eliteCarList = [];
//   List<Map<dynamic, dynamic>> nearbyEliteCarList = [];

//   void _handleCardTap(int cardIndex, CarCategoryEntity carCat,
//       RouteDataProvider routeDataProvider) {
//     setState(() {
//       _selectedCardIndex = cardIndex;
//       tripFare = calculateFare(carCat);

//       routeDataProvider.updateCarAndPrice(carCat);
//       routeDataProvider.updateTripFare(tripFare);

//       print(carCat.categoryName);
//       print(tripFare);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final db = Provider.of<Database>(context, listen: false);
//     final routeDataProvider =
//         Provider.of<RouteDataProvider>(context, listen: false);
//     availableCarRef = FirebaseDatabase.instance.ref().child('availableDrivers');
//     int distanceAway = generateRandomNumber();
//     return StreamBuilder<List<CarCategoryEntity>>(
//         stream: db.getCarCategory(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final carCategoryData = snapshot.data;

//             // Now, rideList contains the data from the "rideRequest" node as a list
//             print('Data as a list: $availableCarList');
//             // print(
//             //     'Data as a sorted a list: ${availableCarList.where((element) {
//             //   return element['carType'] == 'Elite';
//             // })}');

//             // eliteCarList = availableCarList.where((element) {
//             //   return element['carType'] == 'Elite';
//             // }).toList();
//             // double maxDistanceKm = 5.0; // Maximum distance in kilometers
//             // // Filter drivers based on distance and availability
//             // nearbyEliteCarList = eliteCarList.where((driver) {
//             //   double distanceInMeters = Geolocator.distanceBetween(
//             //     routeDataProvider.pickUpLocation.latitude,
//             //     routeDataProvider.pickUpLocation.longitude,
//             //     driver['l'][0],
//             //     driver['l'][1],
//             //   );

//             //   double distanceInKm = distanceInMeters / 1000;
//             //   return distanceInKm <= maxDistanceKm;
//             // }).toList();

//             // print("Nearby Elite Drivers: $nearbyEliteCarList");

//             // nearbyEliteCarList.sort((a, b) {
//             //   double distanceA = Geolocator.distanceBetween(
//             //     routeDataProvider.pickUpLocation.latitude,
//             //     routeDataProvider.pickUpLocation.longitude,
//             //     a['l'][0],
//             //     a['l'][1],
//             //   );

//             //   double distanceB = Geolocator.distanceBetween(
//             //     routeDataProvider.pickUpLocation.latitude,
//             //     routeDataProvider.pickUpLocation.longitude,
//             //     b['l'][0],
//             //     b['l'][1],
//             //   );

//             //   return distanceA.compareTo(distanceB);
//             // });

//             // if (nearbyEliteCarList.isNotEmpty) {
//             //   // The first driver in the list is the closest one
//             //   dynamic closestDriver = nearbyEliteCarList.first;

//             //   // Calculate estimated time in minutes
//             //   double averageSpeedKph = 60.0; // Average driving speed in km/h
//             //   double distanceInKm = Geolocator.distanceBetween(
//             //         routeDataProvider.pickUpLocation.latitude,
//             //         routeDataProvider.pickUpLocation.longitude,
//             //         closestDriver['l'][0],
//             //         closestDriver['l'][1],
//             //       ) /
//             //       1000;
//             //   int estimatedTimeMinutes =
//             //       (distanceInKm / averageSpeedKph * 60).round();

//             //   print('Closest Driver: ${closestDriver['carType']}');
//             //   print('Estimated Time to User: $distanceInKm minutes');
//             //   print(
//             //       'Estimated Time to User: ${closestDriver['l'][0]} minutes');
//             // } else {
//             //   print('No nearby available drivers.');
//             // }

//             List<CarCategoryEntity> modifiedCarCategoryData =
//                 carCategoryData!.map(
//               (carCategoryEntity) {
//                 if (carCategoryEntity.categoryName == 'Elite') {
//                   //availableCars = eliteCars;

//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: eliteCars,
//                     distanceAway: distanceAway,
//                   );
//                 } else if (carCategoryEntity.categoryName == 'Luxury') {
//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: luxuryCars,
//                     distanceAway: 7,
//                   );
//                 } else if (carCategoryEntity.categoryName == 'Comfort') {
//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: comfortCars,
//                     distanceAway: 7,
//                   );
//                 } else if (carCategoryEntity.categoryName == 'Flash') {
//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: flashCars,
//                     distanceAway: 7,
//                   );
//                 } else if (carCategoryEntity.categoryName == 'Orbit Taxi') {
//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: extraCars,
//                     distanceAway: 7,
//                   );
//                 } else if (carCategoryEntity.categoryName == 'Orbit Taxi') {
//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: extraCars,
//                     distanceAway: 7,
//                   );
//                 } else if (carCategoryEntity.categoryName == 'Pragya') {
//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: pragyaCars,
//                     distanceAway: 7,
//                   );
//                 } else if (carCategoryEntity.categoryName == 'Motor') {
//                   return CarCategoryEntity(
//                     categoryName: carCategoryEntity.categoryName,
//                     description: carCategoryEntity.capacity,
//                     baseFare: carCategoryEntity.baseFare,
//                     perKilometerRate: carCategoryEntity.perKilometerRate,
//                     perMinuteRate: carCategoryEntity.perMinuteRate,
//                     capacity: carCategoryEntity.capacity,
//                     imageURL: carCategoryEntity.imageURL,
//                     availability: carCategoryEntity.availability,
//                     best_save: carCategoryEntity.best_save,
//                     availableCars: motorCars,
//                     distanceAway: 7,
//                   );
//                 }

//                 return CarCategoryEntity(
//                   categoryName: carCategoryEntity.categoryName,
//                   description: carCategoryEntity.capacity,
//                   baseFare: carCategoryEntity.baseFare,
//                   perKilometerRate: carCategoryEntity.perKilometerRate,
//                   perMinuteRate: carCategoryEntity.perMinuteRate,
//                   capacity: carCategoryEntity.capacity,
//                   imageURL: carCategoryEntity.imageURL,
//                   availability: carCategoryEntity.availability,
//                   best_save: carCategoryEntity.best_save,
//                   availableCars: availableCars,
//                   distanceAway: 0,
//                 );
//               },
//             ).toList();

//             print("Modified Elite Cars $modifiedCarCategoryData ");

//             return Column(
//                 children:
//                     List.generate(modifiedCarCategoryData.length, (index) {
//               final carCat = modifiedCarCategoryData[index];
//               return CarCategoryCard(
//                 carCategoryEntity: carCat,
//                 tripFare: calculateFare(carCat),
//                 isSelected: _selectedCardIndex == index,
//                 onTap: () => _handleCardTap(index, carCat, routeDataProvider),
//               );
//             }));
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Container(
//                 child: Text("Error While ${snapshot.error}"),
//               ),
//             );
//           }

//           return Column(
//             children: [
//               ShimmerCard(),
//               ShimmerCard(),
//               ShimmerCard(),
//               ShimmerCard(),
//               ShimmerCard(),
//               ShimmerCard(),
//               ShimmerCard(),
//               ShimmerCard(),
//               //Center(child: CircularProgressIndicator()),
//             ],
//           );
//         });
//   }

//   int generateRandomNumber() {
//     // Generate a random number between 1 and 10
//     Random random = Random();
//     int randomNumber = random.nextInt(10) + 1;
//     return randomNumber;
//   }

//   double calculateFare(
//     CarCategoryEntity carCategory,
//   ) {
//     final rideDurationMinutes =
//         (widget.tripDirectionDetails.durationValue / 60).ceil();

//     double distanceInMeters =
//         widget.tripDirectionDetails.distanceValue.toDouble();
//     // Convert the distance from meters to kilometers (1 km = 1000 meters)
//     double rideDistanceKilometers = distanceInMeters / 1000;

//     // Calculate fare based on base fare, per-minute rate, and per-kilometer rate
//     double fare = carCategory.baseFare +
//         (rideDurationMinutes * carCategory.perMinuteRate) +
//         (rideDistanceKilometers * carCategory.perKilometerRate);

//     return fare;
//   }
// }

// class ShimmerCard extends StatelessWidget {
//   const ShimmerCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CircleShimmer(
//                 size: 50,
//               ),
//               SizedBox(
//                 width: 12,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Shimmer(
//                     height: 20,
//                     width: 80,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Shimmer(
//                     height: 10,
//                     width: 180,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Shimmer(
//             height: 20,
//             width: 50,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomRadioButton extends StatefulWidget {
//   final bool isSelected;
//   final Function(bool) onSelect;

//   CustomRadioButton({required this.isSelected, required this.onSelect});

//   @override
//   _CustomRadioButtonState createState() => _CustomRadioButtonState();
// }

// class _CustomRadioButtonState extends State<CustomRadioButton> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         widget.onSelect(!widget.isSelected);
//       },
//       child: Container(
//         width: 22.0,
//         height: 22.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color:
//                 widget.isSelected ? AppColors.mainYellow : AppColors.mainYellow,
//             width: 2.5,
//           ),
//           color: widget.isSelected ? AppColors.mainYellow : Colors.transparent,
//         ),
//         child: widget.isSelected
//             ? Icon(
//                 Icons.check,
//                 size: 16.0,
//                 color: Colors.white,
//               )
//             : null,
//       ),
//     );
//   }
// }

// class CarCategoryCard extends StatelessWidget {
//   const CarCategoryCard({
//     super.key,
//     required this.carCategoryEntity,
//     required this.tripFare,
//     required this.isSelected,
//     required this.onTap,
//   });
//   final CarCategoryEntity carCategoryEntity;
//   final double tripFare;
//   final bool isSelected;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             padding: isSelected
//                 ? EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 9)
//                 : EdgeInsets.only(top: 9, bottom: 9),
//             margin: isSelected ? null : EdgeInsets.only(left: 10, right: 10),
//             decoration: isSelected
//                 ? BoxDecoration(
//                     color: Color(0xFFFFFCF2),
//                     border: Border.all(
//                       color: AppColors.mainYellow, // Border color
//                       width: 1.0, // Border width
//                     ),
//                     borderRadius: BorderRadius.circular(10.0), // Border radius
//                   )
//                 : BoxDecoration(
//                     color: Color(0xFFFFFFFF),
//                     border: Border(
//                       bottom: BorderSide(
//                         color: Color(0xFFEEEEEE), // Color of the border
//                         width: 1.0, // Thickness of the border
//                       ),
//                     ),
//                     // border: Border.all(
//                     //   color: AppColors.mainYellow, // Border color
//                     //   width: 1.0, // Border width
//                     // ),
//                     // borderRadius: BorderRadius.circular(10.0), // Border radius
//                   ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     // Image.asset(
//                     //   // "assets/icons/yellow_car_export.png",
//                     //   "assets/icons/black_car_icon.png",
//                     //   width: 72,
//                     // )

//                     Image.network(carCategoryEntity.imageURL,
//                         width:
//                             //  carCategoryEntity.categoryName == 'Pragya' ? 72 : 72,
//                             72),
//                     SizedBox(
//                       width: 12,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           carCategoryEntity.categoryName,
//                           style: CustomFonts.poppins(
//                             color: carCategoryEntity.availableCars == 0
//                                 ? AppColors.blurredSubTitleTextColor
//                                 : AppColors.mainBlack,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                                 carCategoryEntity.availableCars == 0
//                                     ? "Busy"
//                                     : "${carCategoryEntity.distanceAway} min",
//                                 style: CustomFonts.poppins(
//                                   fontSize: 14,
//                                   color: carCategoryEntity.availableCars == 0
//                                       ? AppColors.blurredSubTitleTextColor
//                                       : Color(0xFF747682),
//                                   //fontWeight: FontWeight.w600,
//                                 )),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   "assets/svgIcons/profile_icon.svg",
//                                   width: 10,
//                                   color: carCategoryEntity.availableCars == 0
//                                       ? AppColors.blurredSubTitleTextColor
//                                       : null,
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text("${carCategoryEntity.capacity}",
//                                     style: CustomFonts.poppins(
//                                       fontSize: 14,
//                                       color: carCategoryEntity.availableCars ==
//                                               0
//                                           ? AppColors.blurredSubTitleTextColor
//                                           : Color(0xFF747682),
//                                     )),
//                               ],
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             if (carCategoryEntity.best_save == true)
//                               Text(
//                                 "Best save",
//                                 style: CustomFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.mainYellow,
//                                 ),
//                               ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Text(
//                   "GHS ${tripFare.round()}",
//                   style: CustomFonts.poppins(
//                     color: carCategoryEntity.availableCars == 0
//                         ? AppColors.blurredTitleTextColor
//                         : AppColors.mainBlack,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
