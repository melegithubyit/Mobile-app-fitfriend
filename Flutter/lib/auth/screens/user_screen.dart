// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_app/auth/bloc/auth_bloc.dart';
import 'package:project_app/auth/bloc/auth_event.dart';
import 'package:project_app/auth/bloc/auth_state.dart';
import 'package:project_app/sqlDB.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List notification = [
    "Housing",
    "Education",
    "Health",
  ];

  final AuthBloc authBloc = AuthBloc();
  @override
  void initState() {
    authBloc.add(GetUserDetailEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
          backgroundColor: Color.fromARGB(246, 244, 245, 241),
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => context.go('/back'),
                icon: Icon(CupertinoIcons.arrowtriangle_left_fill)),
            title: Text("Profile"),
            backgroundColor: Color.fromARGB(255, 28, 98, 145),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 0),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 28, 98, 145),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(105),
                    ),
                  ),
                  width: double.infinity,
                  height: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          bloc: authBloc,
                          builder: (context, state) {
                            if (state is GetUserDetailSuccess) {
                              return Column(children: [
                                Text(
                                  '@${state.username}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                state.is_staff
                                    ? InkWell(
                                        onTap: () {
                                          context.go('/adminPage');
                                        },
                                        child: Container(
                                          width: 160,
                                          child: Row(children: [
                                            Icon(
                                              Icons.admin_panel_settings,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Admin page",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            )
                                          ]),
                                        ),
                                      )
                                    : Container(),
                              ]);
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(height: 5),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => context.go('/editPage'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 28, 98, 145),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text(
                        'edit',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 200,
                    child: InkWell(
                      onTap: () => {deleteAllRows(), context.go('/')},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Icon(
                            CupertinoIcons.power,
                            size: 24,
                            color: Color.fromARGB(255, 215, 22, 9),
                          )
                        ],
                      ),
                    )),
                const Divider(),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(224, 164, 2, 2),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.xmark),
                          SizedBox(
                            width: 1,
                          ),
                          InkWell(
                            onTap: () {
                              authBloc.add(DeleteUserEvent());
                            },
                            child: const Text(
                              'Delete Account',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    if (state is DeleteUserSuccess) {
                      deleteAllRows();
                      context.go('/loginPage');
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteUserFailed) {
                      return Container(
                        child: Text("Try again"),
                      );
                    }
                    return Container();
                  },
                )
              ]),
            ),
          )),
    );
  }
}
