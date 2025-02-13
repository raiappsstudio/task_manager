import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import 'auth_controller.dart';
XFile? _pickedImage;


class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMassage => _errorMessage;

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };


    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: requestBody);
    _inProgress = false;
    update();

    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);

      isSuccess = true;
      _errorMessage = null;

    } else {
      _errorMessage = response.statusCode == 401
          ? 'Successfully not added!'
          : response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }




}
