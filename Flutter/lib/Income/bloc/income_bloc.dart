import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/Income/bloc/income_event.dart';
import 'package:project_app/Income/bloc/income_state.dart';
import 'package:project_app/Income/models/model.dart';
import 'package:project_app/Income/repository/income_repository.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeLoading()) {
    on<GetIncomeEvent>(getIncomeEvent);
    on<CreateIncomeEvent>(createIncomeEvent);
    on<UpdateIncomeEvent>(updateIncomeEvent);
    on<DeleteIncomeEvent>(deleteIncomeEvent);
  }

  Future<dynamic> getIncomeEvent(
      GetIncomeEvent event, Emitter<IncomeState> emit) async {
    final IncomeRepository incomeRepository = IncomeRepository();

    try {
      emit(IncomeLoading());
      List<IncomeModel> response = await incomeRepository.getIncome();

      emit(FetchIncomeSuccess(response));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> createIncomeEvent(
      CreateIncomeEvent event, Emitter<IncomeState> emit) async {
    final IncomeRepository incomeRepository = IncomeRepository();

    try {
      emit(IncomeLoading());
      IncomeModel response = await incomeRepository.createIncome(event.amount);

      emit(CreateIncomeSuccess(response));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> updateIncomeEvent(
      UpdateIncomeEvent event, Emitter<IncomeState> emit) async {
    final IncomeRepository incomeRepository = IncomeRepository();

    try {
      emit(IncomeLoading());
      IncomeModel response =
          await incomeRepository.updateIncome(event.amount, event.id);

      emit(UpdateIncomeSuccess(response));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> deleteIncomeEvent(
      DeleteIncomeEvent event, Emitter<IncomeState> emit) async {
    final IncomeRepository incomeRepository = IncomeRepository();

    try {
      emit(DeleteIncomeLoading());
      bool response = await incomeRepository.deleteIncome(event.id);

      emit(DeleteIncomeSuccess());
    } catch (error) {
      print(error);
    }
  }
}
