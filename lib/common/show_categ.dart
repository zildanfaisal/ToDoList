import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todoapp_uas/constants/app_style.dart';
import 'package:flutter_todoapp_uas/model/todoApk_model.dart';
import 'package:flutter_todoapp_uas/provider/service_provider.dart';
import 'package:flutter_todoapp_uas/widget/textfield_widget.dart';
import 'package:gap/gap.dart';

class AddNewCategModel extends ConsumerWidget {
  AddNewCategModel({
    super.key,
  });

  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'New Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),

          //Input Text
          const Gap(12),
          const Text('Category', style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
            maxLine: 1,
            hintText: 'Add New Category',
            txtController: categoryController,
          ),

          //Button
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    ref.read(serviceProvider).addNewCategory(ToDoModelApk(
                          category: categoryController.text,
                          todos: [],
                        ));

                    print('Data is Saving');

                    categoryController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          )
          //End Button
        ],
      ),
    );
  }
}
