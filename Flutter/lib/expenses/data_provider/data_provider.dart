import "dart:convert";

import "package:http/http.dart" as http;
import "package:project_app/sqlDB.dart";

class ExpenseAPI {
  Future<dynamic> getExpenses() async {
    var url = Uri.parse("http://localhost:8000/api/expenses/");
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

  Future<dynamic> getCategoryExpenses(id) async {
    var url =
        Uri.parse("http://localhost:8000/api/categoryexpenses/?categoryID=$id");
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

  Future<dynamic> deleteCategoryExpense(id) async {
    var url = Uri.parse("http://localhost:8000/api/categoryexpenses/$id/");
    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.delete(
      url,
      headers: headers,
    );

    return true;
  }

  Future<dynamic> createCategoryExpense(int id, double amount) async {
    var url = Uri.parse("http://localhost:8000/api/categoryexpenses/");
    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.post(
      url,
      body: json.encode({"category": id, "amount": amount}),
      headers: headers,
    );

    return response;
  }

  Future<dynamic> updateCategoryExpense(int id, double amount) async {
    var url = Uri.parse("http://localhost:8000/api/expenses/$id/");
    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.patch(
      url,
      body: json.encode({"amount": amount}),
      headers: headers,
    );

    return response;
  }
}
