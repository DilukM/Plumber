import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumber/Pages/conversation.dart';
import 'package:plumber/components/contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> getUserInfo(String jobCreatorId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(jobCreatorId)
        .get();

    int unreadCount = 0;
    QuerySnapshot unreadMessages = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .doc(jobCreatorId)
        .collection('messages')
        .where('read', isEqualTo: false)
        .get();

    unreadCount = unreadMessages.docs.length;

    if (userDoc.exists) {
      return {
        'name': userDoc['firstname'] + ' ' + userDoc['lastname'],
        'unreadCount': unreadCount,
      };
    } else {
      return {
        'name': 'Unknown User',
        'unreadCount': unreadCount,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.white),
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
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Placeholder while loading
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return FutureBuilder<Map<String, dynamic>>(
                        future: getUserInfo(doc['role'] == 'applicant'
                            ? doc['jobCreatorId']
                            : doc['applicantId']),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListTile(
                              title: Text('Loading...'),
                              subtitle: Text(doc["jobTitle"]),
                              leading: Image.asset('assets/jobCover.jpg'),
                            );
                          }
                          if (userSnapshot.hasError) {
                            return ListTile(
                              title: Text('Error'),
                              subtitle: Text(doc["jobTitle"]),
                              leading: Image.asset('assets/jobCover.jpg'),
                            );
                          }
                          return Contact(
                            delete: () => deleteChat(doc.id),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConversationPage(chatId: doc.id)));
                            },
                            Name: userSnapshot.data?['name'] ?? 'Unknown User',
                            lastmsg: doc["jobTitle"],
                            cover: Image.asset('assets/jobCover.jpg'),
                            unreadCount: userSnapshot.data?['unreadCount'] ?? 0,
                          );
                        },
                      );
                    }).toList(),
                  );
                }
                return Center(child: Text('No chats found.'));
              },
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  void deleteChat(String chatId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('chats')
          .doc(chatId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chat deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete chat: $e')),
      );
    }
  }
}
