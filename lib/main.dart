import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:orbit/constants/global_contants.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/firebase_options.dart';
import 'package:orbit/routes.dart';
import 'package:orbit/screens/authentication/registration_auth_data.dart';
import 'package:orbit/screens/splash/splash_screen.dart';
import 'package:orbit/service/firebase_futures/future_futures.dart';
import 'package:orbit/service/providers/appdata_provider.dart';
import 'package:orbit/service/providers/auth_service.dart';
import 'package:orbit/service/providers/firebase_service.dart';
import 'package:orbit/service/providers/trip/route_provider.dart';
import 'package:orbit/service/providers/userExist_checker_service.dart';
import 'package:orbit/service/streams/stream_preloader.dart';
import 'package:orbit/service/streams/stream_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'service/providers/pick_location_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveAdapter());
  Hive.registerAdapter(LocationHiveAdapter());
  Hive.registerAdapter(PickUpAddressHiveAdapter());
  boxUserHive = await Hive.openBox<UserHive>('userBox');
  boxUserSignUpHive = await Hive.openBox<UserHive>('userSingUpBox');
  boxLocationHive = await Hive.openBox<LocationHive>('locationBox');
  boxPickUpAddressHive =
      await Hive.openBox<PickUpAddressHive>('pickupaddressBox');

  sharedPref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        Provider<Database>(create: (_) => FirestoreDatabase()),
        Provider<FirebaseFutures>(create: (_) => FireBaseFuturesService()),
        Provider<StreamPreloader>(create: (_) => StreamPreloader()),
        Provider<RegistrationAuthData>(create: (_) => RegistrationAuthData()),
        Provider<UserExistCheckerService>(
            create: (_) => UserExistCheckerService()),
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
        ChangeNotifierProvider(create: (_) => PickLocationProvider()),
        ChangeNotifierProvider<RouteDataProvider>(
            create: (_) => RouteDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: ThemeData(
        fontFamily: 'Urbanist',
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      //home: SheetTest(),
      //home: AccountSetupPhoneAuth(),ArrivingShimmer
      //home: AccountSetupPhoneAuth(),
      //home: DriverChatScreen(),
      //home: BottomSheetTemp(),
      home: SplashScreen(),
      // home: EmailSigninScreen(),
    );
  }
}
