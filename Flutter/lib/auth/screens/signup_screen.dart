// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/auth/bloc/auth_bloc.dart';
import 'package:project_app/auth/bloc/auth_event.dart';
import 'package:project_app/auth/bloc/auth_state.dart';
import 'package:project_app/screens/home_screen.dart';
import 'package:project_app/auth/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passToggle = true;
  final _formKey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset("images/image1.png"),
              ),
              SizedBox(height: 15),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          controller: userNameController,
                          decoration: InputDecoration(
                              labelText: "Enter user name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.phone)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: passToggle ? true : false,
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.key_sharp),
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
                                  : Icon(CupertinoIcons.eye_fill),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 15),
              BlocConsumer(
                  bloc: authBloc,
                  builder: (context, state) {
                    if (state is SignUpOperationFailed) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                state.error,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Color.fromARGB(255, 29, 132, 82),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authBloc.add(SignUpButtonPressed(
                                      userNameController.text,
                                      passwordController.text));
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                                child: Text(
                                  "Create Account",
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
                    } else if (state is SignUpLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return Material(
                        color: Color.fromARGB(255, 29, 132, 82),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              authBloc.add(SignUpButtonPressed(
                                  userNameController.text,
                                  passwordController.text));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            child: Text(
                              "Create Account",
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
                  listener: (context, state) {
                    if (state is SignUpOperationSuccess) {
                      context.go('/loginPage');
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an Account?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                      onPressed: () => context.go('/loginPage'),
                      child: Text("LogIn"))
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
