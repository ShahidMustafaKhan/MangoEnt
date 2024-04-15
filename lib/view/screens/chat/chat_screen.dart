import 'package:flutter/material.dart';

import '../../widgets/base_scaffold.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);


  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
            child: Text(
              "Chat screen",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ))
      ],
    );
  }
}
