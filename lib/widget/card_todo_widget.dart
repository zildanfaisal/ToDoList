import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todoapp_uas/provider/service_provider.dart';
import 'package:gap/gap.dart';

// class CardTodoListWidget extends StatefulWidget {
//   const CardTodoListWidget({
//     super.key,
//     required this.todo,
//     required this.category,
//   });

//   final dynamic todo;
//   final dynamic category;

//   @override
//   State<CardTodoListWidget> createState() => _CardTodoListWidgetState();
// }

// class _CardTodoListWidgetState extends State<CardTodoListWidget> {
//   late Color gantiWarna;
//   void initState() {
//     super.initState();
//     changeColor();
//   }

//   void changeColor() {
//     if (widget.category == 'Learning') {
//       gantiWarna = Colors.green;
//     } else if (widget.category == 'General') {
//       gantiWarna = Colors.yellow;
//     } else {
//       gantiWarna = Colors.blue;
//     }
//   }

// }

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.todo,
    required this.category,
    required this.getIndex,
    required this.index,
  });

  final dynamic todo;
  final dynamic category;
  final int getIndex;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    print(todo['titleTask']);

    return todoData.when(
      data: (todoData) {
        print(todoData[getIndex].todos);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                            icon: Icon(CupertinoIcons.delete),
                            onPressed: () {
                              todoData[getIndex].todos.removeAt(index);
                              FirebaseFirestore.instance
                                  .collection('todoApk')
                                  .doc(todoData[getIndex].docID)
                                  .update({'todos': todoData[getIndex].todos});
                              print(todoData[getIndex].todos);
                            }),
                        title: Text(
                          todoData[getIndex].todos[index]['titleTask'],
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todo['isDone']
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        subtitle: Text(
                          todoData[getIndex].todos[index]['descriptionTask'],
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todo['isDone']
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                activeColor: Colors.blue.shade800,
                                shape: const CircleBorder(),
                                value: todoData[getIndex].todos[index]
                                    ['isDone'],
                                onChanged: (value) {
                                  todoData[getIndex].todos[index]['isDone'] =
                                      value;
                                  FirebaseFirestore.instance
                                      .collection('todoApk')
                                      .doc(todoData[getIndex].docID)
                                      .update({
                                    'todos':
                                        todoData[getIndex].todos.map((todo) {
                                      if (todo ==
                                          todoData[getIndex].todos[index]) {
                                        return {
                                          'titleTask': todoData[getIndex]
                                              .todos[index]['titleTask'],
                                          'descriptionTask': todoData[getIndex]
                                              .todos[index]['descriptionTask'],
                                          'dateTask': todoData[getIndex]
                                              .todos[index]['dateTask'],
                                          'timeTask': todoData[getIndex]
                                              .todos[index]['timeTask'],
                                          'isDone': value
                                        };
                                      } else {
                                        return todo;
                                      }
                                    }).toList(),
                                  });
                                })),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Container(
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  Text(todoData[getIndex].todos[index]
                                      ['dateTask']),
                                  const Gap(12),
                                  Text(todoData[getIndex].todos[index]
                                      ['timeTask'])
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(stackTrace.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
