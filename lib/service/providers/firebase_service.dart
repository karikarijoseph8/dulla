// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/trip/address.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userData');

////////////////////////////////////////////////////////////
////////////////////EMAIL AUTH/////////////////////////////
///////////////////////////////////////////////////////////

  Future<void> saveEmailAuthUserData(
    String uid,
    //String name,
    String email,
    // String phone,
  ) async {
    await _firestore.collection('userData').doc(uid).set({
      'user_ID': uid,
      'email': email,
      'photoURL': '',

      //Auths
      'signUpComplete': false,
      'phoneAuth': false,
      'googleAuth': false,
      'emailAuth': true,

      //Blockings
      'deleted_account': false,
      'blocked': false,
      'permanently_blocked': false,
      'timeStamp': Timestamp.now()
    });
  }

  Future<void> updateEmailAuthUserData(
    String uid,
    String name,
    String phone,
  ) async {
    await _firestore.collection('userData').doc(uid).update({
      'full_name': name,
      'phone': phone,
      'signUpComplete': true,
    });
  }

////////////////////////////////////////////////////////////
////////////////////EMAIL AUTH END//////////////////////////
///////////////////////////////////////////////////////////

  Future<void> updateEmailAuthUserDataWithPhone(
      String uid, String phone, String fullname) async {
    await _firestore.collection('userData').doc(uid).update({
      'phone': phone,
      'full_name': fullname,
    });
  }
////////////////////////////////////////////////////////////
////////////////////PHONE AUTH/////////////////////////////
///////////////////////////////////////////////////////////

  Future<void> savePhoneAuthUserData(
      String uid, String phone, String email, String fullname) async {
    await _firestore.collection('userData').doc(uid).set({
      'user_ID': uid,
      'phone': phone,
      'full_name': fullname,
      'email': email,
      'photoURL': '',

      //accountType
      'signUpComplete': true,
      'phoneAuth': true,
      'googleAuth': false,
      'emailAuth': false,

      //blockings
      'deleted_account': false,
      'blocked': false,
      'permanently_blocked': false,
      'timeStamp': Timestamp.now()
    });
  }
////////////////////////////////////////////////////////////
////////////////////PHONE AUTH END//////////////////////////
///////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
////////////////////GOOGLE AUTH/////////////////////////////
///////////////////////////////////////////////////////////

  Future<void> saveGoogleAuthUserData(
    String uid,
    String name,
    String email,
    String photoURL,
  ) async {
    await _firestore.collection('userData').doc(uid).set({
      'user_ID': uid,
      'full_name': name,
      'email': email,
      'photoURL': photoURL,

      //Auths
      'signUpComplete': false,
      'phoneAuth': false,
      'googleAuth': true,
      'emailAuth': false,

      //Blocking
      'deleted_account': false,
      'blocked': false,
      'permanently_blocked': false,
      'timeStamp': Timestamp.now()
    });
  }

  Future<void> updateGoogleAuthUserData(
    String uid,
    String phone,
  ) async {
    await _firestore.collection('userData').doc(uid).update({
      'user_ID': uid,
      'phone': phone,
      'signUpComplete': true,
    });
  }

////////////////////////////////////////////////////////////
////////////////////GOOGLE AUTH END/////////////////////////
///////////////////////////////////////////////////////////

  Future<void> saveMyBook(
    String uid,
    String name,
    String email,
    String photoURL,
  ) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('myBookings')
        .doc()
        .set({
      'user_ID': uid,
      'created_at': uid,
      'rider_name': uid,
      'rider_phone': uid,
      'rider_Photo': uid,
      'person_number': uid,
      'pickup_address': uid,
      'destination_address': uid,
      'location': uid,
      'destination': uid,
      //'destination': uid,
    });
  }

  // 'created_at': DateTime.now().toString(),
  //     'rider_name': userName,
  //     'rider_phone': phone,
  //     'rider_Photo': photoURL,
  //     'person_number': phone,
  //     'pickup_address': pickup.placeName,
  //     'destination_address': destination.placeName,
  //     'location': pickupMap,
  //     'destination': destinationMap,
  //     'payment_method': 'Cash',
  //     'tripCost': routeDataProvider.tripFare,
  //     'driverID': 'waiting',
  Future<void> savePhoneAuthUserProfileData(
    String uid,
    String name,
    String email,
    String photoURL,
  ) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        //.collection('profile')
        //.doc('profile')
        .set({
      'user_ID': uid,
      // 'completed_Setup': false,
      'full_name': name,
      'email': email,
      'phone': "phone",
      'photoURL': photoURL,
      'facebook_signUp': false,
      'phone_auth_complete': false,
      'google_auth': true,
      'emailPassword_auth': false,
      'deleted_account': false,
      'blocked': false,
      'permanently_blocked': false,
    });
  }

