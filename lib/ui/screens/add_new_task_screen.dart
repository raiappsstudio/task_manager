import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_ber_messge.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../controllers/add_new_task_controller.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

final TextEditingController _titleTEController = TextEditingController();
final TextEditingController _descriptionTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _addNewTaskInprogress = false;
final  AddNewTaskController _addNewTaskController = Get.find<AddNewTaskController>();


class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text('Add New Task', style: textTheme.titleLarge),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Fillup Title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Fillup description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<AddNewTaskController>(
                    builder: (context) {
                      return Visibility(
                        visible: _addNewTaskController.inProgress == false,
                        replacement: CenterCirculerInprogressBer(),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()){
                              _createNewTask();

                            }

                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createNewTask() async {
    final bool isSuccess = await _addNewTaskController.addNewTask(
      _titleTEController.text,
      _descriptionTEController.text,
    );

    Future.delayed(Duration(milliseconds: 100), () {
      if (!isSuccess) {
        showSnackBerMessage(context, _addNewTaskController.errorMassage!);
      } else {
        _clearTextField();
        showSnackBerMessage(context, 'New Task Added');
      }
    });
  }


  void _clearTextField() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
