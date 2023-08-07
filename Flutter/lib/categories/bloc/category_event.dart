abstract class CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {}

class UpdateCategoryEvent extends CategoryEvent {
  final int id;
  final double amount;
  final String title;
  UpdateCategoryEvent(this.id, this.amount, this.title);
}

class DeleteCategoryEvent extends CategoryEvent {
  final int id;
  DeleteCategoryEvent(this.id);
}

class CreateCategoryEvent extends CategoryEvent {
  final String title;
  final double amount;
  CreateCategoryEvent(this.title, this.amount);
}
