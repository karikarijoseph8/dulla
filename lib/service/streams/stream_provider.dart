import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbit/data/hive/hive_boxes.dart';
import 'package:orbit/data/hive/userhive.dart';
import 'package:orbit/models/entities/address_entity.dart';
import '../../models/chat_messages.dart';
import '../../models/entities/booking_entity.dart';
import '../../models/entities/user_entity.dart';
import '../../models/entities/wallet_entity.dart';

abstract class Database {
  // Stream<List<BetCodeStreamEntity>> getBetCodes();
  // Stream<List<CommentStreamEntity>> getCommentFromBetCodes(String docID);
  // Stream<LikesStreamEntity> getLikesfromCommentID(
  //     String betCodeID, String uID, String commentID);
  // Stream<UserNameEntity> getUserNameFromUsers(String userID);
  // Stream<List<ReplyStreamEntity>> getReplyFromCommentID(
  //   String betCodeID,
  //   String commentID,
  // );
  // Stream<List<PredictionStreamEntity>> getPredictions();
  // Stream<List<NoRisStremEntity>> getNoRisk();
  Stream<UserEntity> getUserData(String userID);
  Stream<Wallet> getWalletData(String userID);
  Stream<List<WalletTransaction>> getTransactionHistory(String userID);
  Stream<List<BookingEntity>> getMyBooking(String userId);
  Stream<List<ChatMessageEntity>> getDriverChat(String userId, String driverID);
  Stream<List<ChatMessageEntity>> getCustomerCareChat(String userId);
  Stream<List<AddressEntity>> getUserAddress(String userId);
  //Stream<List<CarCategoryEntity>> getCarCategory();

  //Stream<List<NotificationStreamEntity>> getNotification();
}

class FirestoreDatabase implements Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream<UserEntity> getUserData(userID) {
  //   return _firestore
  //       .collection('userData')
  //       .doc(userID)
  //       .snapshots()
  //       .map((event) {
  //     final data = event.data();
  //     return UserNameEntity(
  //       userName: data!['userName'] ?? '',
  //     );
  //   });
  // }

  Stream<UserEntity> getUserData(userID) {
    return _firestore
        .collection('userData')
        .doc(userID)
        .snapshots()
        .map((event) {
      final data = event.data();
      // print(data);
      final userHive = UserHive(
        user_ID: data!['user_ID'] ?? '',
        full_name: data['full_name'] ?? '',
        photoURL: data['photoURL'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        blocked: data['blocked'],
        signUpComplete: data['signUpComplete'],
        deleted_account: data['deleted_account'],
        permanently_blocked: data['permanently_blocked'],
        emailAuth: data['emailAuth'],
        phoneAuth: data['phoneAuth'],
        googleAuth: data['googleAuth'],
        userRating: data['userRating'] ?? 3.3,
      );

      boxUserHive.put(userHive.user_ID, userHive);

      return UserEntity(
        user_ID: data['user_ID'] ?? '',
        full_name: data['full_name'] ?? '',
        photoURL: data['photoURL'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        blocked: data['blocked'],
        signUpComplete: data['signUpComplete'],
        deleted_account: data['deleted_account'],
        permanently_blocked: data['permanently_blocked'],
        emailAuth: data['emailAuth'],
        phoneAuth: data['phoneAuth'],
        googleAuth: data['googleAuth'],
        userRating: data['userRating'] ?? 3.3,
      );
    });
  }

  Stream<Wallet> getWalletData(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      return Wallet(
        userId: data['userId'],
        balance: data['balance'], walletID: data['walletID'],
        // transactionHistory: [], // You'll fetch transactions separately.
      );
    });
  }

  Stream<List<WalletTransaction>> getTransactionHistory(String walletUserId) {
    return _firestore
        .collection('wallets')
        .doc(walletUserId)
        .collection('transactionHistory')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      final List<WalletTransaction> transactions = [];
      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        transactions.add(WalletTransaction(
          transactionID: data['transactionID'],
          discountedAmount: data['discountedAmount'] ?? 0.0,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          description: data['description'],
          transactionNameDriverName: data['transactionNameDriverName'] ?? '',
          transactionType: data['transactionType'],
          discount: data['discount'] ?? 0.0,
          originalAmount: data['originalAmount'] ?? 0.0,
          paymentMethod: data['paymentMethod'] ?? '',
          status: data['status'] ?? '',
          //driver
          driverImg: data['driverImg'] ?? '',
          driverCarName: data['driverCarName'] ?? '',
          driverNumberPlate: data['driverNumberPlate'] ?? '',
          driverRating: data['driverRating'] ?? 0.0,
        ));
      }
      return transactions;
    });
  }

  Stream<List<BookingEntity>> getMyBooking(String userId) {
    return _firestore
        .collection('userData')
        .doc(userId)
        .collection('myBookings')
        // .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      final List<BookingEntity> mybookings = [];
      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        mybookings.add(BookingEntity(
          //driver
          driverName: data['driverName'],
          driverImg: data['driverImg'],
          driverCarName: data['driverCarName'],
          driverPlateNumber: data['driverPlateNumber'],
          //trip
          distance: data['distance'],
          time: data['time'],
          tripFare: data['tripFare'],
          tripStatus: data['tripStatus'],
          timeStamp: (data['timeStamp'] as Timestamp).toDate(),
          //pickUp
          pictLocationName: data['pictLocationName'],
          pictLocationAddress: data['pictLocationAddress'],
          pictLocationLatitude: data['pictLocationLatitude'],
          pictLocationLongitube: data['pictLocationLongitube'],
          //destination
          destinationName: data['destinationName'],
          destinationAddress: data['destinationAddress'],
          destinationLatitube: data['destinationLatitube'],
          destinationLongitube: data['destinationLongitube'],
          mybookingID: data['mybookingID'],
        ));
      }
      return mybookings;
    });
  }

