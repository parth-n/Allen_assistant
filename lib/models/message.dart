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
      this.imageUrl,
      required this.createdAt,
      required this.isMine});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'isMine': isMine
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['id'] as String,
        message: map['message'] as String,
        imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
        createdAt: DateTime.fromMicrosecondsSinceEpoch(
            map['createdAt']?.microsecondsSinceEpoch ?? 0),
        isMine: map['isMine'] as bool);
  }

  Message copyWith({String? imageUrl}) {
    return Message(
        id: id,
        message: message,
        imageUrl: imageUrl,
        createdAt: createdAt,
        isMine: isMine);
  }
}
