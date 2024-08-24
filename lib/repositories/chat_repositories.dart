import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '/extensions/extensions.dart';

import '/models/message.dart';

import '/repositories/storage_repositories.dart';

@immutable
class ChatRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  //send image with text
  Future sendMessage(
      {required String apikey,
      required XFile? image,
      required String promptText}) async {
    final textmodel =
        GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apikey);
    final imageModel =
        GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apikey);

    final userId = _auth.currentUser!.uid;
    final sentMessageId = const Uuid().v4();

    Message message = Message(
        id: sentMessageId,
        message: promptText,
        createdAt: DateTime.now(),
        isMine: true);

    if (image != null) {
      final downloadUrl = await StorageRepository()
          .saveImageToStorage(image: image, messageId: sentMessageId);

      message = message.copyWith(imageUrl: downloadUrl);
    }

    await _firestore
        .collection('conversations')
        .doc(userId)
        .collection('messages')
        .doc(sentMessageId)
        .set(message.toMap());

    GenerateContentResponse response;

    try {
      if (image == null) {
        response = await textmodel.generateContent([Content.text(promptText)]);
      } else {
        //gemini takes image as a file
        final imageBytes = await image.readAsBytes();
        final prompt = TextPart(promptText);
        final mimeType = image.getMimeTypeFromExtension();
        final imagePart = DataPart(mimeType, imageBytes);

        response = await imageModel.generateContent([
          Content.multi([prompt, imagePart])
        ]);
      }

      final responseText = response.text;

      final receivedMessageid = const Uuid().v4();

      final responseMessage = Message(
          id: receivedMessageid,
          message: responseText!,
          createdAt: DateTime.now(),
          isMine: false);

      await _firestore
          .collection('conversations')
          .doc(userId)
          .collection('messages')
          .doc(receivedMessageid)
          .set(responseMessage.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future sendTextMessage(
      {required String textPrompt, required String apikey}) async {
    try {
      final textmodel =
          GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apikey);
      final userId = _auth.currentUser!.uid;
      final sentMessageId = const Uuid().v4();

      Message message = Message(
          id: sentMessageId,
          message: textPrompt,
          createdAt: DateTime.now(),
          isMine: true);
      //save to firebase
      await _firestore
          .collection('conversations')
          .doc(userId)
          .collection('messages')
          .doc(sentMessageId)
          .set(message.toMap());

      //text only request
      final response =
          await textmodel.generateContent([Content.text(textPrompt)]);

      final responseText = response.text;
      final receivedMessageId = const Uuid().v4();

      final responseMessage = Message(
          id: receivedMessageId,
          message: responseText!,
          createdAt: DateTime.now(),
          isMine: false);

      await _firestore
          .collection('conversations')
          .doc(userId)
          .collection('messages')
          .doc(receivedMessageId)
          .set(responseMessage.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
