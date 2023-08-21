import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scholar_app/firebase/fb_firestore.dart';
import 'package:scholar_app/firebase/firebase_auth.dart';
import 'package:scholar_app/models/messages.dart';
import 'package:scholar_app/utils/constants.dart';
import 'package:scholar_app/utils/helper.dart';

import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with Helper {
  late TextEditingController _content;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _content = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _content.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('messages');

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: KprimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(KLogo, width: 60),
              const Text(
                'Chat',
                style: TextStyle(
                    fontFamily: 'Pacifico-Regular',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FBFirestore().read(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Column(children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var content = snapshot.data!.docs[index];
                      return content['email'] == message.email
                          ? ChatBubble(content: content['content'])
                          : ChatBubble(
                              content: content['content'],
                              bottomLeft: 30,
                              bottomRight: 0,
                              color: const Color(0xff006d84),
                              alignment: Alignment.centerRight,
                            );
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (data) async {
                      await performSendMessage();
                      _content.clear();
                      scrollToTheLastMessage();
                    },
                    controller: _content,
                    decoration: InputDecoration(
                        hintText: 'Send message',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              await performSendMessage();
                              _content.clear();
                              scrollToTheLastMessage();
                            },
                            icon: const Icon(
                              Icons.send,
                              color: KprimaryColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: KprimaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: KprimaryColor,
                          ),
                        )),
                  ),
                )
              ]);
            } else {
              return const Center(child: Text('Start chatting with friends'));
            }
          },
        ));
  }

  Future<void> performSendMessage() async {
    if (checkData()) {
      await send();
    } else {
      showSnackBar(
          context: context, content: 'unable to send message', error: true);
    }
  }

  bool checkData() {
    if (_content.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> send() async {
    bool status = await FBFirestore().create(message: message);
    if (!status) {
      showSnackBar(
          context: context, content: 'Failed send message', error: true);
    }
  }

  Message get message {
    Message message = Message();
    message.content = _content.text;
    message.time = DateTime.now().toString();
    message.email = FBAuthController().email!;
    return message;
  }

  Message getMessages(QueryDocumentSnapshot snapshot) {
    Message message = Message();
    message.content = snapshot.get('content');
    message.time = snapshot.get('time');
    message.email = snapshot.get('email');
    return message;
  }

  void scrollToTheLastMessage() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }
}
