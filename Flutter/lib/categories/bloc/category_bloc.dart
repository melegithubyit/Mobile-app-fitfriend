import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/categories/bloc/category_event.dart';
import 'package:project_app/categories/bloc/category_state.dart';
import 'package:project_app/categories/models/model.dart';
import 'package:project_app/categories/repository/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<GetCategoryEvent>(getCategoryEvent);
    on<UpdateCategoryEvent>(updateCategoryEvent);
    on<CreateCategoryEvent>(createCategoryEvent);
    on<DeleteCategoryEvent>(deleteCategoryEvent);
  }

  Future<dynamic> getCategoryEvent(
      GetCategoryEvent event, Emitter<CategoryState> emit) async {
    final CategoryRepository categoryRepository = CategoryRepository();

    try {
      emit(CategoryLoading());
      List<CategoryModel> response = await categoryRepository.getCategories();

      emit(FetchCategorySuccess(response));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> updateCategoryEvent(
      UpdateCategoryEvent event, Emitter<CategoryState> emit) async {
    final CategoryRepository categoryRepository = CategoryRepository();

    try {
      emit(UpdateCategoryLoading());
      CategoryModel response = await categoryRepository.updateCategories(
          event.id, event.title, event.amount);

      emit(UpdateCategorySuccess(event.amount, event.title));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> createCategoryEvent(
      CreateCategoryEvent event, Emitter<CategoryState> emit) async {
    final CategoryRepository categoryRepository = CategoryRepository();

    try {
      emit(CreateCategoryLoading());
      CategoryModel response =
          await categoryRepository.createCategory(event.title, event.amount);

      emit(CreateCategorySuccess());
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> deleteCategoryEvent(
      DeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    final CategoryRepository categoryRepository = CategoryRepository();

    try {
      bool response = await categoryRepository.deleteCategory(event.id);
      if (response) {
        emit(DeleteCategorySuccess());
      }
    } catch (error) {
      print(error);
    }
  }
}
