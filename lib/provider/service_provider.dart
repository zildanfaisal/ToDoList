import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todoapp_uas/model/todoApk_model.dart';
import 'package:flutter_todoapp_uas/service/todo_service.dart';

final serviceProvider = StateProvider<ToDoService>((ref) {
  return ToDoService();
});

final fetchStreamProvider = StreamProvider<List>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todoApk')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => ToDoModelApk.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
