import "dart:convert";

import "package:http/http.dart" as http;
import "package:project_app/sqlDB.dart";

class IncomeAPI {
  Future<dynamic> getIncome() async {
    var url = Uri.parse("http://localhost:8000/api/incomes/");

    var token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer ${token.toString()}',
      "Content-Type": "application/json"
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<dynamic> createIncome(amount) async {
    var url = Uri.parse("http://localhost:8000/api/incomes/");

    String token = await retrieveToken();
    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.post(
      url,
      body: json.encode({"income": amount}),
      headers: headers,
    );

    return response;
  }

  Future<dynamic> updateIncome(amount, id) async {
    var url = Uri.parse("http://localhost:8000/api/incomes/$id/");
    String token = await retrieveToken();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var response = await http.patch(
      url,
      body: json.encode({"income": amount}),
      headers: headers,
    );

    return response;
  }

  Future<dynamic> deleteIncome(int id) async {
    var url = Uri.parse("http://localhost:8000/api/incomes/$id/");
    String token = await retrieveToken();

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
