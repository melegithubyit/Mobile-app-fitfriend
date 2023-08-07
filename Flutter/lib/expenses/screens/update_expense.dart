// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/categories/bloc/category_state.dart';
import 'package:project_app/expenses/bloc/expense_bloc.dart';
import 'package:project_app/expenses/bloc/expense_event.dart';
import 'package:project_app/expenses/bloc/expense_state.dart';

class UpdateExpense extends StatefulWidget {
  final int id;
  final double amount;

  UpdateExpense(this.id, this.amount);
  @override
  State<UpdateExpense> createState() => _UpdateExpense(id, amount);
}

class _UpdateExpense extends State<UpdateExpense> {
  final int id;
  final double amount;

  _UpdateExpense(this.id, this.amount);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final ExpenseBloc expenseBloc = ExpenseBloc();

  @override
  void initState() {
    amountController.text = amount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseBloc(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(233, 245, 245, 245),
        body: SafeArea(
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background(context),
            Positioned(
              top: 120,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 550,
                width: 340,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 450,
                    child: Form(
                      key: _formKey,
                      child: Container(
                        child: Column(children: [
                          SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: amountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }

                                try {
                                  double parsedValue = double.parse(value);
                                  if (parsedValue == 0) {
                                    return "Zero is not allowed";
                                  }
                                } catch (error) {
                                  return 'Please enter a valid number';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.number,
                              cursorWidth: 1,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  labelText: 'Amount',
                                  labelStyle: TextStyle(
                                      fontSize: 17, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(width: 2))),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          BlocConsumer<ExpenseBloc, ExpenseState>(
                            bloc: expenseBloc,
                            listener: (context, state) {
                              if (state is UpdateCategoryExpenseSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'expense is successfully updated to ${state.amount}'),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is UpdateCategoryLoading) {
                                return CircularProgressIndicator();
                              }

                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    expenseBloc.add(UpdateCategoryExpenseEvent(
                                        id,
                                        double.parse(amountController.text)));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 43, 153, 146),
                                  side: BorderSide.none,
                                ),
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          )
                        ]),
                      ),
                    ),
                  )
                ]),
              ),
            )
          ],
        )),
      ),
    );
  }
}

Column background(BuildContext context) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          color: Color(0xff368983),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(105),
          ),
        ),
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Text(
                'Update Expense',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 30,
              )
            ],
          )
        ]),
      )
    ],
  );
}
