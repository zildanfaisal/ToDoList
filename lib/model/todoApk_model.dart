// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModelApk {
  String? docID;
  final String category;
  final List todos;
  ToDoModelApk({
    this.docID,
    required this.category,
    required this.todos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'todos': todos,
    };
  }

  factory ToDoModelApk.fromMap(Map<String, dynamic> map) {
    return ToDoModelApk(
      docID: map['docID'] != null ? map['docID'] as String : null,
      category: map['category'] as String,
      todos: map['todos'] as List,
    );
  }

  factory ToDoModelApk.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return ToDoModelApk(
      docID: doc.id,
      category: doc['category'],
      todos: doc['todos'],
    );
  }
}
