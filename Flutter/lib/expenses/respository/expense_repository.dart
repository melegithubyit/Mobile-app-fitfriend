import 'dart:convert';

import 'package:project_app/categories/data_provider/data_provider.dart';
import 'package:project_app/categories/models/model.dart';
import 'package:project_app/expenses/data_provider/data_provider.dart';
import 'package:project_app/expenses/models/model.dart';

class ExpenseRepository {
  final ExpenseAPI api = ExpenseAPI();
  Future<dynamic> getExpenses() async {
    var response = await api.getExpenses();

    List<dynamic> jsonList = json.decode(response.body);

    List<ExpenseModel> categories = ExpenseModel.listFromObjects(jsonList);

    return categories;
  }

  Future<dynamic> getCategoryExpenses(id) async {
    var response = await api.getCategoryExpenses(id);

    List<dynamic> jsonList = json.decode(response.body);

    List<ExpenseModel> categories = ExpenseModel.listFromObjects(jsonList);

    return categories;
  }

  Future<dynamic> deleteCategoryExpense(id) async {
    var response = await api.deleteCategoryExpense(id);

    return true;
  }

  Future<dynamic> createCategoryExpense(id, amount) async {
    try {
      var response = await api.createCategoryExpense(id, amount);

      dynamic jsonList = json.decode(response.body);

      ExpenseModel category = ExpenseModel.fromObject(jsonList);

      return category;
    } catch (err) {}
  }

  Future<dynamic> updateCategoryExpense(int id, double amount) async {
    try {
      var response = await api.updateCategoryExpense(id, amount);

      dynamic jsonList = json.decode(response.body);

      ExpenseModel category = ExpenseModel.fromObject(jsonList);

      return category;
    } catch (err) {}
  }
}
