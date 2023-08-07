import 'package:intl/intl.dart';

class ExpenseModel {
  final int id;
  final double amount;
  final String date;
  final int categoryID;

  ExpenseModel(this.id, this.amount, this.date, this.categoryID);

  factory ExpenseModel.fromObject(dynamic object) {
    DateTime date = DateTime.parse(object["date"]);
    DateFormat format = DateFormat("EEEE, d MMMM yyyy");
    String formattedDate = format.format(date);
    return ExpenseModel(object['id'], object['amount'].toDouble(),
        formattedDate, object["category"]);
  }

  static List<ExpenseModel> listFromObjects(List<dynamic> objectList) {
    return objectList.map((object) => ExpenseModel.fromObject(object)).toList();
  }
}