/////////////////////////////////////////////////
//////////////////////CHAT DATA/////////////////////
/////////////////////////////////////////////////

  Stream<List<ChatMessageEntity>> getDriverChat(
      String userId, String driverID) {
    print("Printing UID in stream: $userId");
    return _firestore
        .collection('driverData')
        .doc(driverID)
        .collection('chatData')
        .doc(userId)
        .collection('chatMsg')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      final List<ChatMessageEntity> chats = [];
      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        bool isSender = false;

        if (data['senderID'] == userId) {
          isSender = true;

          print("isSender");
          print(isSender);
        }

        chats.add(ChatMessageEntity(
          timeStamp: (data['timeStamp'] as Timestamp).toDate(),
          message: data['message'],
          senderID: data['senderID'],
          isSender: isSender,
          messageID: data['messageID'],
        ));
      }

      print("printing chat: $chats");
      return chats;
    });
  }

  Stream<List<ChatMessageEntity>> getCustomerCareChat(String userId) {
    print("Printing UID in stream: $userId");
    return _firestore
        .collection('appData')
        .doc('helpCenter')
        .collection('customerCareChat')
        .doc(userId)
        .collection('chatData')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      final List<ChatMessageEntity> chats = [];
      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        bool isSender = false;

        if (data['senderID'] == userId) {
          isSender = true;

          print("isSender");
          print(isSender);
        }

        chats.add(ChatMessageEntity(
          timeStamp: (data['timeStamp'] as Timestamp).toDate(),
          message: data['message'],
          senderID: data['senderID'],
          isSender: isSender,
          messageID: data['messageID'],
        ));
      }

      print("printing chat: $chats");
      return chats;
    });
  }

  Stream<List<AddressEntity>> getUserAddress(String userId) {
    return _firestore
        .collection('userData')
        .doc(userId)
        .collection('address')
        // .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      final List<AddressEntity> myAddress = [];
      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        myAddress.add(AddressEntity(
          //driver
          addressName: data['addressName'],
          addressDetail: data['addressDetail'],
          addressID: data['addressID'],
          addressLatitude: data['addressLatitude'],
          //trip
          addressLongitutde: data['addressLongitutde'],
        ));
      }
      return myAddress;
    });
  }

  /////////////////////////////////////////
  /////////
  ////////
  ////////////////////////////////////////
  /////////////////////////////////////////
  /////////////////////////////////////////
  /////////////////////////////////////////
  /////////////////////////////////////////

  // Stream<List<CarCategoryEntity>> getCarCategory() {
  //   return _firestore
  //       .collection('appData')
  //       .doc('tripUtilities')
  //       .collection('CarCategory')
  //       //.orderBy('timePosted', descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) =>
  //           querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
  //             print("object Data ${documentSnapshot['distanceAway']}");
  //             return CarCategoryEntity(
  //               categoryName: documentSnapshot['categoryName'] ?? '',
  //               description: documentSnapshot['description'] ?? '',
  //               baseFare: documentSnapshot['baseFare'] ?? 0.0,
  //               perKilometerRate: documentSnapshot['perKilometerRate'] ?? 0.0,
  //               perMinuteRate: documentSnapshot['perMinuteRate'] ?? 0.0,
  //               capacity: documentSnapshot['capacity'] ?? '4',
  //               imageURL: documentSnapshot['imageURL'] ?? '',
  //               availability: documentSnapshot['availability'] ?? false,
  //               best_save: documentSnapshot['best_save'] ?? false,
  //               availableCars: documentSnapshot['availableCars'] ?? 0,
  //               distanceAway: documentSnapshot['distanceAway'] ?? 0,
  //             );
  //           }).toList());
  // }

  // Stream<List<PredictionStreamEntity>> getPredictions() {
  //   return _firestore
  //       .collection('PREDICTIONS')
  //       .orderBy('timestamp', descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) =>
  //           querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
  //             return PredictionStreamEntity(
  //               game: documentSnapshot['game'],
  //               league: documentSnapshot['league'],
  //               odds: documentSnapshot['odds'],
  //               status: documentSnapshot['status'],
  //               date: documentSnapshot['timestamp'].toDate(),
  //               tip: documentSnapshot['tip'],
  //             );
  //           }).toList());
  // }

  // Stream<List<NoRisStremEntity>> getNoRisk() {
  //   return _firestore.collection('BET_OF_THE_DAY').snapshots().map(
  //       (QuerySnapshot querySnapshot) =>
  //           querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
  //             return NoRisStremEntity(
  //               game: documentSnapshot['game'],
  //               league: documentSnapshot['league'],
  //               odds: documentSnapshot['odds'],
  //               status: documentSnapshot['status'],
  //               date: documentSnapshot['timestamp'].toDate(),
  //               tip: documentSnapshot['tip'],
  //             );
  //           }).toList());
  // }

  // Stream<List<NotificationStreamEntity>> getNotification() {
  //   return _firestore
  //       .collection('NOTIFICATIONS')
  //       .orderBy('timePosted', descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) =>
  //           querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
  //             return NotificationStreamEntity(
  //               title: documentSnapshot['title'],
  //               body: documentSnapshot['body'],
  //               date: documentSnapshot['timePosted'].toDate(),
  //               type: documentSnapshot['type'],
  //             );
  //           }).toList());
  // }

  // Stream<List<CommentStreamEntity>> getCommentFromBetCodes(docID) {
  //   return _firestore
  //       .collection('BetCodes')
  //       .doc(docID)
  //       .collection('Comments')
  //       .orderBy('timePosted', descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) => querySnapshot.docs
  //           .map((DocumentSnapshot documentSnapshot) => CommentStreamEntity(
  //                 betCode: documentSnapshot['betCode'],
  //                 comment: documentSnapshot['comment'],
  //                 likesCount:
  //                     documentSnapshot.data().toString().contains('likesCount')
  //                         ? documentSnapshot['likesCount']
  //                         : 0,
  //                 replyCount:
  //                     documentSnapshot.data().toString().contains('replyCount')
  //                         ? documentSnapshot['replyCount']
  //                         : 0,
  //                 timePosted: documentSnapshot['timePosted'].toDate(),
  //                 userID: documentSnapshot['userID'],
  //                 commentID:
  //                     documentSnapshot.data().toString().contains('commentID')
  //                         ? documentSnapshot['commentID']
  //                         : documentSnapshot.id,
  //               ))
  //           .toList());
  // }

  // Stream<List<ReplyStreamEntity>> getReplyFromCommentID(
  //     String betCodeID, String commentID) {
  //   return _firestore
  //       .collection('BetCodes')
  //       .doc(betCodeID)
  //       .collection('Comments')
  //       .doc(commentID)
  //       .collection('Replies')
  //       .orderBy('timePosted', descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) => querySnapshot.docs
  //           .map((DocumentSnapshot documentSnapshot) => ReplyStreamEntity(
  //                 betCode: documentSnapshot['betCode'],
  //                 commentID: documentSnapshot['commentID'],
  //                 reply: documentSnapshot['reply'],
  //                 timePosted: documentSnapshot['timePosted'].toDate(),
  //                 userID: documentSnapshot['userID'],
  //               ))
  //           .toList());
  // }

  // Stream<LikesStreamEntity> getLikesfromCommentID(
  //     String betCodeID, String uID, String commentID) {
  //   return _firestore
  //       .collection('BetCodes')
  //       .doc(betCodeID)
  //       .collection('Comments')
  //       .doc(commentID)
  //       .collection('Likes')
  //       .doc(uID)
  //       .snapshots()
  //       .map((likeData) {
  //     final like = likeData.data();
  //     return LikesStreamEntity(
  //       likeStatus: like!['likeStatus'],
  //     );
  //   });
  // }

  // Stream<UserNameEntity> getUserNameFromUsers(userID) {
  //   return _firestore.collection('Users').doc(userID).snapshots().map((event) {
  //     final data = event.data();
  //     return UserNameEntity(
  //       userName: data!['userName'] ?? '',
  //     );
  //   });
  // }

  // Stream<UserDataStreamEntity> getUserDataFromUserID(userID) {
  //   return _firestore.collection('Users').doc(userID).snapshots().map((event) {
  //     final data = event.data();
  //     return UserDataStreamEntity(
  //       blocked: data!['blocked'],
  //       blockedPermanently: data['blockedPermanently'],
  //       codesPerDay: data['codesPerDay'],
  //       codesToday: data['codesToday'],
  //       id: data['id'],
  //       lastOnline: data['lastOnline'].toDate(),
  //       limited: data['limited'],
  //       userName: data['userName'] ?? '',
  //     );
  //   });
  // }

  // Future<bool> checkifCommentsExist(String docID) async {
  //   var commentsExist = await _firestore
  //       .collection('BetCodes')
  //       .doc(docID)
  //       .collection('Comments')
  //       .limit(1)
  //       .get();
  //   return commentsExist.docs.isNotEmpty;
  // }
}
