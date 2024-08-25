import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_bot/providers/get_all_msgs_provider.dart';
import 'package:gemini_chat_bot/widgets/message_tile.dart';

class MessageList extends ConsumerWidget {
  const MessageList({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageData = ref.watch(getAllMessageProvider(userId));

    return messageData.when(data: (messages) {
      return ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages.elementAt(index);

          return MessageTile(
            isOutgoing: message.isMine,
            message: message,
          );
        },
      );
    }, error: (error, stackTrace) {
      return Center(
        child: Text(error.toString()),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
