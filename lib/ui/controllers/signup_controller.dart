import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import 'auth_controller.dart';
XFile? _pickedImage;


class SignupController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMassage => _errorMessage;

  Future<bool> SignUp(String email, String firstname, String lastname, String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestbody = {
      "email": email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
      "password": password
    };


    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registationUrl, body: requestbody);
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
          ? 'Successfully not Update!'
          : response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }




}
