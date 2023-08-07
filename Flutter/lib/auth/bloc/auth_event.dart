abstract class AuthEvent {
  const AuthEvent();
}

class LoginButtonPressed extends AuthEvent {
  final String username;
  final String password;

  const LoginButtonPressed(this.username, this.password);
}

class SignUpButtonPressed extends AuthEvent {
  final String username;
  final String password;

  const SignUpButtonPressed(this.username, this.password);
}

class GetUserDetailEvent extends AuthEvent {}

class UpdateUserDetailEvent extends AuthEvent {
  final String? username;
  final String? newPassword;
  final String? oldPassword;
  UpdateUserDetailEvent(this.username, this.oldPassword, this.newPassword);
}

class DeleteUserEvent extends AuthEvent {}

class GetUsersEvent extends AuthEvent {}

class DeleteUserAdminEvent extends AuthEvent {
  final int id;
  final String username;
  DeleteUserAdminEvent(this.id, this.username);
}

class AdminRoleEvent extends AuthEvent {
  final int id;
  final String action;
  final String username;
  AdminRoleEvent(this.id, this.action, this.username);
}
