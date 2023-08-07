// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/Income/bloc/income_bloc.dart';

import 'package:project_app/expenses/bloc/expense_bloc.dart';
import 'package:project_app/expenses/bloc/expense_event.dart';
import 'package:project_app/expenses/bloc/expense_state.dart';
import 'package:project_app/expenses/models/model.dart';
import 'package:project_app/expenses/screens/update_expense.dart';

class Expense extends StatefulWidget {
  final List<ExpenseModel> expense;
  Expense(this.expense);

  @override
  State<Expense> createState() => _expense(expense);
}

class _expense extends State<Expense> {
  final List<ExpenseModel> expense;

  _expense(this.expense);
  final ExpenseBloc expenseBloc = ExpenseBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseBloc(),
      child: Container(
        child: SizedBox(
            height: 100,
            width: double.infinity,
            child: expense.length == 0
                ? Center(
                    child: GestureDetector(
                    child: Text(
                      "No Expense, add Expenses",
                      style: TextStyle(color: Colors.red),
                    ),
                  ))
                : BlocListener<ExpenseBloc, ExpenseState>(
                    bloc: expenseBloc,
                    listener: (context, state) {
                      if (state is DeleteCategoryExpenseSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('delete operation successful'),
                          ),
                        );
                      }
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: expense.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        return Container(
                            margin:
                                EdgeInsets.only(top: 10, right: 10, left: 10),
                            width: 120,
                            height: 60,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(21, 95, 95, 95),
                                blurRadius: 0,
                                offset: Offset(0, 1),
                                spreadRadius: 1,
                              )
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.money_dollar,
                                      color: Color.fromARGB(149, 0, 0, 0),
                                    ),
                                    // successState.expenses[index].amount.toString()
                                    Text(
                                      expense[index].amount.toString(),
                                      style: TextStyle(
                                          color: Color.fromARGB(207, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Color.fromARGB(
                                                  220, 98, 98, 98),
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateExpense(
                                                              expense[index].id,
                                                              expense[index]
                                                                  .amount)),
                                                );
                                              },
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(
                                                        255, 48, 48, 47)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Color.fromARGB(
                                                  220, 98, 98, 98),
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () => {
                                                // expenseBloc.add(DeleteCategoryExpenseEvent(id))
                                                expenseBloc.add(
                                                    DeleteCategoryExpenseEvent(
                                                        expense[index].id)),
                                              },
                                              child: Text(
                                                "Remove",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                )
                              ],
                            ));
                      },
                    ),
                  )),
      ),
    );
  }
}
