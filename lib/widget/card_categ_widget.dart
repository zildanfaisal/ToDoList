import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todoapp_uas/provider/service_provider.dart';
import 'package:flutter_todoapp_uas/view/home_page.dart';

class CardCategWidget extends ConsumerWidget {
  const CardCategWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data: (todoData) {
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
                              FirebaseFirestore.instance
                                  .collection('todoApk')
                                  .doc(todoData[getIndex].docID)
                                  .delete();
                              print((todoData[getIndex].docID));
                            }),
                        title: Text(
                          todoData[getIndex].category,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage(
                                      getIndex: getIndex,
                                    )));
                          },
                          icon: const Icon(CupertinoIcons.forward),
                        ),
                      ),
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
