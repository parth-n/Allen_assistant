import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
class Message {
  final String id;
  final String message;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isMine;

  const Message(
      {required this.id,
      required this.message,
      required this.imageUrl,
      required this.createdAt,
      required this.isMine});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'iimageUrl': imageUrl,
      'createdAt': createdAt,
      'isMine': isMine
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['id'] as String,
        message: map['message'] as String,
        imageUrl: map['imageUrl'] != null ? map['iamgeUrl'] as String : null,
        createdAt: DateTime.fromMicrosecondsSinceEpoch(map['imageUrl'] as int),
        isMine: map['isMine'] as bool);
  }
}
