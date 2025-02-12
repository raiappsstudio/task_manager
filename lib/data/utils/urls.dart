 class Urls{

  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  static const String registationUrl = '$_baseUrl/registration';
  static const String signInUrl = '$_baseUrl/login';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String taskCountByStatusUrl = '$_baseUrl/taskStatusCount';
  static String listTaskListUrl(String status) => '$_baseUrl/listTaskByStatus/$status';
  static String deletedTaskUrl(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskStatusUrl(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';

  static const String updateProfile = '$_baseUrl/profileUpdate';
  static String RecoverVerifyEmailUrl(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  //static String OTPurl(String email) => '$_baseUrl/RecoverVerifyEmail/$email/123456';



 }