
    // return StreamBuilder<UserEntity>(
    //     stream: db.getUserData(auth.getCurrentUser()!.uid),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         final userData = snapshot.data;
    //         print(userData!.full_name);

    //         if (userData.blocked == true) {
    //           return const Text('You are Blocked');
    //         } else if (userData.permanently_blocked == true) {
    //           return const Text('You are Permanently Blocked');
    //         } else if (userData.blocked == true && userData.blocked == true) {
    //           return const Text('You are Permanently Blocked');
    //         } else {
    //           createMarkers(appScale);
    //           return Scaffold(
    //             body: Stack(
    //               children: [
    //                 currentPosition == null
    //                     ? const Text("Loading...")
    //                     : GoogleMap(
    //                         //padding: EdgeInsets.only(bottom: 290),
    //                         myLocationEnabled: myLocationEnabled,
    //                         myLocationButtonEnabled: false,
    //                         padding: _currentMapPadding,
    //                         mapType: MapType.normal,
    //                         initialCameraPosition: _kGooglePlex,
    //                         //myLocationEnabled: true,
    //                         zoomControlsEnabled: false,
    //                         onMapCreated: (GoogleMapController controller) {
    //                           _googleController.complete(controller);
    //                           controller.setMapStyle(map_final_style);
    //                         },
    //                         // myLocationEnabled: true,
    //                         markers: markers,
    //                         polylines: _polylines,
    //                         compassEnabled: false,
    //                         //myLocationButtonEnabled: true,
    //                         onCameraMove: _onCameraMove,
    //                       ),
    //                 Visibility(
    //                   visible: whereAreUGoing,
    //                   child: SlidingUpPanel(
    //                     maxHeight: 300,
    //                     //minHeight: 280,
    //                     minHeight: 90,
    //                     borderRadius: const BorderRadius.only(
    //                       topRight: Radius.circular(18.0),
    //                       topLeft: Radius.circular(18.0),
    //                     ),
    //                     parallaxEnabled: true,
    //                     parallaxOffset: .5,
    //                     panelSnapping: true,
    //                     backdropEnabled: true,
    //                     controller: _panelController,
    //                     boxShadow: const [
    //                       BoxShadow(
    //                         spreadRadius: 6,
    //                         blurRadius: 4.0,
    //                         color: Color.fromRGBO(0, 0, 0, 0.05),
    //                       )
    //                     ],
    //                     body: Container(),
    //                     panelBuilder: (controller) => PanelWidget(
    //                       controller: controller,
    //                       onPressed: () async {
    //                         var response = await Navigator.of(context).push(
    //                           SlideUpRoute(
    //                             builder: (_) => SearchPage(
    //                               backToSeach: false,
    //                             ),
    //                           ),
    //                         );

    //                         if (response == 'getDirection') {
    //                           showRideConfirmSheet(appScale, false);
    //                         }
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //                 Visibility(
    //                   visible: showConfirmOrderBottomSheetWidget,
    //                   child: ConfirmOrderBottomSheet(
    //                     destinationOnPress: () async {
    //                       var response = await Navigator.of(context).push(
    //                         SlideUpRoute(
    //                           builder: (_) => const SearchPage(
    //                             backToSeach: true,
    //                             editDestination: true,
    //                           ),
    //                         ),
    //                       );

    //                       if (response == 'getDirection') {
    //                         showRideConfirmSheet(appScale, false);
    //                       }
    //                     },
    //                     pickupOnPress: () async {
    //                       var response = await Navigator.of(context).push(
    //                         SlideUpRoute(
    //                           builder: (_) => const SearchPage(
    //                             backToSeach: true,
    //                             editPickUp: true,
    //                           ),
    //                         ),
    //                       );

    //                       if (response == 'getDirection') {
    //                         showRideConfirmSheet(appScale, false);
    //                       }
    //                     },
    //                     submitBtn: () async {
    //                       back2SeacrhVisibility = false;

    //                       var response = await Navigator.of(context).push(
    //                         SlideUpRoute(
    //                           builder: (_) => SelectCar(
    //                             tripDirectionDetails: tripDirectionDetails,
    //                             backBtn_selectBtn: () {
    //                               Navigator.pop(context);
    //                             },
    //                           ),
    //                         ),
    //                       );

    //                       if (response == 'carSelected') {
    //                         availableDrivers = NearbyDriverBot.nearbyDriverList;

    //                         createRideRequest();
    //                         setState(() {
    //                           appState = 'REQUESTING';
    //                         });

    //                         animateSearching();

    //                         callRideSearcher();
    //                         findDriver();
    //                       }
    //                     },
    //                   ),
    //                 ),
    //                 Visibility(
    //                   visible: addressVisibility,
    //                   child: Positioned(
    //                     bottom: 110,
    //                     left: 0,
    //                     right: 0,
    //                     child: Container(
    //                       height: 36,
    //                       child: ListView(
    //                         scrollDirection: Axis.horizontal,
    //                         children: [
    //                           HomeAddressCard(
    //                             addressName: 'Home',
    //                             onPressed: () {
    //                               print("closing");
    //                               setState(() {
    //                                 whereAreUGoing = false;
    //                               });
    //                               _panelController.close();
    //                             },
    //                           ),
    //                           HomeAddressCard(
    //                             addressName: 'Work',
    //                             onPressed: () {
    //                               setState(() {
    //                                 whereAreUGoing = true;
    //                               });
    //                             },
    //                           ),
    //                           HomeAddressCard(
    //                             addressName: 'Market',
    //                             onPressed: () {},
    //                           ),
    //                           HomeAddressCard(
    //                             addressName: 'Church',
    //                             onPressed: () {},
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 if (showLocationButton)
    //                   Visibility(
    //                     visible: locBtnVisibility,
    //                     child: Positioned(
    //                       right: 10,
    //                       bottom: 170,
    //                       child: GestureDetector(
    //                         onTap: _returnToCurrentLocation,
    //                         child: Container(
    //                           margin: EdgeInsets.only(left: 16),
    //                           padding: EdgeInsets.only(
    //                               left: 14, right: 14, top: 10, bottom: 10),
    //                           height: 47,
    //                           width: 47,
    //                           decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(10),
    //                                 topRight: Radius.circular(10),
    //                                 bottomLeft: Radius.circular(10),
    //                                 bottomRight: Radius.circular(10)),
    //                             boxShadow: [
    //                               BoxShadow(
    //                                 color: Colors.black12,
    //                                 offset: Offset(0, 3),
    //                                 blurRadius: 8,
    //                               )
    //                             ],
    //                           ),
    //                           child: SvgPicture.asset(
    //                             "assets/svgIcons/location.svg",
    //                             width: 4,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 Visibility(
    //                   visible: showSearchingForDriverWidget,
    //                   child: SearchingForDriver(
    //                     cancelDriverSearch: () async {
    //                       cancelRideRequest();

    //                       var response = await Navigator.of(context).push(
    //                         SlideUpRoute(
    //                           builder: (_) => SelectCar(
    //                             tripDirectionDetails: tripDirectionDetails,
    //                             backBtn_selectBtn: () {
    //                               print("Back pressed");
    //                               showRideConfirmSheet(appScale, true);

    //                               Navigator.pop(context);
    //                             },
    //                           ),
    //                         ),
    //                       );

    //                       if (response == 'carSelected') {
    //                         availableDrivers = NearbyDriverBot.nearbyDriverList;

    //                         createRideRequest();
    //                         setState(() {
    //                           appState = 'REQUESTING';
    //                         });

    //                         animateSearching();

    //                         callRideSearcher();
    //                         findDriver();

    //                         // Navigator.of(context).push(
    //                         //   SlidePageRoute(
    //                         //     builder: (_) => SearchingForDriverScreen(),
    //                         //   ),
    //                         // );
    //                       }
    //                       print("Cancel Search");
    //                     },
    //                   ),
    //                 ),
    //                 Visibility(
    //                   visible: showDriverArrivingSheet,
    //                   child: DriverArrivingBottomSheet(
    //                     onPressed: () {},
    //                   ),
    //                 ),
    //                 Visibility(
    //                   visible: showDriverOntripSheet,
    //                   child: TripToDestinationBottomSheet(),
    //                 ),
    //                 Visibility(
    //                   visible: RateDriverSheetVisibility,
    //                   child: RateDriverBottomSheet(
    //                     onPressed: () {},
    //                   ),
    //                 ),
    //                 Visibility(
    //                   visible: showMenuButtonVisibility,
    //                   child: MenuButton(userData: userData),
    //                 ),
    //                 Visibility(
    //                     visible: back2SeacrhVisibility,
    //                     child: Back2SearchButton(
    //                       userData: userData,
    //                       onPressed: () async {
    //                         dismissRideConfirmSheet();
    //                         var response =
    //                             await Navigator.of(context).push(SlideUpRoute(
    //                                 builder: (_) => SearchPage(
    //                                       backToSeach: true,
    //                                     )));

    //                         if (response == 'getDirection') {
    //                           showRideConfirmSheet(appScale, false);
    //                         }
    //                       },
    //                     )),
    //                 // Visibility(
    //                 //     visible: back2SelectRideVisibility,
    //                 //     child: Back2SelectRideButton(
    //                 //       userData: userData,
    //                 //       onPressed: () async {
    //                 //         // dismissRideConfirmSheet();
    //                 //         // var response =
    //                 //         //     await Navigator.of(context).push(SlideUpRoute(
    //                 //         //         builder: (_) => SearchPage(
    //                 //         //               backToSeach: true,
    //                 //         //             )));

    //                 //         // if (response == 'getDirection') {
    //                 //         //   showRideConfirmSheet();
    //                 //         // }
    //                 //         var response = await Navigator.of(context).push(
    //                 //           SlideUpRoute(
    //                 //             builder: (_) => SelectCar(
    //                 //               tripDirectionDetails: tripDirectionDetails,
    //                 //             ),
    //                 //           ),
    //                 //         );
    //                 //       },
    //                 //     )),
    //               ],
    //             ),
    //           );
    //         }
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Container(
    //             child: Text("Error While ${snapshot.error}"),
    //           ),
    //         );
    //       }

    //       return Scaffold(
    //         body: Center(child: CircularProgressIndicator()),
    //       );
    //     });