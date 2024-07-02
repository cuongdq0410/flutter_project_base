import 'package:flutter/material.dart';
import 'package:flutter_bloc_base/generated/l10n.dart';

class ChatScreenArgs {
  final String chatId;
  final String chatName;

  ChatScreenArgs({required this.chatId, required this.chatName});
}

class ChatScreen extends StatelessWidget {
  final String? chatId;
  final String? chatName;
  final ChatScreenArgs? chatScreenArgs;

  const ChatScreen({
    super.key,
    this.chatId,
    this.chatName,
    this.chatScreenArgs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chat $chatId'),
            Text('Chat Name $chatName'),
            Text('Language ${S.current.english}'),
            Text(
                'Extra Data ${chatScreenArgs?.chatId} - ${chatScreenArgs?.chatName}'),
          ],
        ),
      ),
    );
  }
}
