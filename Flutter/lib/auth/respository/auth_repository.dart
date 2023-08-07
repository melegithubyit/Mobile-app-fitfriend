import 'dart:convert';
import 'package:project_app/auth/data_provider/auth_provider.dart';
import 'package:project_app/auth/models/model.dart';
import 'package:project_app/sqlDB.dart';

class AuthRepository {
  final AuthAPi api = AuthAPi();
  Future<dynamic> loginUser(username, password) async {
    var response = await api.loginUser(username, password);

    if (response.statusCode == 401) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      LoginFailedModel res = LoginFailedModel.fromJson(jsonMap);
      throw UnauthorizedException(res);
    }

    Map<String, dynamic> jsonMap = json.decode(response.body);

    LoginModel res = LoginModel.fromJson(jsonMap);

    return res;
  }

  Future<dynamic> signUpUser(username, password) async {
    var response = await api.signUpUser(username, password);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      SignUpModel res = SignUpModel.fromJson(jsonMap);
      return res;
    } else {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      SignUpFailedModel res = SignUpFailedModel.fromJson(jsonMap);

      throw SingUpException(res);
    }
  }

  Future<dynamic> getUserDetail() async {
    var response = await api.getUserDetail();

    Map<String, dynamic> jsonMap = json.decode(response.body);
    UserDetailModel res = UserDetailModel.fromJson(jsonMap);

    dynamic user = await retrieveUser();

    if (user == null) {
      await insertUser(res.username, res.id);
    } else {
      await updateUser(res.username);
    }

    return res;
  }

  Future<dynamic> updateUserDetail(username, newPassword, oldPassword) async {
    var response =
        await api.updateUserDetail(username, newPassword, oldPassword);

    if (response.statusCode == 400) {
      print(response.body);
      Map<String, dynamic> jsonMap = json.decode(response.body);
      // print(jsonMap["password"]);
      UpdateUserDetailFailedModel res =
          UpdateUserDetailFailedModel.fromJson(jsonMap);
      print(res.msg_one);
      print(res.msg_two);
      throw UpdateUserDetailException(res);
    }

    Map<String, dynamic> jsonMap = json.decode(response.body);
    UpdateUserDetailModel res = UpdateUserDetailModel.fromJson(jsonMap);

    return res;
  }

  Future<dynamic> deleteUser() async {
    var response = await api.deleteUser();

    if (response.statusCode == 204) {
      return true;
    }

    return false;
  }

  Future<dynamic> getUsers() async {
    var response = await api.getUsers();

    var jsonMap = json.decode(response.body);
    List<UserDetailModel> res = UserDetailModel.listFromObjects(jsonMap);
    return res;
  }

  Future<dynamic> deleteUserAdmin(int id) async {
    var response = await api.deleteUserAdmin(id);

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<dynamic> adminRole(int id, String action) async {
    var response = await api.adminRole(id, action);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}

class UnauthorizedException implements Exception {
  final LoginFailedModel result;

  UnauthorizedException(this.result);
}

class UpdateUserDetailException implements Exception {
  final UpdateUserDetailFailedModel result;

  UpdateUserDetailException(this.result);
}

class SingUpException implements Exception {
  final SignUpFailedModel result;

  SingUpException(this.result);
}
