// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/auth/bloc/auth_bloc.dart';
import 'package:project_app/auth/bloc/auth_state.dart';
import 'package:project_app/auth/bloc/auth_event.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/sqlDB.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = true;
  final _formKey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image.asset("images/image3.png"),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                          controller: userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter User Name"),
                            prefixIcon: Icon(Icons.person),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          obscureText: passToggle ? true : false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter PassWord"),
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
                    SizedBox(height: 20),
                    BlocConsumer(
                        bloc: authBloc,
                        builder: (context, state) {
                          if (state is LoginOperationFailed) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    state.error,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Color.fromARGB(255, 29, 132, 82),
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        authBloc.add(LoginButtonPressed(
                                            userNameController.text,
                                            passwordController.text));
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 40),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else if (state is LogInLoading) {
                            return CircularProgressIndicator();
                          } else {
                            return Material(
                              color: Color.fromARGB(255, 29, 132, 82),
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    authBloc.add(LoginButtonPressed(
                                        userNameController.text,
                                        passwordController.text));
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 40),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        listener: (context, state) async {
                          if (state is LoginOperationSuccess) {
                            context.go("/homePage");
                          }
                        }),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont Have Any Account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                            onPressed: () => context.go('/signupPage'),
                            child: Text("Create Account."))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
