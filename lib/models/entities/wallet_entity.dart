class Wallet {
  final String userId;
  final String walletID;
  final double balance; // The current balance in the wallet.

  Wallet({
    required this.userId,
    required this.walletID,
    required this.balance,
    //required this.transactionHistory,
  });
}

class WalletTransaction {
  final String transactionID; // Unique identifier for the transaction.
  final double originalAmount;
  final String transactionNameDriverName;
  final String transactionType;
  final DateTime timestamp;
  final String description;
  final String status;
  final String paymentMethod;
  final double discount;
  final double discountedAmount;
  //Driver
  final String driverImg;
  final String driverCarName;
  final String driverNumberPlate;
  final double driverRating;

  WalletTransaction({
    required this.status,
    required this.paymentMethod,
    required this.discount,
    required this.discountedAmount,
    required this.transactionNameDriverName,
    required this.transactionType,
    required this.transactionID,
    required this.originalAmount,
    required this.timestamp,
    required this.description,
    //driver
    required this.driverImg,
    required this.driverCarName,
    required this.driverNumberPlate,
    required this.driverRating,
  });
}


  // final Widget img;
  // final String transactionIcon;
  // final String name;
  // final String transactionType;
  // final String date;
  // final VoidCallback onPressed;