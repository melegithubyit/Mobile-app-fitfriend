import 'package:project_app/Income/models/model.dart';

abstract class IncomeState {}

class IncomeLoading extends IncomeState {}

class FetchIncomeSuccess extends IncomeState {
  final List<IncomeModel> income;
  FetchIncomeSuccess(this.income);
}

class CreateIncomeSuccess extends IncomeState {
  final IncomeModel income;
  CreateIncomeSuccess(this.income);
}

class UpdateIncomeSuccess extends IncomeState {
  final IncomeModel income;
  UpdateIncomeSuccess(this.income);
}

class DeleteIncomeSuccess extends IncomeState {}

class DeleteIncomeLoading extends IncomeState {}
