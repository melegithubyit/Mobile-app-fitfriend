abstract class IncomeEvent {}

class GetIncomeEvent extends IncomeEvent {}

class CreateIncomeEvent extends IncomeEvent {
  final double amount;
  CreateIncomeEvent(this.amount);
}

class UpdateIncomeEvent extends IncomeEvent {
  final double amount;
  final int id;
  UpdateIncomeEvent(this.amount, this.id);
}

class DeleteIncomeEvent extends IncomeEvent {
  final int id;

  DeleteIncomeEvent(this.id);
}
