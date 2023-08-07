// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/auth/bloc/auth_bloc.dart';
import 'package:project_app/auth/bloc/auth_event.dart';
import 'package:project_app/auth/bloc/auth_state.dart';
import 'package:project_app/auth/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:project_app/sqlDB.dart';

class EditScreen extends StatefulWidget {
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool passToggle = true;
  bool passToggleConfirm = true;
  bool passToggleOld = true;
  final _formKey = GlobalKey<FormState>();

  final AuthBloc authBloc = AuthBloc();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  void assignUsername() async {
    dynamic user = await retrieveUser();

    userNameController.text = user["username"];
  }

  @override
  void initState() {
    super.initState();
    assignUsername();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go('/back'),
              icon: Icon(CupertinoIcons.arrowtriangle_left_fill)),
          title: Text("Customize Your profile"),
          backgroundColor: Color.fromARGB(255, 28, 98, 145),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 200),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                        labelText: "username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                      controller: oldPasswordController,
                      validator: (value) {
                        if ((!newPasswordController.text.isEmpty ||
                                !confirmNewPasswordController.text.isEmpty) &&
                            (value == null || value.isEmpty)) {
                          return "Invalid password";
                        }
                        return null;
                      },
                      obscureText: passToggleOld ? true : false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Old password"),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap: () {
                              if (passToggleOld == true) {
                                passToggleOld = false;
                              } else {
                                passToggleOld = true;
                              }
                              setState(() {});
                            },
                            child: passToggleOld
                                ? Icon(CupertinoIcons.eye_slash_fill)
                                : Icon(CupertinoIcons.eye_fill)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                      controller: newPasswordController,
                      validator: (value) {
                        if ((!oldPasswordController.text.isEmpty ||
                                !confirmNewPasswordController.text.isEmpty) &&
                            (value == null || value.isEmpty)) {
                          return "Invalid password";
                        }

                        return null;
                      },
                      obscureText: passToggle ? true : false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("New password"),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap: () {
                              if (passToggle == true) {
                                passToggle = false;
                              } else {
                                passToggle = true;
                              }
                              setState(() {});
                            },
                            child: passToggle
                                ? Icon(CupertinoIcons.eye_slash_fill)
                                : Icon(CupertinoIcons.eye_fill)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                      controller: confirmNewPasswordController,
                      validator: (value) {
                        if ((!oldPasswordController.text.isEmpty ||
                                !newPasswordController.text.isEmpty) &&
                            (value == null || value.isEmpty)) {
                          return "Invalid password";
                        } else if (value != newPasswordController.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                      obscureText: passToggleConfirm ? true : false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("confirm new password"),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap: () {
                              if (passToggleConfirm == true) {
                                passToggleConfirm = false;
                              } else {
                                passToggleConfirm = true;
                              }
                              setState(() {});
                            },
                            child: passToggleConfirm
                                ? Icon(CupertinoIcons.eye_slash_fill)
                                : Icon(CupertinoIcons.eye_fill)),
                      )),
                ),
                SizedBox(height: 15),
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    if (state is UpdateUserDetailSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Your profile is set successfully updated'),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateUserDetailFailed) {
                      return Column(children: [
                        state.msg_one != null
                            ? Text(state.msg_one.toString(),
                                style: TextStyle(color: Colors.red))
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        state.msg_two != null
                            ? Text(state.msg_two.toString(),
                                style: TextStyle(color: Colors.red))
                            : Container(),
                        SizedBox(
                          height: 30,
                        ),
                        Material(
                          color: Color.fromARGB(255, 28, 98, 145),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                authBloc.add(UpdateUserDetailEvent(
                                    userNameController.text,
                                    oldPasswordController.text,
                                    newPasswordController.text));
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]);
                    } else if (state is UpdateUserDetailLoading) {
                      return Material(
                        color: Color.fromARGB(255, 28, 98, 145),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              authBloc.add(UpdateUserDetailEvent(
                                  userNameController.text,
                                  oldPasswordController.text,
                                  newPasswordController.text));
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              child: CircularProgressIndicator()),
                        ),
                      );
                    }
                    return Material(
                      color: Color.fromARGB(255, 28, 98, 145),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            authBloc.add(UpdateUserDetailEvent(
                                userNameController.text,
                                oldPasswordController.text,
                                newPasswordController.text));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
