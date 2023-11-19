import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/chat_messages.dart';
import 'package:provider/provider.dart';

import '../../../service/providers/auth_service.dart';
import '../../../service/providers/firebase_service.dart';
import '../../../service/streams/stream_provider.dart';

class CustomerCareScreen extends StatefulWidget {
  @override
  _CustomerCareScreenState createState() => _CustomerCareScreenState();
}

class _CustomerCareScreenState extends State<CustomerCareScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatMessageEntity> _chatMessages = [
    // ChatMessage(
    //     text: "I am a Customer Service, is there anything I can help you with!",
    //     isSender: true,
    //     timeSent: DateTime.now()),
    // ChatMessage(text: "Hello!", isSender: true, timeSent: DateTime.now()),
    // ChatMessage(
    //     text:
    //         "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.!",
    //     isSender: true,
    //     timeSent: DateTime.now()),
    // ChatMessage(
    //     text: "Of course...!", isSender: false, timeSent: DateTime.now()),
    // ChatMessage(
    //     text: "Can you help!", isSender: true, timeSent: DateTime.now()),
    // ChatMessage(
    //     text: "Hi, I'm having a problem with my payment!",
    //     isSender: true,
    //     timeSent: DateTime.now()),
    // ChatMessage(
    //     text: "Hello Good morning!", isSender: false, timeSent: DateTime.now()),
    // ChatMessage(
    //     text: "I am a Customer Service, is there anything I can help you with!",
    //     isSender: false,
    //     timeSent: DateTime.now()),
    // Add more messages to the list as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Customer Care",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/svgIcons/Call.svg",
                width: 20,
              ),
              onPressed: () {
                // Add your search functionality here
              },
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: ChatGenerator()),
          _buildMessageInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (message) {
                  // _sendMessage();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFAFAFA),
                  hintStyle: CustomFonts.urbanist(
                      color: Color(0xFF9E9E9E), fontSize: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixStyle: CustomFonts.urbanist(fontSize: 16),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIconColor: Colors.amber,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  hintText: 'Message...',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mainYellow,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(context, _messageController.text.trim());
                    _messageController.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _sendMessage(BuildContext context, msg) async {
  final FirestoreService firestoreService = context.read<FirestoreService>();
  final AuthService auth = context.read<AuthService>();

  await firestoreService.sendCustomerCareChat(auth.getCurrentUser()!.uid, msg);
}

class ChatGenerator extends StatefulWidget {
  const ChatGenerator({super.key});

  @override
  State<ChatGenerator> createState() => _ChatGeneratorState();
}

class _ChatGeneratorState extends State<ChatGenerator> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final AuthService auth = context.read<AuthService>();
    return StreamBuilder<List<ChatMessageEntity>>(
        stream: db.getCustomerCareChat(auth.getCurrentUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chatData = snapshot.data;

            print(chatData!);

            return ListView.builder(
              reverse: true, // To show new messages at the bottom
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                ChatMessageEntity message = chatData[index];
                return _buildMessageItem(message);
              },
            );
            // return Text("data");
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text("Error While ${snapshot.error}"),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildMessageItem(ChatMessageEntity message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: message.isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: message.isSender
                  ? AppColors.mainYellow
                  : AppColors.greyMessages,
              borderRadius: BorderRadius.only(
                  topLeft: message.isSender
                      ? Radius.circular(15)
                      : Radius.circular(0),
                  topRight: message.isSender
                      ? Radius.circular(0)
                      : Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    message.message,
                    style: TextStyle(color: AppColors.mainBlack, height: 1.5),
                  ),
                ),
                Text(
                  _formatTime(message.timeStamp),
                  style: TextStyle(
                    color: AppColors.greyMessages2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
          // Text(
          //   _formatTime(message.timeSent),
          //   style: TextStyle(color: Colors.grey),
          // ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
