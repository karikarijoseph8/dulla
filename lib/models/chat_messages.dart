class ChatMessageEntity {
  final String message;
  final bool isSender;
  final String senderID;
  final String messageID;
  final DateTime timeStamp;

  ChatMessageEntity({
    required this.message,
    required this.isSender,
    required this.senderID,
    required this.messageID,
    required this.timeStamp,
  });
}
