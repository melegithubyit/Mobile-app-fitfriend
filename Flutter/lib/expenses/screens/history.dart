// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/expenses/bloc/expense_bloc.dart';
import 'package:project_app/expenses/bloc/expense_event.dart';
import 'package:project_app/expenses/bloc/expense_state.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _history();
}

class _history extends State<History> {
  List cats = [
    "Housing",
    "Education",
    "Health",
    "Vacation",
    "Vacation",
    "Vacation",
    "Vacation",
    "Vacation",
  ];

  final ExpenseBloc expenseBloc = ExpenseBloc();

  void initState() {
    expenseBloc.add(GetExpenseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Expense History"),
          backgroundColor: Color.fromARGB(255, 43, 153, 146),
        ),
        body: Container(
          child: SizedBox(
            height: 700,
            width: double.infinity,
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              bloc: expenseBloc,
              builder: (context, state) {
                if (state is FetchExpenseSuccess) {
                  final successState = state as FetchExpenseSuccess;
                  if (successState.expenses.isEmpty) {
                    return Center(
                      child: Text(
                        "No expense found, add expenses in categories",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: successState.expenses.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(21, 28, 29, 29),
                              blurRadius: 0,
                              offset: Offset(0, 1),
                              spreadRadius: 1,
                            )
                          ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.money_dollar,
                                          size: 25, color: Colors.black),
                                      Text(
                                        successState.expenses[index].amount
                                            .toString(),
                                        style: TextStyle(
                                            color: Color.fromARGB(207, 0, 0, 0),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Text(successState.expenses[index].date),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
