import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  final String chatId;

  const ConversationPage({super.key, required this.chatId});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  void sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    final message = {
      'text': _messageController.text,
      'senderId': currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    };

    // Save the message in the sender's chat collection
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add(message);

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.chatId)
        .collection('chats')
        .doc(currentUser!.uid)
        .collection('messages')
        .add(message);

    _messageController.clear();
  }

  void markMessagesAsRead() async {
    final QuerySnapshot unreadMessages = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .where('read', isEqualTo: false)
        .get();

    for (var doc in unreadMessages.docs) {
      await doc.reference.update({'read': true});
    }
  }

  @override
  void initState() {
    super.initState();
    markMessagesAsRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser!.uid)
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet'));
                }

                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    var isCurrentUser = data['senderId'] == currentUser!.uid;
                    return ListTile(
                      title: Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? AppTheme.colors.primary
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['text'],
                                style: TextStyle(color: Colors.white),
                              ),
                              if (!isCurrentUser && !data['read'])
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Unread',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
