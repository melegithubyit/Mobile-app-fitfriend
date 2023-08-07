import 'package:project_app/expenses/models/model.dart';

abstract class ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class CreateCategoryExpenseLoading extends ExpenseState {}

class CategoryExpenseLoading extends ExpenseState {}

class UpdateCategoryExpenseLoading extends ExpenseState {}

class FetchExpenseSuccess extends ExpenseState {
  final List<ExpenseModel> expenses;
  FetchExpenseSuccess(this.expenses);
}

class FetchCategoryExpenseSuccess extends ExpenseState {
  final List<ExpenseModel> expenses;
  FetchCategoryExpenseSuccess(this.expenses);
}

class DeleteCategoryExpenseSuccess extends ExpenseState {}

class UpdateCategoryExpenseSuccess extends ExpenseState {
  final double amount;
  UpdateCategoryExpenseSuccess(this.amount);
}

class CreateCategoryExpenseSuccess extends ExpenseState {
  final double amount;
  CreateCategoryExpenseSuccess(this.amount);
}
