import 'package:intl/intl.dart';

class IncomeModel {
  final int id;
  final double income;
  final double total_expense;
  final int userID;

  IncomeModel(this.id, this.income, this.total_expense, this.userID);

  factory IncomeModel.fromObject(dynamic object) {
    return IncomeModel(object['id'], object['income'].toDouble(),
        object["total_expense"].toDouble(), object["user"]);
  }

  static List<IncomeModel> listFromObjects(List<dynamic> objectList) {
    return objectList.map((object) => IncomeModel.fromObject(object)).toList();
  }
}
