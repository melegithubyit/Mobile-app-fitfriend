// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/auth/bloc/auth_bloc.dart';
import 'package:project_app/auth/bloc/auth_event.dart';
import 'package:project_app/auth/bloc/auth_state.dart';
import 'package:project_app/auth/data_provider/auth_provider.dart';
import 'package:project_app/auth/respository/auth_repository.dart';
import 'package:project_app/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:project_app/sqlDB.dart';

class Admin extends StatefulWidget {
  @override
  State<Admin> createState() => _Admin();
}

String? username;
int count = 0;
void user() async {
  var user = await retrieveUser();

  username = user["username"];
}

class _Admin extends State<Admin> {
  AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    user();
    authBloc.add(GetUsersEvent());
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
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Admin - $username"),
          backgroundColor: Color.fromARGB(255, 43, 153, 146),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) async {
            if (state is DeleteUserAdminSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.username} is successfully deleted'),
                ),
              );

              authBloc.add(GetUsersEvent());
            }
            if (state is AdminRoleSuccess) {
              if (state.action == "give") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('${state.username} is successfully made an admin'),
                  ),
                );
              }
              if (state.action == "revoke") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${state.username} is successfully revoked admin role'),
                  ),
                );
              }
              authBloc.add(GetUsersEvent());
            }
          },
          builder: (context, state) {
            if (state is GetUsersSuccess) {
              count = 0;
              if (state.users.isEmpty) {
                return Center(
                  child: Text(
                    "No users found",
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  ),
                );
              }
              return Container(
                child: SizedBox(
                  height: 870,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.users.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      if (state.users[index].username == username) {
                        return Container();
                      }

                      if (state.users[index].username != username) {
                        count += 1;
                      }
                      return Container(
                          margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                          width: 120,
                          height: 70,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(21, 28, 29, 29),
                              blurRadius: 0,
                              offset: Offset(0, 1),
                              spreadRadius: 1,
                            )
                          ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${count}.",
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(207, 0, 0, 0),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          state.users[index].username,
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(207, 0, 0, 0),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 1),
                                padding: EdgeInsets.only(top: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            !state.users[index].is_staff
                                                ? InkWell(
                                                    onTap: () {
                                                      authBloc.add(
                                                          AdminRoleEvent(
                                                              state.users[index]
                                                                  .id,
                                                              "give",
                                                              state.users[index]
                                                                  .username));
                                                    },
                                                    child: Text(
                                                      "Grant Role",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.green),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      authBloc.add(
                                                          AdminRoleEvent(
                                                              state.users[index]
                                                                  .id,
                                                              "revoke",
                                                              state.users[index]
                                                                  .username));
                                                    },
                                                    child: Text(
                                                      "Revoke Role",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            state.users[index].is_staff
                                                ? Icon(Icons.person_remove,
                                                    size: 26, color: Colors.red)
                                                : Icon(Icons.person_add,
                                                    size: 26,
                                                    color: Color.fromARGB(
                                                        255, 59, 141, 47)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                authBloc.add(
                                                    DeleteUserAdminEvent(
                                                        state.users[index].id,
                                                        state.users[index]
                                                            .username));
                                              },
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(
                                                        255, 156, 44, 36)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 42,
                                            ),
                                            Icon(Icons.delete_sweep,
                                                color: Color.fromARGB(
                                                    255, 196, 23, 23)),
                                          ],
                                        ),
                                      )
                                    ]),
                              )
                            ],
                          ));
                    },
                  ),
                ),
              );
            } else if (state is GetUsersLoading) {
              return Center(child: CupertinoActivityIndicator(radius: 50));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
