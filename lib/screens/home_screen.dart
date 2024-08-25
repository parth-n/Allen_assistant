import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_bot/providers/provider.dart';
import 'package:gemini_chat_bot/screens/send_image_screen.dart';
import 'package:gemini_chat_bot/widgets/message_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _messageController;
  final apikey = dotenv.env['API_KEY'] ?? '';

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
                onPressed: () {
                  ref.read(authProvider).signOut();
                },
                icon: const Icon(Icons.logout));
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          children: [
            //message list
            Expanded(
                child: MessageList(
              userId: FirebaseAuth.instance.currentUser!.uid,
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(7)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ask any questions !'),
                    ),
                  ),
                  //image button
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SendImageScreen()));
                      },
                      icon: const Icon(Icons.image_outlined)),
                  //send button
                  IconButton(
                      onPressed: sendMessage, icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    await ref
        .read(chatProvider)
        .sendTextMessage(textPrompt: _messageController.text, apikey: apikey);

    _messageController.clear();
  }
}