///////////////////////////CHAT//////////////////////////////////////
  Future<void> sendDriverChat(
      String userID, String driverID, String msg) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('driverData').doc(driverID);
    final faqRef = walletRef
        .collection('chatData')
        .doc(userID)
        .collection('chatMsg')
        .doc();
    try {
      await faqRef.set({
        'message': msg,
        'senderID': userID,
        'messageID': faqRef.id,
        'timeStamp': DateTime.now(),
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  Future<void> sendCustomerCareChat(String userID, String msg) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final walletRef = firestore.collection('appData').doc("helpCenter");
    final faqRef = walletRef
        .collection('customerCareChat')
        .doc(userID)
        .collection('chatData')
        .doc();
    try {
      await faqRef.set({
        'message': msg,
        'senderID': userID,
        'messageID': faqRef.id,
        'timeStamp': DateTime.now(),
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  ///TRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIP
  ///TRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIP
  ///TRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIP
  ///TRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIP
  ///TRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIP
  ///TRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIP
  ///TRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIPTRIP

  Future<void> savePleaceSearch(String userID, Address address) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('userData').doc(userID);
    final placeRef = userRef.collection('placeSearch').doc();
    try {
      await placeRef.set({
        'placeName': address.placeName,
        'placeId': address.placeId,
        'latitude': address.latitude,
        'longitude': address.longitude,
        'placeFormattedAddress': address.placeFormattedAddress,
        'timeStamp': DateTime.now(),
      });
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }

  // Future<String> deleteExistingUser(context, uid,) async {
  //   String error = '';
  //   showLoadingDialog(context);
  //   try{
  //     await _firestore
  //         .collection('userData')
  //         .doc(uid).delete();
  //   } on FirebaseAuthException catch (e) {
  //     print('userData Error ${e.code}');
  //   }
  //   print('Have deleted userData $uid');

  //   try{
  //       await _auth.currentUser!.delete();
  //       print('Have deleted user');
  //       await  _auth.signOut();
  //       Navigator.of(context).pop();
  //       showMessageSnackBar(context, 'Your account was deleted successfully');
  //       print('Have signed user out without re-authenticating');
  //   } on FirebaseAuthException catch (e) {
  //     if(e.code == 'requires-recent-login'){
  //       error = e.code;
  //       Navigator.of(context).pop();
  //       showReAuthDialog(context,);
  //       print('This User has to re-authenticate');
  //       return e.code;
  //     }else{
  //       print('Have deleted user');
  //       await  _auth.signOut();
  //       Navigator.of(context).pop();
  //       showMessageSnackBar(context, 'Your account was deleted successfully');
  //       print('Have signed user out');
  //     }
  //   }
  //   return error;
  // }

  // /// Define watchlist in firestore (mainly on signup) with empty data
  // Future<void> createStockWatchlist(String uid) async {
  //   await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('watchlist')
  //       .doc('watchlist')
  //       .set({'stock': [], 'crypto': []});
  // }

  // Future<void> createHypeDataList(String uid) async {
  //   await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('hypedData')
  //       .doc('hypedData')
  //       .set({'stock': [], 'crypto': []});
  // }

  // Future<void> saveStockwatchlist(String uid, List<String> watchlist) async {
  //   await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('watchlist')
  //       .doc('watchlist')
  //       .update({'stock': watchlist});
  // }

  // Future<void> saveCryptowatchlist(String uid, List<String> watchlist) async {
  //   await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('watchlist')
  //       .doc('watchlist')
  //       .update({'crypto': watchlist});
  // }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getWatchlist(
  //     String uid) async {
  //   return await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('watchlist')
  //       .doc('watchlist')
  //       .get();
  // }

  // Stream<QuerySnapshot> watchlistStream(String uid) {
  //   return _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('watchlist')
  //       .snapshots();
  // }

  // Stream<QuerySnapshot> profileStream(String uid) {
  //   return _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('profile')
  //       .snapshots();
  // }

  // Future<void> updateProfile(String uid, String name, String phone) async {
  //   if (name != null && phone != null) {
  //     await _firestore
  //         .collection('userData')
  //         .doc(uid)
  //         .collection('profile')
  //         .doc('profile')
  //         .update({'name': name, 'phone': phone});
  //   } else if (name != null && phone.isEmpty) {
  //     await _firestore
  //         .collection('userData')
  //         .doc(uid)
  //         .collection('profile')
  //         .doc('profile')
  //         .update({'name': name});
  //   } else if (name.isEmpty && phone != null) {
  //     await _firestore
  //         .collection('userData')
  //         .doc(uid)
  //         .collection('profile')
  //         .doc('profile')
  //         .update({'phone': phone});
  //   }
  // }

  // // Hypers
  // Future<void> saveFourChanData(FourChanHypers fourChanHypers) async {
  //   await _firestore
  //       .collection('fourchan')
  //       .doc(fourChanHypers.stockTicker)
  //       .set(fourChanHypers.toJson());
  // }

  // Future<FourChanHypers> get4ChanHypers(String ticker) async {
  //   return _firestore.collection('fourchan').doc(ticker).get().then((value) {
  //     if (value.exists) {
  //       int mentions = value.data()!['mentions'];
  //       int upvotes = value.data()!['upvotes'];
  //       int total = mentions + upvotes;
  //       String stockName = value.data()!['stockName'];
  //       return FourChanHypers(
  //           mentions: mentions,
  //           upvotes: upvotes,
  //           stockTicker: ticker,
  //           total: total,
  //           stockName: stockName);
  //     } else {
  //       return FourChanHypers(isAvailable: false);
  //     }
  //   });
  // }

  // Future<void> saveWSBetData(WSBetHypers wsBetHypers) async {
  //   await _firestore
  //       .collection('wsbet')
  //       .doc(wsBetHypers.stockTicker)
  //       .set(wsBetHypers.toJson());
  // }

  // Future<WSBetHypers> getWSBetHypers(String ticker) async {
  //   return _firestore.collection('wsbet').doc(ticker).get().then((value) {
  //     if (value.exists) {
  //       int mentions = value.data()!['mentions'];
  //       int votes = value.data()!['votes'];
  //       int comments = value.data()!['comments'];
  //       int total = mentions + comments + votes;
  //       String stockName = value.data()!['stockName'];
  //       return WSBetHypers(
  //           mentions: mentions,
  //           votes: votes,
  //           comments: comments,
  //           stockTicker: ticker,
  //           total: total,
  //           stockName: stockName);
  //     } else {
  //       return WSBetHypers(isAvailable: false);
  //     }
  //   });
  // }

  // Future<void> saveTelegramData(TelegramHypers telegramHypers) async {
  //   await _firestore
  //       .collection('telegram')
  //       .doc(telegramHypers.stockTicker)
  //       .set(telegramHypers.toJson());
  // }

  // Future<TelegramHypers> getTelegramHypers(String ticker) async {
  //   return _firestore.collection('telegram').doc(ticker).get().then((value) {
  //     if (value.exists) {
  //       return TelegramHypers.fromJson(value.data()!);
  //     } else {
  //       return TelegramHypers(isAvailable: false);
  //     }
  //   });
  // }

  // /// Check if email is admin
  // Future<bool> emailIsAdmin(String email) async {
  //   return _firestore.collection('admin').doc(email).get().then((value) {
  //     if (value.exists) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   });
  // }

  // /// Add a new email address as administrator
  // Future<void> addAdmin(String email, String setterEmail) async {
  //   return _firestore.collection('admin').doc(email).set({
  //     'email': email,
  //     'setter': setterEmail,
  //     'enabled': true,
  //   });
  // }

  // Future<void> updateHypersMeta(String hyperName, String email) async {
  //   await _firestore.collection('meta').doc(hyperName).set({
  //     'date': DateTime.now(),
  //     'email': email,
  //   });
  // }

  // Stream<DocumentSnapshot> hypersMetaStream(String hyperName) {
  //   return _firestore.collection('meta').doc(hyperName).snapshots();
  // }

  // // Banner Ads

  // Future<void> saveBannerAd(BannerAd bannerAd) async {
  //   await _firestore.collection('bannerAds').add(bannerAd.toJson());
  // }

  // Future<QuerySnapshot<Map<String, dynamic>>> getBannerAds() async {
  //   return await _firestore.collection('bannerAds').get();
  // }

  // Future<void> updateBannerAd(String documentId, BannerAd bannerAd) async {
  //   await _firestore
  //       .collection('bannerAds')
  //       .doc(documentId)
  //       .update(bannerAd.toJson());
  // }

  // Future<void> increaseBannerAdClickCount(String documentId) async {
  //   await _firestore
  //       .collection('bannerAds')
  //       .doc(documentId)
  //       .update({'numberOfClicks': FieldValue.increment(1)});
  // }

  // Future<void> deleteBannerAd(String documentId) async {
  //   await _firestore.collection('bannerAds').doc(documentId).delete();
  // }

  // // Trending Stocks and Cryptos

  // Future<void> updateTrendingUpdateTime() async {
  //   await _firestore.collection('trending').doc('lastupdated').set({
  //     'date': DateTime.now(),
  //   });
  // }

  // Future<DateTime?> getTrendingUpdateTime() async {
  //   DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  //       await _firestore.collection('trending').doc('lastupdated').get();
  //   return documentSnapshot.get('date').toDate();
  // }

  // Future<void> deleteTrendingData() async {
  //   await _firestore.collection('trending').doc('lastupdated').delete();
  // }

  // Future<void> saveHypeInvestorHypes(Stock stock) async {
  //   await _firestore
  //       .collection('hypeInvestor')
  //       .doc(stock.ticker)
  //       .get()
  //       .then((value) {
  //     num newHype = 1;
  //     if (value.exists) {
  //       final hype = newHype + value.data()!['total'];
  //       _firestore.collection('hypeInvestor').doc(stock.ticker).update({
  //         'total': hype,
  //       });
  //     } else {
  //       _firestore.collection('hypeInvestor').doc(stock.ticker).set({
  //         'total': newHype,
  //         'stockTicker': stock.ticker,
  //         'stockName': stock.name,
  //       });
  //     }
  //   }).catchError((err) {
  //     return;
  //   });
  // }

  // Future<void> deleteHypeInvestorHypes(Stock stock) async {
  //   await _firestore
  //       .collection('hypeInvestor')
  //       .doc(stock.ticker)
  //       .get()
  //       .then((value) {
  //     if (value.exists && value.data()!['total'] == 1) {
  //       _firestore.collection('hypeInvestor').doc(stock.ticker).delete();
  //     } else {
  //       int removeHype = 1;
  //       final hype = value.data()!['total'] - removeHype;
  //       _firestore.collection('hypeInvestor').doc(stock.ticker).update({
  //         'total': hype,
  //       });
  //     }
  //   }).catchError((err) {
  //     return;
  //   });
  // }

  // Future<void> saveTrendingStock(List<Stock> trendingStock) async {
  //   await _firestore
  //       .collection('trending')
  //       .doc('stocks')
  //       .set({'stocks': trendingStock.map((e) => e.toJson()).toList()});
  // }

  // Future<List<Stock>?> fetchTrendingStock() async {
  //   return _firestore.collection('trending').doc('stocks').get().then((value) {
  //     if (value.exists) {
  //       List<dynamic> unParsedList = value.data()!['stocks'];
  //       List<Stock> stocks =
  //           unParsedList.map((e) => Stock.formJson(e)).toList();
  //       return stocks;
  //     } else {
  //       return null;
  //     }
  //   });
  // }

  // Future<void> saveTrendingCryptos(List<Stock> trendingCryptos) async {
  //   await _firestore
  //       .collection('trending')
  //       .doc('cryptos')
  //       .set({'cryptos': trendingCryptos.map((e) => e.toJson()).toList()});
  // }

  // Future<List<Stock>?> fetchTrendingCryptos() async {
  //   return _firestore.collection('trending').doc('cryptos').get().then((value) {
  //     if (value.exists) {
  //       List<dynamic> unParsedList = value.data()!['cryptos'];
  //       List<Stock> stocks =
  //           unParsedList.map((e) => Stock.formJson(e)).toList();
  //       return stocks;
  //     } else {
  //       return null;
  //     }
  //   });
  // }

  // Future<void> saveStockHistory(String ticker, DateTime dateTime,
  //     Map<String, dynamic> totalHypers) async {
  //   bool updatedToday = await stockUpdatedToday(ticker);
  //   log('updatedToday?: $updatedToday');
  //   try {
  //     if (!updatedToday) {
  //       await _firestore
  //           .collection('history')
  //           .doc(ticker)
  //           .collection(ticker)
  //           .doc(dateTime.toIso8601String())
  //           .set({
  //         ...TotalHypers().toJson(totalHypers),
  //         'day': dateTime.toIso8601String()
  //       });
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // Future<bool> stockUpdatedToday(String ticker) async {
  //   try {
  //     String lastUpdatedDateString = await _firestore
  //         .collection('history')
  //         .doc(ticker)
  //         .collection(ticker)
  //         .orderBy('day', descending: true)
  //         .limit(1)
  //         .get()
  //         .then((value) => value.docs.first.data()['day']);
  //     DateTime lastUpdated = DateTime.parse(lastUpdatedDateString);
  //     DateTime now = DateTime.now();

  //     bool isSameYear = lastUpdated.year == now.year;
  //     bool isSameMonth = lastUpdated.month == now.month;
  //     bool isSameDay = lastUpdated.day == now.day;

  //     if (isSameYear && isSameMonth && isSameDay) {
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     log(e.toString());
  //     return false;
  //   }
  // }

  // Future<List<QueryDocumentSnapshot>> getHypersHistory(String ticker) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
  //       .collection('history')
  //       .doc(ticker)
  //       .collection(ticker)
  //       .get();
  //   return querySnapshot.docs;
  // }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getHypedList(
  //     String uid) async {
  //   return await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('hypedData')
  //       .doc('hypedData')
  //       .get();
  // }

  // Future<void> saveHypedStock(String uid, List<String> hypedStock) async {
  //   await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('hypedData')
  //       .doc('hypedData')
  //       .get()
  //       .then((value) => {
  //             if (value.exists)
  //               {
  //                 _firestore
  //                     .collection('userData')
  //                     .doc(uid)
  //                     .collection('hypedData')
  //                     .doc('hypedData')
  //                     .update({'stock': hypedStock})
  //               }
  //             else
  //               {
  //                 _firestore
  //                     .collection('userData')
  //                     .doc(uid)
  //                     .collection('hypedData')
  //                     .doc('hypedData')
  //                     .set({'stock': hypedStock})
  //               }
  //           });
  // }

  // Future<void> saveHypedCrypto(String uid, List<String> hypedCrypto) async {
  //   await _firestore
  //       .collection('userData')
  //       .doc(uid)
  //       .collection('hypedData')
  //       .doc('hypedData')
  //       .get()
  //       .then((value) => {
  //             if (value.exists)
  //               {
  //                 _firestore
  //                     .collection('userData')
  //                     .doc(uid)
  //                     .collection('hypedData')
  //                     .doc('hypedData')
  //                     .update({'crypto': hypedCrypto})
  //               }
  //             else
  //               {
  //                 _firestore
  //                     .collection('userData')
  //                     .doc(uid)
  //                     .collection('hypedData')
  //                     .doc('hypedData')
  //                     .set({'crypto': hypedCrypto})
  //               }
  //           });
  // }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getHypeInvestorHypers(
  //     Stock stock) async {
  //   return await _firestore.collection('hypeInvestor').doc(stock.ticker).get();
  // }

  // Future<String> fetchTotalNumOfUser() async {
  //   var user = 0;
  //   await FirebaseFirestore.instance
  //       .collection('totalNumOfUsers')
  //       .doc('userCount')
  //       .get()
  //       .then((value) async {
  //     if (value.data() != null) {
  //       user = value.data()!['total'];
  //       return user.toString();
  //     } else {
  //       return null;
  //     }
  //   }).catchError((err) {
  //     return null;
  //   });
  //   return user.toString();
  // }

  // Future<void> saveToTotalNumOfUser() async {
  //   await _firestore
  //       .collection('totalNumOfUsers')
  //       .doc('userCount')
  //       .get()
  //       .then((value) {
  //     num newUser = 1;
  //     if (value.data() != null) {
  //       final user = newUser + value.data()!['total'];
  //       _firestore.collection('totalNumOfUsers').doc('userCount').update({
  //         'total': user,
  //       });
  //     } else {
  //       _firestore.collection('totalNumOfUsers').doc('userCount').set({
  //         'total': newUser,
  //       });
  //     }
  //   }).catchError((err) {
  //     return;
  //   });
  // }

  // Stream<QuerySnapshot> getComments(String uid, Stock stock) {
  //   _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .get()
  //       .then((value) => {print('value ${value.data()}')});
  //   return _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .collection('allcomments')
  //       .snapshots();
  // }

  // Future<DocumentSnapshot<Map<Object, dynamic>>> getReplies(
  //     String messageId, Stock stock) {
  //   _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .get()
  //       .then((value) => {print('value ${value.data()}')});
  //   return _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .collection('allcomments')
  //       .doc(messageId)
  //       .get();
  // }

  // Future<void> saveComments(Stock stock, comment, uid) async {
  //   print(comment);
  //   String commentTime = DateTime.now().toString();
  //   String messageId = DateTime.now().microsecondsSinceEpoch.toString();
  //   await _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .collection('allcomments')
  //       .doc(messageId)
  //       .set({
  //     'stockName': stock.name,
  //     'stockTicker': stock.ticker,
  //     'isCrypto': stock.isCrypto,
  //     'name': _auth.currentUser!.displayName,
  //     'messageText': comment,
  //     'messageId': messageId,
  //     'likes': [],
  //     'dislikes': [],
  //     'imageURL': 'https//image.com',
  //     'time': commentTime,
  //     'uid': uid,
  //     'reply': []
  //   });
  // }

  // Future<void> saveReplies(
  //   Stock stock,
  //   String replyId,
  //   uid,
  //   reply,
  // ) async {
  //   print(reply);
  //   String replyTime = DateTime.now().toString();
  //   // String replyId = DateTime.now().microsecondsSinceEpoch.toString();

  //   var valuesMap = new Map<String, dynamic>();

  //   valuesMap['name'] = _auth.currentUser!.displayName;
  //   valuesMap['reply'] = reply;
  //   valuesMap['imageUrl'] = 'https//image.com';
  //   valuesMap['time'] = replyTime;

  //   await _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .collection("allcomments")
  //       .doc(replyId)
  //       .set({
  //     "reply": FieldValue.arrayUnion([valuesMap])
  //   }, SetOptions(merge: true));
  // }

  // Future<void> saveLikes(
  //   Stock stock,
  //   uid,
  //   String messageId,
  // ) async {
  //   var valuesMap = new Map<String, dynamic>();
  //   valuesMap['uid'] = uid;

  //   await _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .collection("allcomments")
  //       .doc(messageId)
  //       .set({
  //     "likes": FieldValue.arrayUnion([valuesMap])
  //   }, SetOptions(merge: true));
  // }

  // Future<void> removeLikes(
  //   Stock stock,
  //   uid,
  //   String messageId,
  // ) async {
  //   var valuesMap = new Map<String, dynamic>();
  //   valuesMap['uid'] = uid;

  //   await _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .collection("allcomments")
  //       .doc(messageId)
  //       .update(
  //     {
  //       "likes": FieldValue.arrayRemove([valuesMap])
  //     },
  //   );
  // }

  // Future<void> removeDislikes(
  //   Stock stock,
  //   uid,
  //   String messageId,
  // ) async {
  //   var valuesMap = new Map<String, dynamic>();
  //   valuesMap['uid'] = uid;

  //   await _firestore
  //       .collection('comments')
  //       .doc(stock.ticker)
  //       .collection("allcomments")
  //       .doc(messageId)
  //       .update(
  //     {
  //       "dislikes": FieldValue.arrayRemove([valuesMap])
  //     },
  //   );
  // }
}
