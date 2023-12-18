import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todoapp_uas/model/todos_model.dart';
import 'package:flutter_todoapp_uas/model/todoApk_model.dart';

class ToDoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApk');

  //Create
  void addNewTask(ToDosModel model, dynamic docID) {
    FirebaseFirestore.instance.collection('todoApk').doc(docID).update({
      'todos': FieldValue.arrayUnion([model.toMap()])
    });
  }

  void addNewCategory(ToDoModelApk model) {
    todoCollection.add(model.toMap());
  }
}
