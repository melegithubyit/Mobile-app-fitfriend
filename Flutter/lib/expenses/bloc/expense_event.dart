abstract class ExpenseEvent {}

class GetExpenseEvent extends ExpenseEvent {}

class GetCategoryExpenseEvent extends ExpenseEvent {
  final int id;
  GetCategoryExpenseEvent(this.id);
}

class CreateCategoryExpenseEvent extends ExpenseEvent {
  final int id;
  final double amount;
  CreateCategoryExpenseEvent(this.id, this.amount);
}

class UpdateCategoryExpenseEvent extends ExpenseEvent {
  final int id;
  final double amount;
  UpdateCategoryExpenseEvent(this.id, this.amount);
}

class DeleteCategoryExpenseEvent extends ExpenseEvent {
  final int id;
  DeleteCategoryExpenseEvent(this.id);
}
