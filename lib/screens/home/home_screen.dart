import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orbit/components/app_alerts_dialogs.dart';
import 'package:orbit/components/app_scale.dart';
import 'package:orbit/components/home/menu_button.dart';
import 'package:orbit/components/maptools/jobber.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/app_keys.dart';
import 'package:orbit/constants/ride_variable.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/entities/driver_entity.dart';
import 'package:orbit/models/trip/address.dart';
import 'package:orbit/screens/bottom_sheets/order_bottomsheet.dart';
import 'package:orbit/screens/bottom_sheets/rate_driver_bottomsheet.dart';
import 'package:orbit/screens/home/chat/driver_chat_screen.dart';
import 'package:orbit/screens/home/panelwidget.dart';
import 'package:orbit/screens/home/search/search.dart';
import 'package:orbit/screens/home/select_car.dart';
import 'package:orbit/screens/home/trip_cancellation_screen.dart';
import 'package:orbit/service/firebase_futures/future_futures.dart';
import 'package:orbit/service/map_service/map_api_service.dart';
import 'package:orbit/service/map_service/map_methods.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:orbit/service/providers/pick_location_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../components/home/back2search_button.dart';
import '../../components/home/home_address_card.dart';
import '../../models/trip/directiondetails.dart';
import '../../models/trip/nearbydriver_entity.dart';
import '../../routes.dart';
import '../../service/map_service/nearby_driver.dart';
import '../../service/providers/trip/route_provider.dart';
import '../bottom_sheets/confirm_order_bottomsheet.dart';
import '../bottom_sheets/driver_arriving_bottomsheet.dart';
import '../bottom_sheets/searching_for_driver.dart';
import '../bottom_sheets/tripto_destination_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _googleController =
      Completer<GoogleMapController>();

  late GoogleMapController mapcontroller;

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(6.6900805, -1.6861468),
    zoom: 14.4746,
  );

  //Position? currentPosition;
  bool nearbyDriversKeysLoaded = false;
  //Polyline
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  Set<Marker> markers = Set<Marker>();
  BitmapDescriptor? nearbyIcon;
  BitmapDescriptor? driverMarkerIcon;
  BitmapDescriptor? pickupIcon;
  BitmapDescriptor? pickupIconzoomed;
  BitmapDescriptor? destinationIcon;
  late DirectionDetails tripDirectionDetails;
  bool showLocationButton = false;
  late LatLng lastPosition;
  //Animations
  late AnimationController locBtnAnimaController;
  late Animation<double> locBtnScaleAnima;

  bool addressVisibility = true;
  bool locBtnVisibility = true;
  bool showMenuButtonVisibility = true;
  bool showSearchingForDriverWidget = false;
  bool showDriverArrivingSheet = false;
  bool showDriverOntripSheet = false;
  bool back2SeacrhVisibility = false;
  bool back2SelectRideVisibility = false;
  bool whereAreUGoing = true;
  bool rateDriverSheetVisibility = false;
  bool showOrderBottomSheet = false;

///////////////////////////////////////////////
////////////////BOOL WIDGETS//////////////////
/////////////////////////////////////////////

  bool showConfirmOrderBottomSheetWidget = false;

  EdgeInsets _currentMapPadding = EdgeInsets.only(bottom: 150);
  PanelController _panelController = PanelController();

  //AppState
  String appState = 'NORMAL';
  late List<NearbyDriver> availableDrivers;
  late List<NearbyDriver> availableTaxiDrivers;
  late List<NearbyDriver> availableFlashDrivers;
  late List<NearbyDriver> availableSuperDrivers;
  late List<NearbyDriver> availableLuxuryDrivers;
  late List<NearbyDriver> availableKekeDrivers;
  late List<NearbyDriver> availableOkadaDrivers;
  late List<NearbyDriver> availableForRideDrivers;
  late DatabaseReference rideRef;
  late StreamSubscription<DatabaseEvent> rideSubscription;

//Zooms
  double currentZoom = 16.5; // Initial zoom level

// Create a timer that fires every 2 seconds and increments the zoom level.
  late Timer zoomTimer;
  bool myLocationEnabled = true;
//bools
  LocationHive? locationHiveData;

  final MapMethods mapMethods = MapMethods();
  // late UserEntity userData;
  SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.light;

  bool _isLoading = false;
  bool _isInit = true;

  @override
  void initState() {
    // final appDataProvider = Provider.of<AppDataProvider>(context);
    // setState(() {
    //   currentPosition = appDataProvider.getCurrentLocation;
    // });
    // print("Home current Location ${currentPosition}");

    // setState(() {
    //   locationHiveData = boxLocationHive.get("key_location") as LocationHive;
    //   _kGooglePlex = CameraPosition(
    //     target: LatLng(locationHiveData!.latitude, locationHiveData!.longitude),
    //     zoom: 14.4746,
    //   );
    // });

    initLocation();
    print("Location Hive Object2 ${locationHiveData!.latitude}");
    setupInitialUI();
    //fetchUserData(context);
    //setupPositionLocator(context);

    locBtnAnimaController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Adjust the duration as needed
    );

    locBtnScaleAnima = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: locBtnAnimaController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<PickLocationProvider>(context).getData().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        // Handle errors here, e.g., show an error message
        print("Error fetching data: $error");
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  // void refreshUserPickup(context) {
  //   const duration = Duration(minutes: 2);

  //   Timer.periodic(duration, (Timer timer) {
  //     // This code will be executed every two minutes
  //     //MapAPIService.searchCoordinateAddress2(context);
  //     Provider.of<PickLocationProvider>(context).getData();
  //     // setPickUpAddress(context);
  //   });
  // }

  Future<void> setPickUpAddress(context) async {
    final pickUpData =
        boxPickUpAddressHive.get("key_pickupAddress") as PickUpAddressHive;

    final userPickUpAddress = Address(
        placeId: pickUpData.placeId!,
        latitude: pickUpData.latitude!,
        longitude: pickUpData.longitude!,
        placeName: pickUpData.placeName!,
        placeFormattedAddress: pickUpData.placeFormattedAddress!);

    Provider.of<RouteDataProvider>(context, listen: false)
        .updatePickupAddress(userPickUpAddress);
  }

  Future<void> initLocation() async {
    setState(() {
      locationHiveData = boxLocationHive.get("key_location") as LocationHive;
      _kGooglePlex = CameraPosition(
        target: LatLng(locationHiveData!.latitude, locationHiveData!.longitude),
        zoom: 14.4746,
      );
    });
    LatLng pos =
        LatLng(locationHiveData!.latitude, locationHiveData!.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 16);

    //await MapAPIService.searchCoordinateAddress2();

    final GoogleMapController gmcontroller = await _googleController.future;
    gmcontroller.animateCamera(CameraUpdate.newCameraPosition(cp));

    startGeofireListener();
  }

