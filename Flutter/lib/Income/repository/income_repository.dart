import 'dart:convert';

import 'package:project_app/Income/data_provider/income_provider.dart';
import 'package:project_app/Income/models/model.dart';

class IncomeRepository {
  final IncomeAPI api = IncomeAPI();
  Future<dynamic> getIncome() async {
    var response = await api.getIncome();

    List<dynamic> jsonList = json.decode(response.body);

    List<IncomeModel> incomes = IncomeModel.listFromObjects(jsonList);

    return incomes;
  }

  Future<dynamic> createIncome(amount) async {
    var response = await api.createIncome(amount);

    dynamic jsonList = json.decode(response.body);

    IncomeModel income = IncomeModel.fromObject(jsonList);

    return income;
  }

  Future<dynamic> updateIncome(amount, id) async {
    var response = await api.updateIncome(amount, id);

    dynamic jsonList = json.decode(response.body);

    IncomeModel income = IncomeModel.fromObject(jsonList);

    return income;
  }

  Future<dynamic> deleteIncome(int id) async {
    var response = await api.deleteIncome(id);

    if (response.statusCode == 204) {
      return true;
    }

    return false;
  }
}
