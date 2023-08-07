// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/Income/bloc/income_bloc.dart';
import 'package:project_app/Income/bloc/income_event.dart';
import 'package:project_app/Income/bloc/income_state.dart';

class Incomeadd extends StatefulWidget {
  @override
  State<Incomeadd> createState() => _incomeadd();
}

class _incomeadd extends State<Incomeadd> {
  String? selectedItem;
  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final IncomeBloc incomeBloc = IncomeBloc();
  @override
  void initState() {
    incomeBloc.add(GetIncomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncomeBloc(),
      child: BlocListener<IncomeBloc, IncomeState>(
        bloc: incomeBloc,
        listener: (context, state) {
          if (state is FetchIncomeSuccess) {
            if (state.income.isNotEmpty) {
              amountController.text = state.income[0].income.toString();
            } else {
              amountController.text = "";
            }
          }
          if (state is DeleteIncomeSuccess) {
            amountController.text = "";
          }
        },
        child: Container(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: amountController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }

                    try {
                      double parsedValue = double.parse(value);
                      if (parsedValue == 0.0) {
                        return 'Zero is not allowed';
                      }
                    } catch (error) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'Amount',
                      labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2))),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            BlocConsumer<IncomeBloc, IncomeState>(
              bloc: incomeBloc,
              listener: (context, state) {
                if (state is CreateIncomeSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Your Income ${state.income.income} is set successfully'),
                    ),
                  );
                }
                if (state is DeleteIncomeSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('You have successfully removed your income'),
                    ),
                  );
                }
                if (state is UpdateIncomeSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Your Income is successfully updated to ${state.income.income}'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is DeleteIncomeLoading) {
                  return CircularProgressIndicator();
                }
                if (state is DeleteIncomeSuccess) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        incomeBloc.add(CreateIncomeEvent(
                            double.parse(amountController.text)));
                      }
                    },
                    child: Text(
                      "Add",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 43, 153, 146),
                      side: BorderSide.none,
                    ),
                  );
                }
                if (state is FetchIncomeSuccess) {
                  if (state.income.length == 0) {
                    // amountController.text = state.income[0].income.toString();
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          incomeBloc.add(CreateIncomeEvent(
                              double.parse(amountController.text)));
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 43, 153, 146),
                        side: BorderSide.none,
                      ),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              incomeBloc.add(UpdateIncomeEvent(
                                  double.parse(amountController.text),
                                  state.income[0].id));
                            }
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 43, 153, 146),
                            side: BorderSide.none,
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            incomeBloc
                                .add(DeleteIncomeEvent(state.income[0].id));
                          },
                          child: Text(
                            "Remove",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            side: BorderSide.none,
                          ),
                        ),
                      ],
                    );
                  }
                } else if (state is IncomeLoading) {
                  return CircularProgressIndicator();
                } else if (state is CreateIncomeSuccess) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            incomeBloc.add(UpdateIncomeEvent(
                                double.parse(amountController.text),
                                state.income.id));
                          }
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 43, 153, 146),
                          side: BorderSide.none,
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          incomeBloc.add(DeleteIncomeEvent(state.income.id));
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          side: BorderSide.none,
                        ),
                      ),
                    ],
                  );
                } else if (state is UpdateIncomeSuccess) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            incomeBloc.add(UpdateIncomeEvent(
                                double.parse(amountController.text),
                                state.income.id));
                          }
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 43, 153, 146),
                          side: BorderSide.none,
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          incomeBloc.add(DeleteIncomeEvent(state.income.id));
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          side: BorderSide.none,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
