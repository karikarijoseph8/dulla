import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/app_keys.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/trip/autocomplate_prediction.dart';
import 'package:orbit/screens/home/search/search_result_tile.dart';
import 'package:orbit/service/providers/pick_location_provider.dart';
import 'package:orbit/service/providers/trip/places_utility.dart';
import 'package:provider/provider.dart';
import '../../../models/trip/address.dart';
import '../../../models/trip/place_auto_complate_response.dart';
import '../../../service/providers/trip/route_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {super.key,
      required this.backToSeach,
      this.editPickUp = false,
      this.editDestination = false});
  final bool backToSeach;
  final bool editPickUp;
  final bool editDestination;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  late FocusNode destinationNode;
  late FocusNode pcikupLocationNode;

  bool destinationHasFocus = false;
  bool pickupHasFocus = false;
  String nullText = "";

  List<AutocompletePrediction> placePredictions = [];

  @override
  void initState() {
    super.initState();

    // if (pickupLocation.getCurrentLocation.latitude == null) {
    //   print("It's Empty");
    // } else {
    //   destinationController.text = pickupLocation.getCurrentLocation.placeName;
    // }

    // pickupController.text = routeDataProvider.pickUpLocation.placeName;
    // final pickUpData =
    //     boxPickUpAddressHive.get("key_pickupAddress") as PickUpAddressHive;
    // pickupController.text = pickUpData.placeName!;

    pcikupLocationNode = FocusNode();
    destinationNode = FocusNode();
    if (widget.editDestination == true) {
      destinationNode.requestFocus();
    }

    if (widget.editPickUp == true) {
      pcikupLocationNode.requestFocus();
    }
    pcikupLocationNode.addListener(() {
      print("Search: Pickup ${pcikupLocationNode.hasFocus}");
    });
    destinationNode.addListener(() {
      print("Search: Destination ${destinationNode.hasFocus}");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('dinesh search...');
      final PickLocationProvider pickupLocation =
      Provider.of<PickLocationProvider>(context, listen: false);

      pickupController.text = pickupLocation.getCurrentLocation.placeName;

      //initial setting data
      final RouteDataProvider routeDataProvider =
      Provider.of<RouteDataProvider>(context, listen: false);

      // Update pickup address to routeDataProvider
      routeDataProvider.updatePickupAddress(pickupLocation.getCurrentLocation);

      if (widget.backToSeach == true) {
        try {
          // Accessing the late variable
          destinationController.text = routeDataProvider.dropOffLocation.placeName;
        } catch (e) {
          if (kDebugMode) {
            print('Error: $e');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    pcikupLocationNode.dispose();
    destinationNode.dispose();
    super.dispose();
  }

  Future<void> placesAutocomple(String query) async {
    print("Clicked");
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {"input": query, "key": googleApiKey});

    String? response = await PlacesUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
      print(response);
    } else {
      print("response is null");
    }
  }

  void getPlaceDetails(String placeID, context, String fieldType) async {
    const String countryCode = 'GH'; // Country code for Ghana

    Uri uri = Uri.https(
        "maps.googleapis.com",
        //'/maps/api/place/autocomplete/json',
        '/maps/api/place/details/json',
        {
          "place_id": placeID,
          "key": googleApiKey,
          "language": "en",
          "region": "country:$countryCode",
        });

    var response = await PlacesUtility.getRequest(uri);

    // Navigator.pop(context);

    if (response == 'failed') {
      return;
    }

    print("This is destination reseponse[helper_page]: $response");

    if (response['status'] == 'OK') {
      Address thisPlace = Address(
          placeId: '',
          placeFormattedAddress: '',
          longitude: 0,
          latitude: 0,
          placeName: '');
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.placeFormattedAddress = response['result']['formatted_address'];
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];

      print("This is the place Name: ${thisPlace.placeName}");
      print(
          "This is the place FormattedAddress: ${thisPlace.placeFormattedAddress}");
      final RouteDataProvider routeDataProvider =
          Provider.of<RouteDataProvider>(context, listen: false);

      if (fieldType == "destination") {
        routeDataProvider.updateDestinationAddress(thisPlace);
        Navigator.pop(context, 'getDirection');
      } else if (fieldType == "pickup") {
        routeDataProvider.updatePickupAddress(thisPlace);
        Navigator.pop(context, 'getDirection');
      } else if (fieldType == "destinationOnly") {
        routeDataProvider.updateDestinationAddress(thisPlace);
      } else if (fieldType == "pickupOnly") {
        routeDataProvider.updatePickupAddress(thisPlace);
      }
    }
  }

  TextSpan _highlightText(String text, String query) {
    List<TextSpan> spans = [];
    int start = 0;

    // Loop through the text and find matches.
    while (start < text.length) {
      final startIndex = text.toLowerCase().indexOf(query.toLowerCase(), start);
      if (startIndex == -1) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: TextStyle(color: Colors.black),
        ));
        break;
      } else {
        spans.add(TextSpan(
          text: text.substring(start, startIndex),
          style: TextStyle(color: Colors.black),
        ));
        spans.add(TextSpan(
          text: text.substring(startIndex, startIndex + query.length),
          style: TextStyle(color: Colors.green),
        ));
        start = startIndex + query.length;
      }
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Text(
                      "Close",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 68,
                  ),
                  Text(
                    "Going to",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 2,
                  //     blurRadius: 5,
                  //     offset:
                  //         Offset(0, 3), // changes the position of the shadow
                  //   ),
                  // ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          // SvgPicture.asset(
                          //   "assets/icons/located-map.svg",
                          //   width: 20,
                          // ),
                          // Container(
                          //   width: 20, // Adjust the width as needed
                          //   height: 20, // Adjust the height as needed
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape
                          //         .circle, // Makes it a circular container
                          //     gradient: LinearGradient(
                          //       begin: Alignment.topLeft,
                          //       end: Alignment.bottomRight,
                          //       colors: [Color(0xFFFFCC3B), Color(0xFFF8B71C)],
                          //     ),
                          //   ),
                          //   child: Center(
                          //     child: Container(
                          //       width:
                          //           6, // Adjust the width of the centered white container
                          //       height:
                          //           6, // Adjust the height of the centered white container
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         shape: BoxShape
                          //             .circle, // Makes it a circular container
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          Container(
                            //padding: EdgeInsets.only(top: 13),
                            decoration: BoxDecoration(
                              //color: Color(0xFFF3F3FA),
                              //color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/locationMap3.svg",
                              width: 19,
                              //color: Color(0xFF747682),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 270,
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 20, right: 0),
                      child: Form(
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                controller: pickupController,
                                focusNode: pcikupLocationNode,
                                onChanged: (value) {
                                  placesAutocomple(value);
                                },
                                onTap: () {
                                  setState(() {
                                    destinationHasFocus = false;
                                    pickupHasFocus = true;
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: 'Set pickup location',
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color(0xFFAAACAE)),
                                    border: InputBorder.none),
                                style: GoogleFonts.poppins(fontSize: 16),
                                textInputAction: TextInputAction.search,
                              ),
                            ),
                            Divider(
                              color: destinationHasFocus
                                  ? AppColors.mainYellow
                                  : Color(0xFFDFE2E5),
                              thickness: 1,
                              height: 1,
                            ),
                            Container(
                              child: TextFormField(
                                controller: destinationController,
                                focusNode: destinationNode,
                                onChanged: (value) {
                                  print("Search: typing");
                                  placesAutocomple(value);
                                },
                                onTap: () {
                                  print("Search: Destination Clicked");
                                  setState(() {
                                    destinationHasFocus = true;
                                    pickupHasFocus = false;

                                    print("Search: $destinationHasFocus");
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Where are going?',
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color(0xFFAAACAE), fontSize: 16),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.poppins(fontSize: 16),
                                textInputAction: TextInputAction.search,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              //SearchTile(),
              // Divider(
              //   color: Color(0xFFDFE2E5),
              //   thickness: 2,
              //   height: 1,
              // ),
              // if (placePredictions.length == 0) ...[
              //   Text("Please Search For Something")
              // ],
              Expanded(
                child: ListView.builder(
                    itemCount: placePredictions.length,
                    itemBuilder: (context, index) => LocationListTile(
                          press: () {
                            // Navigator.pop(context, 'getDirection');
                            if (pickupHasFocus == true) {
                              print("Search: Pickup has Focus");
                              if (destinationController.text != "") {
                                pickupController.text =
                                    placePredictions[index].placeMainText!;

                                getPlaceDetails(
                                    placePredictions[index].placeId!,
                                    context,
                                    "pickup");
                              } else if (destinationController.text == "") {
                                getPlaceDetails(
                                    placePredictions[index].placeId!,
                                    context,
                                    "pickupOnly");
                                pickupController.text =
                                    placePredictions[index].placeMainText!;
                                destinationNode.requestFocus();
                                setState(() {
                                  destinationHasFocus = true;
                                  pickupHasFocus = false;
                                });

                                setState(() {
                                  placePredictions.clear();
                                });
                              }

                              // pickupController.text =
                              //     placePredictions[index].placeMainText!;
                              // destinationNode.requestFocus();
                              // } else if (destinationNode.hasFocus) {
                            } else if (destinationHasFocus == true) {
                              print("Search: Destination has Focus");
                              if (pickupController.text != "") {
                                destinationController.text =
                                    placePredictions[index].placeMainText!;

                                print(
                                    "Search: GEEEEEEEEEEEEEEEEEEETTTTTTTTTTTTING");
                                getPlaceDetails(
                                    placePredictions[index].placeId!,
                                    context,
                                    "destination");
                                // destinationNode.unfocus();
                                // Navigator.pop(context, 'getDirection');
                              } else if (pickupController.text == "") {
                                getPlaceDetails(
                                    placePredictions[index].placeId!,
                                    context,
                                    "destinationOnly");
                                destinationController.text =
                                    placePredictions[index].placeMainText!;
                                pcikupLocationNode.requestFocus();
                                setState(() {
                                  destinationHasFocus = false;
                                  pickupHasFocus = true;
                                  placePredictions.clear();
                                });
                              }
                              // destinationController.text =
                              //     placePredictions[index].placeMainText!;
                            }

                            print("Search: Nothing has Focus");
                            //pcikupLocationNode.requestFocus();
                          },
                          location: placePredictions[index].placeMainText!,
                          placeMainText: placePredictions[index].placeMainText!,
                          placeSecondaryText:
                              placePredictions[index].placeSecondaryText!,
                          inputText: destinationController.text,
                        )),
              ),
            ],
          )),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 9),
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: Color(0xFFAAACAE),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rd. Allentown",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "1901 Thornridge Cir. Shiloh",
                    style: GoogleFonts.poppins(color: Color(0xFF636773)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          "2.31km",
          style: GoogleFonts.poppins(color: Color(0xFF636773)),
        )
      ],
    );
  }
}
