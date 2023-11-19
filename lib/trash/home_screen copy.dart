// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:orbit/components/maptools/orbit_mapstyle.dart';
// import 'package:orbit/models/entities/user_entity.dart';
// import 'package:orbit/screens/home/panelwidget.dart';
// import 'package:orbit/service/providers/auth_service.dart';
// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import '../../components/home/home_address_card.dart';
// import '../../service/streams/stream_provider.dart';
// import '../menu2/menu.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   late GoogleMapController mapcontroller;

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(6.6900805, -1.6861468),
//     zoom: 14.4746,
//   );

//   Position? currentPosition;
//   bool nearbyDriversKeysLoaded = false;
//   List<LatLng> polylineCoordinates = [];
//   Set<Polyline> _polylines = {};
//   Set<Marker> _Markers = {};

// //bools
//   bool showMenuButton = true;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final db = Provider.of<Database>(context, listen: false);
//     final AuthService auth = context.read<AuthService>();
//     print("UID: ${auth.getCurrentUser()!.uid}");
//     print("Printing Home");

//     return StreamBuilder<UserEntity>(
//         stream: db.getUserData(auth.getCurrentUser()!.uid),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final userData = snapshot.data;

//             print(userData!.full_name);

//             if (userData.blocked == true) {
//               return Text('You are Blocked');
//             } else if (userData.permanently_blocked == true) {
//               return const Text('You are Permanently Blocked');
//             } else if (userData.blocked == true && userData.blocked == true) {
//               return const Text('You are Permanently Blocked');
//             } else {
//               return Scaffold(
//                 body: Stack(
//                   children: [
//                     GoogleMap(
//                       //padding: EdgeInsets.only(bottom: 290),
//                       // padding: EdgeInsets.only(bottom: 160),
//                       mapType: MapType.normal,
//                       initialCameraPosition: _kGooglePlex,
//                       //myLocationEnabled: true,
//                       zoomControlsEnabled: false,
//                       onMapCreated: (GoogleMapController controller) {
//                         _controller.complete(controller);
//                         controller.setMapStyle(orbitMapStyle);
//                       },
//                       // myLocationEnabled: true,
//                       markers: _Markers,
//                       polylines: _polylines,
//                       //myLocationButtonEnabled: true,
//                     ),
//                     SlidingUpPanel(
//                       maxHeight: 300,
//                       // minHeight: 280,
//                       minHeight: 90,
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(18.0),
//                         topLeft: Radius.circular(18.0),
//                       ),
//                       parallaxEnabled: true,
//                       parallaxOffset: .5,
//                       panelSnapping: true,
//                       backdropEnabled: true,
//                       boxShadow: const [
//                         BoxShadow(
//                           spreadRadius: 6,
//                           blurRadius: 4.0,
//                           color: Color.fromRGBO(0, 0, 0, 0.05),
//                         )
//                       ],
//                       body: Container(),
//                       panelBuilder: (controller) => PanelWidget(
//                         controller: controller,
//                         onPressed: () async {},
//                       ),
//                     ),
//                     Positioned(
//                       //right: 10,
//                       //bottom: 160,
//                       bottom: 110,
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         height: 36,
//                         // color: Colors.red,

//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             // HomeAddressCard(
//                             //   addressName: 'Home',
//                             // ),
//                             // HomeAddressCard(
//                             //   addressName: 'Work',
//                             // ),
//                             // HomeAddressCard(
//                             //   addressName: 'Market',
//                             // ),

