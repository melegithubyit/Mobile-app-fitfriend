class LoginModel {
  String token;
  LoginModel(this.token);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    print(json["access"]);
    return LoginModel(json["access"]);
  }
}

class LoginFailedModel {
  String error;
  LoginFailedModel(this.error);

  factory LoginFailedModel.fromJson(Map<String, dynamic> json) {
    return LoginFailedModel(json["detail"]);
  }
}

class SignUpFailedModel {
  String error;
  SignUpFailedModel(this.error);

  factory SignUpFailedModel.fromJson(Map<String, dynamic> json) {
    return SignUpFailedModel(json["username"][0]);
  }
}

class SignUpModel {
  String username;
  SignUpModel(this.username);

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(json["username"]);
  }
}

class UserDetailModel {
  final int id;
  final String username;
  final bool is_staff;
  final bool is_superuser;

  UserDetailModel(this.id, this.username, this.is_staff, this.is_superuser);

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
        json["id"], json["username"], json["is_staff"], json["is_superuser"]);
  }

  static List<UserDetailModel> listFromObjects(List<dynamic> objectList) {
    return objectList
        .map((object) => UserDetailModel.fromJson(object))
        .toList();
  }
}

class UpdateUserDetailModel {
  final String username;

  UpdateUserDetailModel(this.username);

  factory UpdateUserDetailModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserDetailModel(json["username"]);
  }
}

class UpdateUserDetailFailedModel {
  final String? msg_one;
  final String? msg_two;

  UpdateUserDetailFailedModel(this.msg_one, this.msg_two);

  factory UpdateUserDetailFailedModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserDetailFailedModel(json["password"],
        json["username"] != null ? json["username"][0] : null);
  }
}
