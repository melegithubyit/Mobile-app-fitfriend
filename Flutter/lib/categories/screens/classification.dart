import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/categories/bloc/category_bloc.dart';
import 'package:project_app/categories/bloc/category_event.dart';
import 'package:project_app/categories/bloc/category_state.dart';
import 'package:project_app/expenses/bloc/expense_bloc.dart';
import 'package:project_app/expenses/bloc/expense_event.dart';
import 'package:project_app/expenses/bloc/expense_state.dart';
import '../../expenses/screens/expenses.dart';

class Classifications extends StatefulWidget {
  @override
  State<Classifications> createState() => _classifications();
}

class _classifications extends State<Classifications> {
  final CategoryBloc categoryBloc = CategoryBloc();
  final ExpenseBloc expenseBloc = ExpenseBloc();

  @override
  void initState() {
    categoryBloc.add(GetCategoryEvent());

    super.initState();
  }

  var _selectedIndex = null;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider<ExpenseBloc>(
          create: (context) => ExpenseBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color.fromARGB(139, 248, 255, 246),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("All Categories"),
          backgroundColor: Color.fromARGB(255, 43, 153, 146),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                bloc: categoryBloc,
                builder: (context, state) {
                  if (state is FetchCategorySuccess) {
                    final successState = state as FetchCategorySuccess;
                    if (successState.categories.isEmpty) {
                      return Center(
                        child: Text(
                          "No categories found, add categories on the home page",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: successState.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                              expenseBloc.add(GetCategoryExpenseEvent(
                                  successState.categories[index].id));
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(left: 15),
                              width: 120,
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
                                  successState.categories[index].title
                                      .toString(),
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
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            BlocBuilder<ExpenseBloc, ExpenseState>(
              bloc: expenseBloc,
              builder: (context, state) {
                if (state is FetchCategoryExpenseSuccess) {
                  final successState = state as FetchCategoryExpenseSuccess;

                  return Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: double.infinity,
                      height: 495,
                      child: Expense(successState.expenses));
                } else if (state is CategoryExpenseLoading) {
                  return Container(
                      margin: EdgeInsets.only(top: 200),
                      child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
