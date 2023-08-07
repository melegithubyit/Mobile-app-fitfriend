// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_app/expenses/screens/add_expense.dart';
import 'package:project_app/Income/screens/add_income.dart';
import 'package:project_app/categories/screens/create_category.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});
  @override
  State<AddScreen> createState() => _AddScreen();
}

class _AddScreen extends State<AddScreen> {
  String? selectedItem;
  int _selectedIndex = 0;

  List<String> items = [
    "Category",
    "Income",
  ];
  final _screens = [CreateCategory(), Incomeadd()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.only(left: 15),
                            width: 150,
                            height: 45,
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? Color.fromARGB(255, 43, 153, 146)
                                  : Color.fromARGB(55, 163, 162, 162),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            duration: const Duration(milliseconds: 150),
                            child: Center(
                              child: Text(
                                items[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: _selectedIndex == index
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(161, 9, 8, 8),
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 450,
                  child: _screens[_selectedIndex],
                )
              ]),
            ),
          )
        ],
      )),
    );
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
                  onPressed: () => context.go('/back'),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  'Add',
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
}