//                             // HomeAddressCard(
//                             //   addressName: 'Church',
//                             // ),
//                             // Add more items as needed
//                           ],
//                         ),
//                         // child: SingleChildScrollView(
//                         //   scrollDirection: Axis.horizontal,
//                         //   physics: AlwaysScrollableScrollPhysics(),
//                         //   child: Row(
//                         //     children: [
//                         //       HomeAddressCard(),
//                         //       Container(
//                         //         margin: EdgeInsets.only(left: 16),
//                         //         padding: EdgeInsets.only(
//                         //             left: 15, right: 15, top: 6, bottom: 6),
//                         //         decoration: BoxDecoration(
//                         //             color: Colors.white,
//                         //             borderRadius: BorderRadius.only(
//                         //                 topLeft: Radius.circular(20),
//                         //                 topRight: Radius.circular(20),
//                         //                 bottomLeft: Radius.circular(20),
//                         //                 bottomRight: Radius.circular(20)),
//                         //             boxShadow: [
//                         //               BoxShadow(
//                         //                 color: Color.fromRGBO(0, 0, 0, 0.09),
//                         //                 offset: Offset(0, 3),
//                         //                 blurRadius: 8,
//                         //               )
//                         //             ]),
//                         //         child: Row(
//                         //           children: [
//                         //             SvgPicture.asset(
//                         //               "assets/svgIcons/Work-address.svg",
//                         //               width: 16,
//                         //             ),
//                         //             SizedBox(
//                         //               width: 10,
//                         //             ),
//                         //             Text(
//                         //               "Work",
//                         //               style: CustomFonts.poppins(
//                         //                 fontSize: 16,
//                         //                 fontWeight: FontWeight.w400,
//                         //                 color: AppColors.mainBlack,
//                         //               ),
//                         //             )
//                         //           ],
//                         //         ),
//                         //       ),
//                         //       Container(
//                         //         margin: EdgeInsets.only(left: 16),
//                         //         padding: EdgeInsets.only(
//                         //             left: 15, right: 15, top: 6, bottom: 6),
//                         //         decoration: BoxDecoration(
//                         //             color: Colors.white,
//                         //             borderRadius: BorderRadius.only(
//                         //                 topLeft: Radius.circular(20),
//                         //                 topRight: Radius.circular(20),
//                         //                 bottomLeft: Radius.circular(20),
//                         //                 bottomRight: Radius.circular(20)),
//                         //             boxShadow: [
//                         //               BoxShadow(
//                         //                 color: Color.fromRGBO(0, 0, 0, 0.09),
//                         //                 offset: Offset(0, 3),
//                         //                 blurRadius: 8,
//                         //               )
//                         //             ]),
//                         //         child: Row(
//                         //           children: [
//                         //             SvgPicture.asset(
//                         //               "assets/svgIcons/Work-address.svg",
//                         //               width: 14,
//                         //               // color: AppColors.mainYellow,
//                         //             ),
//                         //             SizedBox(
//                         //               width: 10,
//                         //             ),
//                         //             Text(
//                         //               "Kejetia",
//                         //               style: CustomFonts.poppins(
//                         //                 fontSize: 16,
//                         //                 fontWeight: FontWeight.w400,
//                         //                 color: AppColors.mainBlack,
//                         //               ),
//                         //             )
//                         //           ],
//                         //         ),
//                         //       ),
//                         //       Container(
//                         //         margin: EdgeInsets.only(left: 16),
//                         //         padding: EdgeInsets.only(
//                         //             left: 15, right: 15, top: 6, bottom: 6),
//                         //         decoration: BoxDecoration(
//                         //             color: Colors.white,
//                         //             borderRadius: BorderRadius.only(
//                         //                 topLeft: Radius.circular(20),
//                         //                 topRight: Radius.circular(20),
//                         //                 bottomLeft: Radius.circular(20),
//                         //                 bottomRight: Radius.circular(20)),
//                         //             boxShadow: [
//                         //               BoxShadow(
//                         //                 color: Color.fromRGBO(0, 0, 0, 0.09),
//                         //                 offset: Offset(0, 3),
//                         //                 blurRadius: 8,
//                         //               )
//                         //             ]),
//                         //         child: Row(
//                         //           children: [
//                         //             SvgPicture.asset(
//                         //               "assets/svgIcons/Work-address.svg",
//                         //               width: 14,
//                         //               // color: AppColors.mainYellow,
//                         //             ),
//                         //             SizedBox(
//                         //               width: 10,
//                         //             ),
//                         //             Text(
//                         //               "Kejetia",
//                         //               style: CustomFonts.poppins(
//                         //                 fontSize: 16,
//                         //                 fontWeight: FontWeight.w400,
//                         //                 color: AppColors.mainBlack,
//                         //               ),
//                         //             )
//                         //           ],
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 10,
//                       bottom: 170,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 16),
//                         padding: EdgeInsets.only(
//                             left: 14, right: 14, top: 10, bottom: 10),
//                         height: 47,
//                         width: 47,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                               bottomLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               offset: Offset(0, 3),
//                               blurRadius: 8,
//                             )
//                           ],
//                         ),
//                         child: SvgPicture.asset(
//                           "assets/svgIcons/location.svg",
//                           width: 4,
//                         ),
//                       ),
//                     ),
//                     if (showMenuButton == true) ...[
//                       GestureDetector(
//                         onTap: () {
//                           // showModalBottomSheet(
//                           //     isScrollControlled: true,
//                           //     backgroundColor: Colors.transparent,
//                           //     // shape: RoundedRectangleBorder(
//                           //     //     borderRadius: BorderRadius.vertical(
//                           //     //         top: Radius.circular(20))),
//                           //     context: context,
//                           //     builder: (context) => showMenuSheet());
//                           // Navigator.pushNamed(
//                           //   context,
//                           //   '/menu',
//                           // );
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) => Menu(
//                           //             userEntity: userData,
//                           //           )),
//                           // );
//                         },
//                         child: SafeArea(
//                           child: Container(
//                             margin: EdgeInsets.only(left: 16),
//                             padding: EdgeInsets.all(10),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     offset: Offset(0, 3),
//                                     blurRadius: 8,
//                                   )
//                                 ]),
//                             child: SvgPicture.asset(
//                               "assets/svgIcons/menu.svg",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               );
//             }
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Container(
//                 child: Text("Error While ${snapshot.error}"),
//               ),
//             );
//           }

//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         });
//   }

//   // Widget showMenuSheet() => DraggableScrollableSheet(
//   //       //maxChildSize: 0.95,
//   //       initialChildSize: 0.95,
//   //       builder: (BuildContext ctxt, context) => MenuWidget(
//   //         ctxt: ctxt,
//   //       ),
//   //     );

//   Widget buildItem(String text) {
//     return Container(
//       margin: EdgeInsets.only(left: 16),
//       padding: EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromRGBO(0, 0, 0, 0.09),
//               offset: Offset(0, 3),
//               blurRadius: 8,
//             )
//           ]),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             "assets/svgIcons/Home-address.svg",
//             width: 14,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Text(
//             text,
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
