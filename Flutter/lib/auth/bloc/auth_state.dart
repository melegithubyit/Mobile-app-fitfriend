import 'package:equatable/equatable.dart';
import 'package:project_app/auth/models/model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LogInLoading extends AuthState {}

class SignUpLoading extends AuthState {}

class LoginOperationSuccess extends AuthState {
  final String token;

  LoginOperationSuccess(this.token);
}

class LoginOperationFailed extends AuthState {
  final String error;

  LoginOperationFailed(this.error);
}

class SignUpOperationFailed extends AuthState {
  final String error;
  SignUpOperationFailed(this.error);
}

class SignUpOperationSuccess extends AuthState {
  final String username;
  SignUpOperationSuccess(this.username);
}

class GetUserDetailSuccess extends AuthState {
  final int id;
  final String username;
  final bool is_staff;
  final bool is_superuser;

  GetUserDetailSuccess(
      this.id, this.username, this.is_staff, this.is_superuser);
}

class UpdateUserDetailSuccess extends AuthState {
  final String username;

  UpdateUserDetailSuccess(this.username);
}

class UpdateUserDetailFailed extends AuthState {
  final String? msg_one;
  final String? msg_two;

  UpdateUserDetailFailed(this.msg_one, this.msg_two);
}

class UpdateUserDetailLoading extends AuthState {}

class DeleteUserSuccess extends AuthState {}

class DeleteUserFailed extends AuthState {}

class DeleteUserLoading extends AuthState {}

class GetUsersLoading extends AuthState {}

class GetUsersSuccess extends AuthState {
  final List<UserDetailModel> users;
  GetUsersSuccess(this.users);
}

class DeleteUserAdminSuccess extends AuthState {
  final String username;
  DeleteUserAdminSuccess(this.username);
}

class AdminRoleSuccess extends AuthState {
  final String username;
  final String action;
  AdminRoleSuccess(this.username, this.action);
}
