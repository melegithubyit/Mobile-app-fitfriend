import 'dart:convert';

import 'package:project_app/categories/data_provider/data_provider.dart';
import 'package:project_app/categories/models/model.dart';

class CategoryRepository {
  final CategoryAPI api = CategoryAPI();
  Future<dynamic> getCategories() async {
    var response = await api.getCategories();

    List<dynamic> jsonList = json.decode(response.body);

    List<CategoryModel> categories = CategoryModel.listFromObjects(jsonList);

    return categories;
  }

  Future<dynamic> updateCategories(int id, String title, double amount) async {
    var response = await api.updateCategories(id, title, amount);

    dynamic jsonList = json.decode(response.body);

    CategoryModel categories = CategoryModel.fromObject(jsonList);

    return categories;
  }

  Future<dynamic> createCategory(String title, double amount) async {
    var response = await api.createCategories(title, amount);

    dynamic jsonList = json.decode(response.body);

    CategoryModel categories = CategoryModel.fromObject(jsonList);

    return categories;
  }

  Future<dynamic> deleteCategory(int id) async {
    try {
      var response = await api.deleteCategories(id);

      if (response.statusCode == 204) {
        return true;
      }

      return false;
    } catch (error) {}
  }
}
