import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todoapp_uas/common/show_model.dart';
import 'package:flutter_todoapp_uas/provider/service_provider.dart';
import 'package:flutter_todoapp_uas/widget/card_todo_widget.dart';
import 'package:gap/gap.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.getIndex});
  final int getIndex;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return todoData.when(
      data: (todoData) {
        print(todoData[getIndex].category);
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const ListTile(
              title: Text(
                'To Do List!',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/menu');
                      },
                      icon: const Icon(CupertinoIcons.escape),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD5E8FA),
                            foregroundColor: Colors.blue.shade800,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          context: context,
                          builder: (context) => AddNewListModel(
                            docID: todoData[getIndex].docID,
                          ),
                        ),
                        child: const Text(
                          '+ New List',
                        ),
                      ),
                    ],
                  ),
                  // Card list task
                  const Gap(20),
                  ListView.builder(
                    itemCount: todoData[getIndex].todos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CardTodoListWidget(
                      getIndex: getIndex,
                      index: index,
                      todo: todoData[getIndex].todos[index],
                      category: todoData[getIndex].category,
                    ),
                  )
                  // End card list task
                ],
              ),
            ),
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
