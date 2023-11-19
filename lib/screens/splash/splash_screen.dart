import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/screens/authentication/phone_auth/phone_auth_screen.dart';
import 'package:orbit/screens/home/home_wrapper.dart';
import 'package:orbit/service/map_service/map_methods.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:provider/provider.dart';
import '../../components/app_scale.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.light;
  final MapMethods mapMethods = MapMethods();
  Position currentPosition = Position(
    latitude: 0.0, // Default latitude value
    longitude: 0.0, // Default longitude value
    timestamp: DateTime.now(), // Default timestamp value (you can adjust this)
    accuracy: 0.0, // Default accuracy value
    altitude: 0.0, // Default altitude value
    heading: 0.0, // Default heading value
    speed: 0.0, // Default speed value
    speedAccuracy: 0.0, altitudeAccuracy: 0.0,
    headingAccuracy: 0.0, // Default speedAccuracy value
  );

  @override
  void initState() {
    super.initState();
    setupInitialUI();
  }

  Future<void> setupInitialUI() async {
    _currentStyle = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.mainYellow,
      systemNavigationBarIconBrightness: Brightness.dark,
    );

    setupPositionLocator(context);

    // Delayed navigation to the HomeController after 5 seconds
    // Future.delayed(const Duration(seconds: 5), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomeController()),
    //   );
    // });
  }

  Future<void> setupPositionLocator(context) async {
    //Position position = await mapMethods.determinePosition(context);
    await mapMethods.determinePositionAtLunch().then(
      (position) {
        print("Location received $position");

        //MapAPIService.searchCoordinateAddress2(context);
        final locData = LocationHive(
            latitude: position.latitude, longitude: position.longitude);

        boxLocationHive.put("key_location", locData);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeController()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppScale appScale = AppScale(context);
    // final appDataProvider = Provider.of<AppDataProvider>(context);
    // appDataProvider.setCurrentLocation = currentPosition;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    print("Widthing $width");
    print("Widthing $height");

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _currentStyle,
      child: Scaffold(
        backgroundColor: AppColors.mainYellow,
        body: Center(
          child: Image.asset(
            "assets/images/orbit.png",
            width: appScale.scaleWidth(69.45), // Width = 50
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////HOME CONTROLLER/////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class HomeController extends StatefulWidget {
  const HomeController({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.watch<AuthService>().onAuthStateChanged,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;

          if (signedIn == true) {}

          return signedIn ? const HomeWrapper() : const PhoneAuthScreen();
        }
        return const Loading();
      },
    );
  }

  // Future<void> fetchUserData(BuildContext context) async {
  //   final db = Provider.of<FirebaseFutures>(context, listen: false);
  //   final AuthService auth = context.read<AuthService>();
  //   //SharePreferencesHelper sharedPreferencesHelper = SharePreferencesHelper();
  //   try {
  //     final userData = await db.getUserData(auth.getCurrentUser()!.uid);

  //     final userData2 = userData as UserHive;
  //     boxUserHive.put(userData.user_ID, userData);
  //     //sharedPreferencesHelper.setUserDetail(userData);

  //     print("User Data: ${userData.deleted_account}");
  //     print("User Data: ${userData.full_name}");
  //     print("User Data: ${userData.email}");
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }
}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Loading..."),
      ),
    );
  }
}
