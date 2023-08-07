// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_app/categories/bloc/category_bloc.dart';
import 'package:project_app/categories/bloc/category_event.dart';
import 'package:project_app/categories/bloc/category_state.dart';
import 'package:project_app/expenses/bloc/expense_event.dart';
import 'package:project_app/screens/home_screen.dart';

class UpdateCategory extends StatefulWidget {
  final int id;
  final String title;
  final double amount;
  UpdateCategory(this.id, this.title, this.amount);
  @override
  State<UpdateCategory> createState() => _UpdateCategory(id, title, amount);
}

class _UpdateCategory extends State<UpdateCategory> {
  final int id;
  final String title;
  final double amount;
  _UpdateCategory(this.id, this.title, this.amount);
  final _formKey = GlobalKey<FormState>();

  final CategoryBloc categoryBloc = CategoryBloc();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    titleController.text = title;
    amountController.text = amount.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
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
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Invalid title";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              cursorWidth: 1,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  labelText: 'title',
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: amountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Invalid budget";
                                }
                                try {
                                  double.parse(value);
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
                                  labelText: 'Budget',
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
                          BlocConsumer<CategoryBloc, CategoryState>(
                            bloc: categoryBloc,
                            listener: (context, state) {
                              if (state is UpdateCategorySuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'category is successfully updated'),
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
                                    categoryBloc.add(UpdateCategoryEvent(
                                        id,
                                        double.parse(amountController.text),
                                        titleController.text));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 43, 153, 146),
                                  side: BorderSide.none,
                                ),
                                child: const Text(
                                  'Save',
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
                'edit category',
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
