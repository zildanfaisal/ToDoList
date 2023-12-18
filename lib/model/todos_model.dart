// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDosModel {
  String? docID;
  final String titleTask;
  final String descriptionTask;
  final String dateTask;
  final String timeTask;
  final bool isDone;
  ToDosModel({
    this.docID,
    required this.titleTask,
    required this.descriptionTask,
    required this.dateTask,
    required this.timeTask,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titleTask': titleTask,
      'descriptionTask': descriptionTask,
      'dateTask': dateTask,
      'timeTask': timeTask,
      'isDone': isDone,
    };
  }

  factory ToDosModel.fromMap(Map<String, dynamic> map) {
    return ToDosModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleTask: map['titleTask'] as String,
      descriptionTask: map['descriptionTask'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  factory ToDosModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ToDosModel(
      docID: doc.id,
      titleTask: doc['titleTask'],
      descriptionTask: doc['descriptionTask'],
      dateTask: doc['dateTask'],
      timeTask: doc['timeTask'],
      isDone: doc['isDone'],
    );
  }
}
