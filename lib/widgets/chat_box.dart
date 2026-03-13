import 'package:docu_sync/models/user_model.dart';
import 'package:docu_sync/widgets/messages_box.dart';
import 'package:flutter/material.dart';
import '../repository/socket_repository.dart';

class ChatBox extends StatefulWidget {
  final SocketRepository socketRepository;
  final String docId;

  final UserModel user;

  const ChatBox({
    super.key,
    required this.socketRepository,
    required this.docId, required this.user,
  });

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
void dispose() {
  widget.socketRepository.removeChatListener();
  messageController.dispose();
  super.dispose();
}

  @override
  void initState() {
    super.initState();

    widget.socketRepository.chatListener((data) {
      print("chat msg recived");
      setState(() {
        messages.add(data);
      });
    });
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final msg = {
      "room": widget.docId,
      "message": messageController.text,
      "name": widget.user.name,
      "uid": widget.user.uid
    };

    widget.socketRepository.sendChat(msg);

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
       borderRadius: BorderRadius.circular(12),
  elevation: 10,
      child: Container(
        width: 400,
    height:  MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Document Chat",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),


    //             IconButton(
    //              icon: const Icon(Icons.close),
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    // )
              ],
            ),
      
            const Divider(),
      
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
      
                  final isSent = widget.user.uid == msg['uid'];

                  return isSent ?  SentMessageBox(message: msg["message"], name: msg["name"])  : MessageBox(message: msg["message"], name: msg["name"]);
                },
              ),
            ),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Send message...",
                    ),
                  ),
                ),
      
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}