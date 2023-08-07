import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/auth/bloc/auth_event.dart';
import 'package:project_app/auth/bloc/auth_state.dart';
import 'package:project_app/auth/models/model.dart';
import 'package:project_app/auth/respository/auth_repository.dart';
import "../../sqlDB.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressed>(loginButtonPressed);
    on<SignUpButtonPressed>(signUpButtonPressed);
    on<GetUserDetailEvent>(getUserDetail);
    on<UpdateUserDetailEvent>(updateUserDetailEvent);
    on<DeleteUserEvent>(deleteUserEvent);
    on<GetUsersEvent>(getUsersEvent);
    on<DeleteUserAdminEvent>(deleteUserAdminEvent);
    on<AdminRoleEvent>(giveAdminRoleEvent);
  }
  Future<dynamic> loginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();

    try {
      emit(LogInLoading());
      LoginModel response =
          await authRepository.loginUser(event.username, event.password);

      await insertToken(response.token);
      emit(LoginOperationSuccess(response.token));
    } catch (error) {
      if (error is UnauthorizedException) {
        emit(LoginOperationFailed(error.result.error));
      }
    }
  }

  Future<dynamic> signUpButtonPressed(
      SignUpButtonPressed event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();

    try {
      emit(SignUpLoading());
      SignUpModel response =
          await authRepository.signUpUser(event.username, event.password);

      emit(SignUpOperationSuccess(response.username));
    } catch (error) {
      if (error is SingUpException) {
        emit(SignUpOperationFailed(error.result.error));
      }
    }
  }

  Future<dynamic> getUserDetail(
      GetUserDetailEvent event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();

    try {
      UserDetailModel response = await authRepository.getUserDetail();

      emit(GetUserDetailSuccess(response.id, response.username,
          response.is_staff, response.is_staff));
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> updateUserDetailEvent(
      UpdateUserDetailEvent event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();
    emit(UpdateUserDetailLoading());
    try {
      var response = await authRepository.updateUserDetail(
          event.username, event.newPassword, event.oldPassword);

      emit(UpdateUserDetailSuccess(response.username));
    } catch (error) {
      if (error is UpdateUserDetailException) {
        emit(
            UpdateUserDetailFailed(error.result.msg_one, error.result.msg_two));
      }
    }
  }

  Future<dynamic> deleteUserEvent(
      DeleteUserEvent event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();
    emit(DeleteUserLoading());
    try {
      var response = await authRepository.deleteUser();
      if (response) {
        emit(DeleteUserSuccess());
      } else {
        emit(DeleteUserFailed());
      }
    } catch (error) {}
  }

  Future<dynamic> getUsersEvent(
      GetUsersEvent event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();
    emit(GetUsersLoading());
    try {
      List<UserDetailModel> response = await authRepository.getUsers();
      emit(GetUsersSuccess(response));
    } catch (error) {}
  }

  Future<dynamic> deleteUserAdminEvent(
      DeleteUserAdminEvent event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();

    try {
      bool response = await authRepository.deleteUserAdmin(event.id);
      if (response) {
        emit(DeleteUserAdminSuccess(event.username));
      }
    } catch (error) {}
  }

  Future<dynamic> giveAdminRoleEvent(
      AdminRoleEvent event, Emitter<AuthState> emit) async {
    final AuthRepository authRepository = AuthRepository();

    try {
      bool response = await authRepository.adminRole(event.id, event.action);

      if (response) {
        emit(AdminRoleSuccess(event.username, event.action));
      }
    } catch (error) {}
  }
}
