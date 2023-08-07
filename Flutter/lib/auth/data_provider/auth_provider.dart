import "dart:convert";

import "package:http/http.dart" as http;
import "package:project_app/sqlDB.dart";

class AuthAPi {
  Future<dynamic> loginUser(username, password) async {
    var url = Uri.parse("http://localhost:8000/api/login/");

    var response = await http.post(
      url,
      body: json.encode({"username": username, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<dynamic> signUpUser(username, password) async {
    var url = Uri.parse("http://localhost:8000/api/register/");

    var response = await http.post(
      url,
      body: json.encode({"username": username, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<dynamic> getUserDetail() async {
    var url = Uri.parse("http://localhost:8000/api/userdetail/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    var response = await http.get(url, headers: headers);

    return response;
  }

  Future<dynamic> updateUserDetail(username, newPassword, oldPassword) async {
    dynamic user = await retrieveUser();
    var url = Uri.parse("http://localhost:8000/api/user/${user['userID']}/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    var body;

    if (!username.isEmpty) {
      if (!newPassword.isEmpty) {
        body = {
          "username": username,
          "newPassword": newPassword,
          "oldPassword": oldPassword
        };
      } else {
        body = {
          "username": username,
        };
      }
    } else {
      body = {"newPassword": newPassword, "oldPassword": oldPassword};
    }

    var response =
        await http.patch(url, body: json.encode(body), headers: headers);

    return response;
  }

  Future<dynamic> deleteUser() async {
    dynamic user = await retrieveUser();

    var url = Uri.parse("http://localhost:8000/api/user/${user['userID']}/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    var response = await http.delete(url, headers: headers);

    return response;
  }

  Future<dynamic> getUsers() async {
    dynamic user = await retrieveUser();

    var url = Uri.parse("http://localhost:8000/api/roles/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    var response = await http.get(url, headers: headers);

    return response;
  }

  Future<dynamic> deleteUserAdmin(int id) async {
    var url = Uri.parse("http://localhost:8000/api/deleteuser/$id/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    var response = await http.delete(url, headers: headers);

    return response;
  }

  Future<dynamic> adminRole(int id, String action) async {
    var url = Uri.parse("http://localhost:8000/api/roles/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    var response = await http.post(url,
        body: json.encode({"userID": id, "action": action}), headers: headers);

    return response;
  }
}