///////////////////////////////////////////////////////
/////////////////////GET USER DATA////////////////////
/////////////////////////////////////////////////////

  Future<void> fetchUserData(BuildContext context) async {
    final db = Provider.of<FirebaseFutures>(context, listen: false);
    AuthService auth = AuthService();
    String? uid = auth.getCurrentUser()!.uid;
    //final AuthService auth = context.read<AuthService>();
    // SharePreferencesHelper sharedPreferencesHelper = SharePreferencesHelper();

    try {
      await db.getUserDataToHive(uid);

      //sharedPreferencesHelper.setUserDetail(userData);
      // print("User Data: ${userData.deleted_account}");
      // print("User Data: ${userData.full_name}");
      // print("User Data: ${userData.email}");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _returnToCurrentLocation() async {
    if (lastPosition != null) {
      LatLng pos =
          //LatLng(currentPosition!.latitude, currentPosition!.longitude);
          LatLng(locationHiveData!.latitude, locationHiveData!.longitude);
      CameraPosition cp = CameraPosition(target: pos, zoom: 16);
      final GoogleMapController gmcontroller = await _googleController.future;

      gmcontroller.animateCamera((CameraUpdate.newCameraPosition(cp)));
    }
  }

  void _onCameraMove(CameraPosition position) {
    if (locationHiveData != null) {
      double distance = Geolocator.distanceBetween(
          locationHiveData!.latitude,
          locationHiveData!.longitude,
          position.target.latitude,
          position.target.longitude);

      // You can adjust the distance threshold as needed
      if (distance > 100) {
        // Show the button when the user pans away from their current location
        setState(() {
          showLocationButton = true;
          lastPosition = position.target;
        });
      } else {
        // Remove the button when the user pans back to their current location
        setState(() {
          showLocationButton = false;
        });
      }
    }
  }

  Future<void> setupInitialUI() async {
    _currentStyle = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.mainWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final db = Provider.of<Database>(context, listen: false);

    // RouteDataProvider routeDataProvider =
    //     Provider.of<RouteDataProvider>(context, listen: false);
    // final address = Address(
    //     latitude: pickUpData.latitude,
    //     longitude: pickUpData.longitude,
    //     placeFormattedAddress: pickUpData.placeFormattedAddress,
    //     placeName: pickUpData.placeName,
    //     placeId: pickUpData.placeId);
    // routeDataProvider.updatePickupAddress(address);

    AppScale appScale = AppScale(context);
    createMarkers(appScale);

    //final userData = user as UserEntity;
    // print("UserHiveHAHAHA ${userData.full_name}");

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _currentStyle,
      child: Scaffold(
        body: Stack(
          children: [
            locationHiveData == null
                ? const Text("Loading...")
                : GoogleMap(
                    //padding: EdgeInsets.only(bottom: 290),
                    myLocationEnabled: myLocationEnabled,
                    myLocationButtonEnabled: false,
                    padding: _currentMapPadding,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    //myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _googleController.complete(controller);
                      //controller.setMapStyle(upwork_map_jobber);
                      //setPickUpAddress(context);
                      // MapAPIService.searchCoordinateAddress2(context);
                      /// refreshUserPickup(context);
                      print("Map created ");
                    },
                    //myLocationEnabled: true,
                    markers: markers,
                    polylines: _polylines,
                    compassEnabled: false,
                    //myLocationButtonEnabled: true,
                    onCameraMove: _onCameraMove,
                  ),
            Visibility(
              visible: whereAreUGoing,
              child: SlidingUpPanel(
                maxHeight: 90,
                //minHeight: 280,
                minHeight: 90,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18.0),
                  topLeft: Radius.circular(18.0),
                ),
                parallaxEnabled: true,
                parallaxOffset: .5,
                panelSnapping: true,
                backdropEnabled: false,
                controller: _panelController,
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 6,
                    blurRadius: 4.0,
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                  )
                ],
                body: Container(),
                panelBuilder: (controller) => PanelWidget(
                  controller: controller,
                  onPressed: () async {
                    var response = await Navigator.of(context).push(
                      SlideUpRoute(
                        builder: (_) => const SearchPage(
                          backToSeach: false,
                        ),
                      ),
                    );

                    if (response == 'getDirection') {
                      showRideConfirmSheet(appScale, false);
                    }
                  },
                ),
              ),
            ),
            Visibility(
              visible: showConfirmOrderBottomSheetWidget,
              child: ConfirmOrderBottomSheet(
                destinationOnPress: () async {
                  var response = await Navigator.of(context).push(
                    SlideUpRoute(
                      builder: (_) => const SearchPage(
                        backToSeach: true,
                        editDestination: true,
                      ),
                    ),
                  );

                  if (response == 'getDirection') {
                    showRideConfirmSheet(appScale, false);
                  }
                },
                pickupOnPress: () async {
                  var response = await Navigator.of(context).push(
                    SlideUpRoute(
                      builder: (_) => const SearchPage(
                        backToSeach: true,
                        editPickUp: true,
                      ),
                    ),
                  );

                  if (response == 'getDirection') {
                    showRideConfirmSheet(appScale, false);
                  }
                },
                submitBtn: () async {
                  back2SeacrhVisibility = false;

                  var response = await Navigator.of(context).push(
                    SlideUpRoute(
                      builder: (_) => SelectCar(
                        tripDirectionDetails: tripDirectionDetails,
                        backBtn_selectBtn: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );

                  if (response == 'carSelected') {
                    availableDrivers = NearbyDriverBot.nearbyDriverList;

                    createRideRequest(context);

                    //
                    setState(() {
                      appState = 'REQUESTING';
                    });

                    animateSearching();

                    callRideSearcher();
                    findDriver();
                  }
                },
              ),
            ),
            Visibility(
              visible: showOrderBottomSheet,
              child: OrderBottomSheet(
                onOrderPressed: () {
                  availableDrivers = NearbyDriverBot.nearbyDriverList;
                  setState(() {
                    appState = 'REQUESTING';
                  });
                  createRideRequest(context);
                  callRideSearcher();

                  animateSearching();
                  findDriver();

                  //print("It has been pressed");
                },
              ),
            ),
            Visibility(
              visible: addressVisibility,
              child: Positioned(
                bottom: 110,
                left: 0,
                right: 0,
                child: Container(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      HomeAddressCard(
                        addressName: 'Home',
                        onPressed: () {
                          print("closing");
                          setState(() {
                            // whereAreUGoing = false;
                          });
                        },
                      ),
                      HomeAddressCard(
                        addressName: 'Work',
                        onPressed: () {
                          setState(() {
                            // whereAreUGoing = true;
                          });
                        },
                      ),
                      HomeAddressCard(
                        addressName: 'Market',
                        onPressed: () {},
                      ),
                      HomeAddressCard(
                        addressName: 'Church',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showLocationButton)
              Visibility(
                visible: locBtnVisibility,
                child: Positioned(
                  right: 10,
                  bottom: 170,
                  child: GestureDetector(
                    onTap: _returnToCurrentLocation,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      height: 47,
                      width: 47,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        color: AppColors.mainYellow,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 3),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: SvgPicture.asset(
                        "assets/svgIcons/location.svg",
                        width: 4,
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ),
                ),
              ),
            Visibility(
              visible: showSearchingForDriverWidget,
              child: SearchingForDriver(
                cancelDriverSearch: () async {
                  cancelRideRequest();

                  // var response = await Navigator.of(context).push(
                  //   SlideUpRoute(
                  //     builder: (_) => SelectCar(
                  //       tripDirectionDetails: tripDirectionDetails,
                  //       backBtn_selectBtn: () {
                  //         // print("Back pressed");
                  //         showRideConfirmSheet(appScale, true);

                  //         Navigator.pop(context);
                  //       },
                  //     ),
                  //   ),
                  // );

                  // if (response == 'carSelected') {
                  //   availableDrivers = NearbyDriverBot.nearbyDriverList;

                  //   createRideRequest(context);
                  //   setState(() {
                  //     appState = 'REQUESTING';
                  //   });

                  //   animateSearching();

                  //   callRideSearcher();
                  //   findDriver();

                  //   // Navigator.of(context).push(
                  //   //   SlidePageRoute(
                  //   //     builder: (_) => SearchingForDriverScreen(),
                  //   //   ),
                  //   // );
                  // }
                  //print("Cancel Search");
                },
              ),
            ),
            Visibility(
              visible: showDriverArrivingSheet,
              child: DriverArrivingBottomSheet(
                showChatOnPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DriverChatScreen(
                        driverEntity: DriverEntity(
                          driverID: driverID,
                          driverName: driverName,
                          driverPhone: driverPhone,
                          driverPhotoURL: driverPhotoURL,
                          vehicleManufacturer: vehicleManufacturer,
                          vehicleModel: vehicleModel,
                          vehicleColor: vehicleColor,
                          licenseNumber: licenseNumber,
                        ),
                      ),
                    ),
                  );
                },
                openCallOnPressed: () {},
                cancelTripOnPressed: () {
                  Navigator.push(
                    context,
                    SlideUpRoute(
                      builder: (context) => TripCancellationScreen(
                        rideID: rideID,
                      ),
                    ),
                  );
                },
                driverEntity: DriverEntity(
                  driverID: driverID,
                  driverName: driverName,
                  driverPhone: driverPhone,
                  driverPhotoURL: driverPhotoURL,
                  vehicleManufacturer: vehicleManufacturer,
                  vehicleModel: vehicleModel,
                  vehicleColor: vehicleColor,
                  licenseNumber: licenseNumber,
                ),
              ),
            ),
            Visibility(
              visible: showDriverOntripSheet,
              child: TripToDestinationBottomSheet(
                driverEntity: DriverEntity(
                  driverID: driverID,
                  driverName: driverName,
                  driverPhone: driverPhone,
                  driverPhotoURL: driverPhotoURL,
                  vehicleModel: vehicleModel,
                  vehicleColor: vehicleColor,
                  licenseNumber: licenseNumber,
                  vehicleManufacturer: vehicleManufacturer,
                ),
              ),
            ),
            Visibility(
              visible: rateDriverSheetVisibility,
              child: RateDriverBottomSheet(
                submitRating: () {
                  setState(() {
                    rateDriverSheetVisibility = false;
                  });
                },
                cancelRating: () {
                  rateDriverSheetVisibility = false;
                },
              ),
            ),
            Visibility(
              visible: showMenuButtonVisibility,
              child: MenuButton(),
            ),
            Visibility(
                visible: back2SeacrhVisibility,
                child: Back2SearchButton(
                  onPressed: () async {
                    dismissRideConfirmSheet();
                    var response =
                        await Navigator.of(context).push(SlideUpRoute(
                            builder: (_) => SearchPage(
                                  backToSeach: true,
                                )));

                    if (response == 'getDirection') {
                      showRideConfirmSheet(appScale, false);
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  //void closeDriverRating() {}

  void findDriver() {
    if (availableDrivers.length == 0) {
      print("Request log: No Driver");
      //cancelRequest();
      /// resetApp();
      //noDriverFound();
      return;
    }

    print("Request log: Driver Found");
    var driver = availableDrivers[0];
    notifyDriver(driver);
    //availableDrivers.removeAt(0);

    print("Driver Key: ${driver.key}");
  }

  void notifyDriver(NearbyDriver driver) {
    // rideRef = FirebaseDatabase.instance.ref().child('rideRequest').push();

    DatabaseReference driverTripRef = FirebaseDatabase.instance
        .ref()
        .child('driverData/${driver.key}/newtrip');

    driverTripRef.set(rideRef.key);

    // print("New Trip${rideRef.key}");
    // Get and notify driver using token

    DatabaseReference tokenRef = FirebaseDatabase.instance
        .ref()
        .child('driverData/${driver.key}/fcmToken');

    DatabaseReference driverName = FirebaseDatabase.instance
        .ref()
        .child('driverData/${driver.key}/driverName');

    tokenRef.once().then((DatabaseEvent databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
        String token = databaseEvent.snapshot.value.toString();
        print("FCM Token: $token");
        driverName.once().then((DatabaseEvent databaseEvent) {
          String firstName =
              extractFirstName(databaseEvent.snapshot.value.toString());
          print("Driver Name: $firstName");

          //send notification to selected driver
          MapAPIService.sendNotification(
              token, context, rideRef.key!, firstName);
        });
      } else {
        return;
      }

      const oneSecTick = Duration(seconds: 1);

      var timer = Timer.periodic(oneSecTick, (timer) {
        // stop timer when ride request is cancelled;
        if (appState != 'REQUESTING') {
          driverTripRef.set('cancelled');
          driverTripRef.onDisconnect();
          timer.cancel();
          driverRequestTimeout = 30;
        }

        driverRequestTimeout--;

        // a value event listener for driver accepting trip request
        driverTripRef.onValue.listen((event) {
          // confirms that driver has clicked accepted for the new trip request
          if (event.snapshot.value.toString() == 'accepted') {
            driverTripRef.onDisconnect();
            timer.cancel();
            driverRequestTimeout = 30;
          }
        });

        if (driverRequestTimeout == 0) {
          //informs driver that ride has timed out\
          print("Timing Out @: $driverRequestTimeout");
          driverTripRef.set('timeout');
          driverTripRef.onDisconnect();
          driverRequestTimeout = 30;
          timer.cancel();

          //select the next closest driver
          //  findDriver();
        }
      });
    });
  }

  void createRideRequest(BuildContext ctx) {
    print("DRIVERS: STARTING");
    final AuthService auth = context.read<AuthService>();
    final userHiveData =
        boxUserHive.get(auth.getCurrentUser()!.uid) as UserHive;
    //pickupController.text = pickUpData.placeName!;
    rideRef = FirebaseDatabase.instance.ref().child('rideRequest').push();

    rideID = rideRef.key!;

    String? userName = userHiveData.full_name;
    String? photoURL = userHiveData.photoURL;
    String? phone = userHiveData.phone;
    //String? email = userHiveData.email;
    String? userID = userHiveData.user_ID;

    DatabaseReference tripRider =
        FirebaseDatabase.instance.ref().child("rider_users/$userID/myTrips");

    final routeDataProvider =
        Provider.of<RouteDataProvider>(context, listen: false);

    var pickup = routeDataProvider.pickUpLocation;
    var destination = routeDataProvider.dropOffLocation;

    Map pickupMap = {
      'latitude': pickup.latitude.toString(),
      'longitude': pickup.longitude.toString(),
    };

    Map destinationMap = {
      'latitude': destination.latitude.toString(),
      'longitude': destination.longitude.toString(),
    };

    Map rideReq = {
      'created_at': DateTime.now().toString(),
      'rider_ID': userID,
      'rider_name': userName,
      'rider_phone': phone,
      'rider_Photo': photoURL,
      'person_number': phone,
      'pickup_address': pickup.placeName,
      'destination_address': destination.placeName,
      'location': pickupMap,
      'destination': destinationMap,
      'payment_method': 'Cash',
      'tripCost': routeDataProvider.tripFare,
      'driverID': 'waiting',
    };

    rideRef.set(rideReq);

    rideSubscription = rideRef.onValue.listen((DatabaseEvent event) async {
      final GoogleMapController gmcontroller = await _googleController.future;
      print("DRIVERS: SUBSCRPTION STARTED");

      //check for null snapshot
      final DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
      // Map<dynamic, dynamic>.from(snapshot.value as Map);
      if (event.snapshot.value == null) {
        return;
      }

      // //get Driver ID
      if (snapshot.value != null) {
        print("DRIVERS: SUBSCRPTION STARTED");
        print("DRIVER: ${data!['payment_method']}");
        //print();
        // setState(() {});
      }

      //get Driver ID
      if (data!['driverID'] != null) {
        setState(() {
          driverID = data['driverID'].toString();
        });

        // print("STARTING:$driverID ");
      }

      // get driver name
      if (data['driverName'] != null) {
        setState(() {
          driverName = data['driverName'].toString();
        });
      }

      // get driver name
      if (data['driverPhone'] != null) {
        setState(() {
          driverPhone = data['driverPhone'].toString();
        });
      }

      if (data['driverPhotoURL'] != null) {
        setState(() {
          driverPhotoURL = data['driverPhotoURL'].toString();
        });
      }

      //get car details
      if (data['vehicleModel'] != null) {
        setState(() {
          vehicleModel = data['vehicleModel'].toString();
        });
      }

      if (data['vehicleMenufacturer'] != null) {
        setState(() {
          vehicleManufacturer = data['vehicleMenufacturer'].toString();
        });
      }

      //get car details
      if (data['vehicleColor'] != null) {
        setState(() {
          vehicleColor = data['vehicleColor'].toString();
        });
      }
      //get driver Photo Profile
      if (data['licenseNumber'] != null) {
        setState(() {
          licenseNumber = data['licenseNumber'].toString();
        });
      }

      if (data['status'] != null) {
        status = data['status'].toString();
      }

      //get and use driver location updates
      if (data['driverLocation'] != null) {
        double driverLat =
            double.parse(data['driverLocation']['latitude'].toString());
        double driverLng =
            double.parse(data['driverLocation']['longitude'].toString());
        LatLng driverLocation = LatLng(driverLat, driverLng);

        Marker driverMarker = Marker(
          markerId: const MarkerId('riderMarker1'),
          anchor: const Offset(0.5, 0.5),
          position: driverLocation,
          icon: driverMarkerIcon!,
        );

        if (status == 'accepted') {
          print("Ride Accepted");
          PolylineResult result =
              await polylinePoints.getRouteBetweenCoordinates(
                  googleApiKey,
                  PointLatLng(
                      driverLocation.latitude, driverLocation.longitude),
                  PointLatLng(pickup.latitude, pickup.longitude));

          if (result.points.isNotEmpty) {
            polylineCoordinates = result.points
                .map<LatLng>((item) => LatLng(item.latitude, item.longitude))
                .toList();
          }

          Polyline polyline = Polyline(
            polylineId: const PolylineId('arriving'),
            color: const Color(0xFF35383F),
            points: polylineCoordinates,
            jointType: JointType.round,
            width: 4,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            geodesic: true,
          );
          _polylines.clear();

          setState(() {
            _polylines.add(polyline);
          });

          setState(() {
            markers.clear();
            markers.add(driverMarker);
          });

          gmcontroller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: driverLocation,
                zoom: 16.5,
              ),
            ),
          );

          //updateToPickup(driverLocation);
        } else if (status == 'ontrip') {
          startTripDestination();
          PolylineResult result =
              await polylinePoints.getRouteBetweenCoordinates(
                  googleApiKey,
                  PointLatLng(
                      driverLocation.latitude, driverLocation.longitude),
                  PointLatLng(destination.latitude, destination.longitude));

          if (result.points.isNotEmpty) {
            polylineCoordinates = result.points
                .map<LatLng>((item) => LatLng(item.latitude, item.longitude))
                .toList();
          }

          Polyline polyline = Polyline(
            polylineId: const PolylineId('ontrip'),
            color: const Color(0xFF35383F),
            points: polylineCoordinates,
            jointType: JointType.round,
            width: 4,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            geodesic: true,
          );

          _polylines.clear();

          setState(() {
            _polylines.add(polyline);
          });

          gmcontroller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: driverLocation,
                zoom: 13.5,
              ),
            ),
          );
          //updateToDestination(driverLocation);
        } else if (status == 'arrived') {
          setState(() {
            tripStatusDisplay = 'Driver has arrived';
          });
        }
      }

      if (status == 'terminated') {
        print("Ride Terminated $rideID");
        //showTripSheet();
        resetAppAtArriving();
        rideRef.onDisconnect();
        rideSubscription.cancel();
        startGeofireListener();

        // print("This accepted");
        // print("Driver name $driverFullName");
        // print("Driver name $driverPhoneNumber");
        // callDriverArriving();
        // Geofire.stopListener();
        // removeGeofireMarkers();
      }

      if (status == 'accepted') {
        //showTripSheet();

        //print("This accepted");
        // print("Driver name $driverFullName");
        //print("Driver name $driverPhoneNumber");
        callDriverArriving();
        Geofire.stopListener();

        removeGeofireMarkers();
      }

      if (status == 'ended') {
        showTripCompletionDialog(ctx);
        showRateDriver();
        resetAppAtArriving();
        rideRef.onDisconnect();
        rideSubscription.cancel();
        startGeofireListener();
        if (data['tripCost'] != null) {
          // Map saveTripRider = {
          //   'created_at': DateTime.now().toString(),
          //   'driver_name': driverName,
          //   'driver_photoProfile': driverPhotoURL,
          //   'pickup_address': pickup.placeName,
          //   'destination_address': destination.placeName,
          //   //'TripCost': '$fares',
          //   'TripCost': '22',
          // };

          // tripRider.push().set(saveTripRider);

          // setState(() {
          //   showDialog(
          //       context: context,
          //       builder: (context) => CollectPayment(
          //             fares: fares,
          //             paymentMethod: "Cash",
          //           ));
          //   tripSheetHeight = 0;
          // });
          // rideRef.onDisconnect();

          // rideRef = null;

          // rideSubscription.cancel();

          // rideSubscription = null;

          //resetApp();
        }
      }
    });
  }

  String extractFirstName(String fullName) {
    List<String> nameParts = fullName.split(' ');

    if (nameParts.isNotEmpty) {
      return nameParts[0];
    } else {
      return ''; // or throw an exception, depending on your use case
    }
  }

  void updatePolyline() async {
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //     googleApiKey,
    //     PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
    //     PointLatLng(destination.latitude, destination.longitude));
    //
    // if (result.points.isNotEmpty) {
    //   for (var point in result.points) {
    //     polylineCordinates.add(
    //       LatLng(point.latitude, point.longitude),
    //     );
    //   }
    //
    //   setState(() {});
    // }
    // print("Print: $polylineCordinates");
  }

  // Future<void> setDrverMarker(LatLng driverLocation) {}

  void removeGeofireMarkers() {
    setState(() {
      markers.removeWhere((m) => m.markerId.value.contains('driver'));
    });
  }

  void showRideConfirmSheet(AppScale appScale, bool backBtn_pressed) async {
    markers.clear();
    updateMapPadding(const EdgeInsets.only(
      bottom: 400, //310
      top: 80,
    ));

    await getDirection(appScale, backBtn_pressed);

    hideDefaultHomeWidgets();
    showOrderWidgets();
  }

  void dismissRideConfirmSheet() async {
    setState(() {
      _polylines.clear();
    });
    updateDriversOnMap();
    _returnToCurrentLocation();
    showDefaultHomeWidgets();
    hideOrderWidgets();
  }

  void hideDefaultHomeWidgets() {
    setState(() {
      myLocationEnabled = false;
      whereAreUGoing = false;
      addressVisibility = false;
      locBtnVisibility = false;
      showMenuButtonVisibility = false;
    });
  }

  void showDefaultHomeWidgets() {
    setState(() {
      updateMapPadding(const EdgeInsets.only(bottom: 150));
      whereAreUGoing = true;
      addressVisibility = true;
      locBtnVisibility = true;
      showMenuButtonVisibility = true;
    });
  }

  void updateMapPadding(EdgeInsets newPadding) {
    setState(() {
      _currentMapPadding = newPadding;
    });
  }

  void showOrderWidgets() {
    //updateMapPadding(const EdgeInsets.only(bottom: 305));

    setState(() {
      showOrderBottomSheet = true;
      //showConfirmOrderBottomSheetWidget = true;
      back2SeacrhVisibility = true;
    });
  }

  void hideOrderWidgets() {
    setState(() {
      showOrderBottomSheet = false;
      //showConfirmOrderBottomSheetWidget = false;
      back2SeacrhVisibility = false;
    });
  }

  void callRideSearcher() {
    updateMapPadding(const EdgeInsets.only(
      bottom: 280, //310
    ));
    setState(() {
      showSearchingForDriverWidget = true;
      showOrderBottomSheet = false;
      //showConfirmOrderBottomSheetWidget = false;
    });
  }

  void callDriverArriving() {
    setState(() {
      showMenuButtonVisibility = true;
      back2SeacrhVisibility = false;
      showSearchingForDriverWidget = false;
      showDriverArrivingSheet = true;
    });
  }

  void startTripDestination() {
    setState(() {
      showDriverArrivingSheet = false;
      showDriverOntripSheet = true;
    });
  }

  void resetAppAtArriving() {
    setState(() {
      _polylines.clear();
    });
    //updateDriversOnMap();
    _returnToCurrentLocation();
    showDefaultHomeWidgets();
    hideOrderWidgets();
    setState(() {
      showDriverArrivingSheet = false;
    });
  }

  //void resetApp

  void startGeofireListener() {
    Geofire.initialize('availDrivers');
    DatabaseReference driverServiceTypeRef = FirebaseDatabase.instance.ref();
    Geofire.queryAtLocation(
            locationHiveData!.latitude, locationHiveData!.longitude, 5)!
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];
        print("Map callback: $map");

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyDriver nearbyDriver = NearbyDriver(
                longitude: 0, key: '', latitude: 0, serviceType: '');
            String service = getServiceType(driverServiceTypeRef, map);

            nearbyDriver.key = map['key'];
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];
            nearbyDriver.serviceType = service;
            NearbyDriverBot.nearbyDriverList.add(nearbyDriver);

            if (nearbyDriversKeysLoaded) {
              updateDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            NearbyDriverBot.removeFromList(map['key']);
            updateDriversOnMap();
            break;

          case Geofire.onKeyMoved:
            NearbyDriver nearbyDriver = NearbyDriver(
                latitude: 0, longitude: 0, key: '', serviceType: '');

            String service = getServiceType(driverServiceTypeRef, map);

            nearbyDriver.key = map['key'];
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];
            nearbyDriver.serviceType = service;

            NearbyDriverBot.updateNearbyLocation(nearbyDriver);
            updateDriversOnMap();
            break;

          case Geofire.onGeoQueryReady:
            nearbyDriversKeysLoaded = true;
            updateDriversOnMap();
            break;
        }
      } else {
        print("Done: Map is null");
      }
    });
  }

  String getServiceType(driverServiceTypeRef, dynamic map) {
    String serviceType = '';
    DatabaseReference driverServiceType =
        driverServiceTypeRef.child('availDrivers/${map['key']}/serviceType');

    driverServiceType.onValue.listen((DatabaseEvent databaseEvent) {
      serviceType = databaseEvent.snapshot.value.toString();
    });

    return serviceType;
  }

  void updateDriversOnMap() {
    if (mounted) {
      setState(() {
        markers.clear();
      });
    }

    Set<Marker> tempMarkers = Set<Marker>();
    for (NearbyDriver driver in NearbyDriverBot.nearbyDriverList) {
      LatLng driverPosition = LatLng(driver.latitude, driver.longitude);
      print("Map Driver Position: $driverPosition");
      Marker thisMarker = Marker(
        markerId: MarkerId('driver${driver.key}'),
        position: driverPosition,
        icon: nearbyIcon!,
        rotation: MapAPIService.generateRandomNumber(360),
      );

      print("Map - Marker Icon ${nearbyIcon.toString()}");
      tempMarkers.add(thisMarker);
    }

    // setState(() {
    //   markers = tempMarkers;
    // });

    if (mounted) {
      setState(() {
        markers = tempMarkers;
      });
    }
  }

  void createMarkers(AppScale appScale) {
    if (nearbyIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(5, 5));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/icons/car_icon.png')
          .then((icon) {
        setState(() {
          nearbyIcon = icon;
        });
      });
    }

    if (driverMarkerIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(5, 5));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/icons/car_icon2.png')
          .then((icon) {
        setState(() {
          driverMarkerIcon = icon;
        });
      });
    }

    if (pickupIcon == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(
          context,
          size: Size(appScale.scaleWidth(1.13), appScale.scaleWidth(1.13)));
      // size: Size(appScale.scaleWidth(0.56), appScale.scaleWidth(0.56)));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/icons/pickup-marker.png')
          .then((icon) {
        setState(() {
          pickupIcon = icon;
        });
      });
    }
    if (pickupIconzoomed == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/icons/pickup-marker_zoomed.png')
          .then((icon) {
        setState(() {
          pickupIconzoomed = icon;
        });
      });
    }

    if (destinationIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/icons/destination-marker.png')
          .then((icon) {
        setState(() {
          destinationIcon = icon;
        });
      });
    }
  }

  Future<void> getDirection(AppScale appScale, bool backBtn_pressed) async {
    final RouteDataProvider routeDataProvider =
        Provider.of<RouteDataProvider>(context, listen: false);
    var pickup = routeDataProvider.pickUpLocation;
    var destination = routeDataProvider.dropOffLocation;

    var pickLatLng = LatLng(pickup.latitude, pickup.longitude);
    var destinationLatLng = LatLng(destination.latitude, destination.longitude);
    final GoogleMapController gmcontroller = await _googleController.future;
    // _calculateDistance(pickLatLng, destinationLatLng, routeDataProvider);

    if (backBtn_pressed == false) {
      showLoadingDialog(context);

      var directionDetails = await MapAPIService.getDirectionDetails(
          pickLatLng, destinationLatLng);
      routeDataProvider.updateDirectionDetails(directionDetails!);
      print("This is your Direction Details[Hopmepage]: $directionDetails");

      setState(() {
        tripDirectionDetails = directionDetails;
        Navigator.pop(context);
        //fares = HelperMethods.estimateFares(tripDirectionDetails);
      });
    } else {
      var savedDirectionDetails = routeDataProvider.directionDetails;
      setState(() {
        tripDirectionDetails = savedDirectionDetails;
      });
    }

    final durationInMinutes = (tripDirectionDetails.durationValue / 60).ceil();

    //print("timeInMinSec ${tripDirectionDetails.distanceValue}");
    //print("timeInMinSec ${tripDirectionDetails.durationValue}");
    routeDataProvider.updateTripTime(durationInMinutes);
    print("timeInMin $durationInMinutes");

    // Extract the distance value in meters
    double distanceInMeters = tripDirectionDetails.distanceValue.toDouble();

    // Convert the distance from meters to kilometers (1 km = 1000 meters)
    double distanceInKilometers = distanceInMeters / 1000;
    routeDataProvider.updateDistance(distanceInKilometers);

    // Now, distanceInKilometers contains the distance in kilometers
    print("timeInMin Distance: $distanceInKilometers km");

    // Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(tripDirectionDetails.encodedPoints);

    polylineCoordinates.clear();
    if (results.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      results.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("Result is empty");
    }

    setState(() {
      _polylines.clear();

      Polyline polyline = Polyline(
        polylineId: PolylineId('polyid'),
        color: Color(0xFF636773),
        points: polylineCoordinates,
        jointType: JointType.round,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      _polylines.add(polyline);
    });

    // make polyline to fit into the map

    LatLngBounds bounds;

    if (pickLatLng.latitude > destinationLatLng.latitude &&
        pickLatLng.longitude > destinationLatLng.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng, northeast: pickLatLng);
    } else if (pickLatLng.longitude > destinationLatLng.longitude) {
      bounds = LatLngBounds(
        southwest: LatLng(pickLatLng.latitude, destinationLatLng.longitude),
        northeast: LatLng(destinationLatLng.latitude, pickLatLng.longitude),
      );
    } else if (pickLatLng.latitude > destinationLatLng.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, pickLatLng.longitude),
        northeast: LatLng(pickLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      bounds =
          LatLngBounds(southwest: pickLatLng, northeast: destinationLatLng);
    }

    // double minLatitude = pickLatLng.latitude < destinationLatLng.latitude
    //     ? pickLatLng.latitude
    //     : destinationLatLng.latitude;

    // double maxLatitude = pickLatLng.latitude > destinationLatLng.latitude
    //     ? pickLatLng.latitude
    //     : destinationLatLng.latitude;

    // double minLongitude = pickLatLng.longitude < destinationLatLng.longitude
    //     ? pickLatLng.longitude
    //     : destinationLatLng.longitude;

    // double maxLongitude = pickLatLng.longitude > destinationLatLng.longitude
    //     ? pickLatLng.longitude
    //     : destinationLatLng.longitude;

    // LatLngBounds bounds = LatLngBounds(
    //   southwest: LatLng(minLatitude, minLongitude),
    //   northeast: LatLng(maxLatitude, maxLongitude),
    // );

    //gmcontroller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    //
    print("Route Bound: $bounds");
    gmcontroller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, appScale.scaleWidth(11.2)));

    Marker pickupMarker = Marker(
      markerId: MarkerId('pickupMarker'),
      anchor: Offset(0.5, 1.0),
      position: pickLatLng,
      icon: pickupIcon!,
      // infoWindow: InfoWindow(title: pickup.placeName, snippet: 'My Location'),
    );

    Marker destinationMarker = Marker(
      markerId: MarkerId('destination'),
      position: destinationLatLng,
      anchor: Offset(0.5, 0.5),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      icon: destinationIcon!,
      infoWindow:
          InfoWindow(title: destination.placeName, snippet: 'Destination'),
    );

    setState(() {
      markers.add(pickupMarker);
      markers.add(destinationMarker);
    });
  }

  Future<void> animateSearching() async {
    _polylines.clear();

    final existingDriverMarker = markers.firstWhere(
        (marker) => marker.markerId == const MarkerId('destination'));

    if (existingDriverMarker != null) {
      setState(() {
        markers.remove(existingDriverMarker);
      });
    }

    final routeDataProvider =
        Provider.of<RouteDataProvider>(context, listen: false);
    final pickup = routeDataProvider.pickUpLocation;

    Marker pickupMarker = Marker(
      markerId: const MarkerId('pickupMarker'),
      anchor: const Offset(0.5, 1.0),
      position: LatLng(pickup.latitude, pickup.longitude),
      icon: pickupIconzoomed!,
      // infoWindow: InfoWindow(title: pickup.placeName, snippet: 'My Location'),
    );

    Marker? existingPickMarker = markers.firstWhere(
        (marker) => marker.markerId == const MarkerId('pickupMarker'));

    setState(() {
      markers.remove(existingPickMarker);
      markers.add(pickupMarker);
    });

    final GoogleMapController gmcontroller = await _googleController.future;

    // await gmcontroller.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       target: LatLng(pickup.latitude, pickup.longitude),
    //       zoom: 16.5,
    //     ),
    //   ),
    // );

    const double targetZoom = 14.0;
    const double zoomIncrement = 0.05;

    // Calculate the number of steps needed to reach the target zoom
    final int steps = ((16.5 - targetZoom) / zoomIncrement).abs().ceil();

    if (steps > 0) {
      // Interpolate the zoom level for smoother zoom in animation
      final zoomStep = (16.5 - targetZoom) / steps;

      Timer.periodic(Duration(milliseconds: 10), (timer) {
        if (currentZoom > targetZoom) {
          currentZoom -= zoomStep;
          gmcontroller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(pickup.latitude, pickup.longitude),
                zoom: currentZoom,
                //bearing: 90,
              ),
            ),
          );
        } else {
          // When the first animation is complete, start the zoom-out animation
          timer.cancel();

          Timer.periodic(Duration(milliseconds: 10), (zoomOutTimer) {
            if (currentZoom < 16.5) {
              currentZoom += zoomStep;
              gmcontroller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(pickup.latitude, pickup.longitude),
                    zoom: currentZoom,
                    // bearing: 90,
                  ),
                ),
              );
            } else {
              // If you reach the desired zoom level, cancel the timer.
              zoomOutTimer.cancel();
            }
          });
        }
      });
    }
  }

  void cancelRideRequest() {
    updateMapPadding(const EdgeInsets.only(
      bottom: 400, //310
    ));
    setState(() {
      showOrderBottomSheet = true;
    });
    showSearchingForDriverWidget = false;

    //rideSubscription.cancel();
  }

  void showRateDriver() {
    showDriverOntripSheet = false;
    rateDriverSheetVisibility = true;
  }

  void defaultAppState() {
    markers.clear();
    _polylines.clear();
    rateDriverSheetVisibility = false;
  }

  // void _calculateDistance(
  //     pickup, destination, RouteDataProvider routeDataProvider) {
  //   const double earthRadius = 6371.0; // Radius of the Earth in kilometers
  //   double lat1 = pickup.latitude * (pi / 180.0);
  //   double lon1 = pickup.longitude * (pi / 180.0);
  //   double lat2 = destination.latitude * (pi / 180.0);
  //   double lon2 = destination.longitude * (pi / 180.0);

  //   double dlon = lon2 - lon1;
  //   double dlat = lat2 - lat1;

  //   double a =
  //       pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
  //   double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  //   double distance = earthRadius * c; // Distance in kilometers
  //   routeDataProvider.updateDistance(distance);
  // }
}
