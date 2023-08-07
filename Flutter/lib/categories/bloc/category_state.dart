import 'package:project_app/categories/models/model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CreateCategoryLoading extends CategoryState {}

class CreateCategorySuccess extends CategoryState {}

class UpdateCategoryLoading extends CategoryState {}

class DeleteCategoryLoading extends CategoryState {}

class DeleteCategorySuccess extends CategoryState {}

class FetchCategorySuccess extends CategoryState {
  final List<CategoryModel> categories;
  FetchCategorySuccess(this.categories);
}

class UpdateCategorySuccess extends CategoryState {
  final double amount;
  final String title;
  UpdateCategorySuccess(this.amount, this.title);
}
