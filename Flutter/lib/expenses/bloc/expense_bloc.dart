import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/categories/bloc/category_event.dart';
import 'package:project_app/categories/bloc/category_state.dart';
import 'package:project_app/categories/models/model.dart';
import 'package:project_app/categories/repository/category_repository.dart';
import 'package:project_app/expenses/bloc/expense_event.dart';
import 'package:project_app/expenses/bloc/expense_state.dart';
import 'package:project_app/expenses/models/model.dart';
import 'package:project_app/expenses/respository/expense_repository.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseLoading()) {
    on<GetExpenseEvent>(getExpenseEvent);
    on<GetCategoryExpenseEvent>(getCategoryExpenseEvent);
    on<DeleteCategoryExpenseEvent>(deleteCategoryExpenseEvent);
    on<CreateCategoryExpenseEvent>(createCategoryExpenseEvent);
    on<UpdateCategoryExpenseEvent>(updateCategoryExpenseEvent);
  }

  Future<dynamic> getExpenseEvent(
      GetExpenseEvent event, Emitter<ExpenseState> emit) async {
    final ExpenseRepository expenseRepository = ExpenseRepository();

    try {
      emit(ExpenseLoading());
      List<ExpenseModel> response = await expenseRepository.getExpenses();

      emit(FetchExpenseSuccess(response));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> getCategoryExpenseEvent(
      GetCategoryExpenseEvent event, Emitter<ExpenseState> emit) async {
    final ExpenseRepository expenseRepository = ExpenseRepository();

    try {
      emit(ExpenseLoading());

      List<ExpenseModel> response =
          await expenseRepository.getCategoryExpenses(event.id);

      emit(FetchCategoryExpenseSuccess(response));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> deleteCategoryExpenseEvent(
      DeleteCategoryExpenseEvent event, Emitter<ExpenseState> emit) async {
    final ExpenseRepository expenseRepository = ExpenseRepository();

    try {
      emit(ExpenseLoading());

      bool response = await expenseRepository.deleteCategoryExpense(event.id);

      emit(DeleteCategoryExpenseSuccess());
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> createCategoryExpenseEvent(
      CreateCategoryExpenseEvent event, Emitter<ExpenseState> emit) async {
    final ExpenseRepository expenseRepository = ExpenseRepository();

    try {
      emit(CreateCategoryExpenseLoading());

      var response =
          await expenseRepository.createCategoryExpense(event.id, event.amount);

      emit(CreateCategoryExpenseSuccess(response.amount));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> updateCategoryExpenseEvent(
      UpdateCategoryExpenseEvent event, Emitter<ExpenseState> emit) async {
    final ExpenseRepository expenseRepository = ExpenseRepository();

    try {
      emit(UpdateCategoryExpenseLoading());

      var response =
          await expenseRepository.updateCategoryExpense(event.id, event.amount);

      emit(UpdateCategoryExpenseSuccess(response.amount));
    } catch (error) {
      print(error);
    }
  }
}
