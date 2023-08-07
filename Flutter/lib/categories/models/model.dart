class CategoryModel {
  final int id;
  final String title;
  final double budget;
  final double expense;
  final int userID;

  CategoryModel(this.id, this.title, this.budget, this.expense, this.userID);

  factory CategoryModel.fromObject(dynamic object) {
    return CategoryModel(
        object['id'],
        object['title'],
        object["total_budget"].toDouble(),
        object["total_expense"].toDouble(),
        object["user"]);
  }

  static List<CategoryModel> listFromObjects(List<dynamic> objectList) {
    return objectList
        .map((object) => CategoryModel.fromObject(object))
        .toList();
  }
}
