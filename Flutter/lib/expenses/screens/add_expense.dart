// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/screens/home_screen.dart';

class Expenseadd extends StatefulWidget {
  final int categoryID;
  final String title;
  Expenseadd(this.categoryID, this.title);
  @override
  State<Expenseadd> createState() => _expenesadd(categoryID, title);
}

class _expenesadd extends State<Expenseadd> {
  final int categoryID;
  final String title;

  _expenesadd(this.categoryID, this.title);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 80,
        ),
        Text(title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
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
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 43, 153, 146),
            side: BorderSide.none,
          ),
          child: const Text(
            'Add',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
