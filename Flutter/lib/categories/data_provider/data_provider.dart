import "dart:convert";

import "package:http/http.dart" as http;
import "package:project_app/sqlDB.dart";

class CategoryAPI {
  Future<dynamic> getCategories() async {
    var url = Uri.parse("http://localhost:8000/api/categories/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<dynamic> updateCategories(int id, String title, double amount) async {
    var url = Uri.parse("http://localhost:8000/api/categories/$id/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.patch(
      url,
      body: json.encode({"title": title, "total_budget": amount}),
      headers: headers,
    );

    return response;
  }

  Future<dynamic> createCategories(String title, double amount) async {
    var url = Uri.parse("http://localhost:8000/api/categories/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.post(
      url,
      body: json.encode({"title": title, "total_budget": amount}),
      headers: headers,
    );

    return response;
  }

  Future<dynamic> deleteCategories(int id) async {
    var url = Uri.parse("http://localhost:8000/api/categories/$id/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.delete(
      url,
      headers: headers,
    );

    return response;
  }
}
