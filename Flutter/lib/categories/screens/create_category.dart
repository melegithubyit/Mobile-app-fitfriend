// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/Income/bloc/income_bloc.dart';
import 'package:project_app/Income/bloc/income_event.dart';
import 'package:project_app/Income/bloc/income_state.dart';
import 'package:project_app/categories/bloc/category_bloc.dart';
import 'package:project_app/categories/bloc/category_event.dart';
import 'package:project_app/categories/bloc/category_state.dart';

class CreateCategory extends StatefulWidget {
  @override
  State<CreateCategory> createState() => _CreateCategory();
}

class _CreateCategory extends State<CreateCategory> {
  String? selectedItem;
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CategoryBloc categoryBloc = CategoryBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: Container(
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }

                      return null;
                    },
                    cursorWidth: 1,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        labelText: 'title',
                        labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2))),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number';
                      }
                      try {
                        double parsedValue = double.parse(value);
                      } catch (error) {
                        return 'Please enter a valid number';
                      }

                      return null;
                    },
                    cursorWidth: 1,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        labelText: 'budget',
                        labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2))),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BlocConsumer<CategoryBloc, CategoryState>(
            bloc: categoryBloc,
            listener: (context, state) {
              if (state is CreateCategorySuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('category is successfully created'),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is CreateCategoryLoading) {
                return CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    categoryBloc.add(CreateCategoryEvent(titleController.text,
                        double.parse(amountController.text)));
                  }
                },
                child: Text(
                  "add",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 43, 153, 146),
                  side: BorderSide.none,
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
