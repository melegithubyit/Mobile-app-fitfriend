// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/Income/bloc/income_bloc.dart';
import 'package:project_app/Income/bloc/income_event.dart';
import 'package:project_app/Income/bloc/income_state.dart';
import 'package:project_app/auth/bloc/auth_bloc.dart';
import 'package:project_app/auth/bloc/auth_event.dart';
import 'package:project_app/auth/bloc/auth_state.dart';
import 'package:project_app/categories/bloc/category_bloc.dart';
import 'package:project_app/categories/bloc/category_event.dart';
import 'package:project_app/categories/bloc/category_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_app/expenses/screens/create_expense.dart';
import 'package:project_app/categories/screens/update_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryBloc categoryBloc = CategoryBloc();

  final AuthBloc authBloc = AuthBloc();
  final IncomeBloc incomeBloc = IncomeBloc();

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void initState() {
    categoryBloc.add(GetCategoryEvent());
    incomeBloc.add(GetIncomeEvent());
    authBloc.add(GetUserDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(),
          ),
          BlocProvider<IncomeBloc>(
            create: (context) => IncomeBloc(),
          ),
          BlocProvider<IncomeBloc>(
            create: (context) => IncomeBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
        ],
        child: Scaffold(
          body: SafeArea(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 330,
                    child: Stack(
                      children: [
                        SizedBox(height: 9),
                        SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 240,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 43, 153, 146),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(105),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(top: 6),
                                            child: InkWell(
                                              child: Icon(
                                                Icons.question_mark,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            )),
                                        Container(
                                            padding: EdgeInsets.only(top: 6),
                                            child: InkWell(
                                              child: Icon(
                                                Icons.person,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              onTap: () =>
                                                  context.go('/profilePage'),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 60, left: 40),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Welcome",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          BlocBuilder<AuthBloc, AuthState>(
                                            bloc: authBloc,
                                            builder: (context, state) {
                                              if (state
                                                  is GetUserDetailSuccess) {
                                                return Text(
                                                  state.username,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 120,
                          left: 16,
                          child: Container(
                              height: 170,
                              width: 360,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 34, 123, 117),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(80, 2, 68, 65),
                                      offset: Offset(0, 6),
                                      blurRadius: 12,
                                      spreadRadius: 6,
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20, left: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<IncomeBloc, IncomeState>(
                                          bloc: incomeBloc,
                                          builder: (context, state) {
                                            if (state is FetchIncomeSuccess) {
                                              final successState =
                                                  state as FetchIncomeSuccess;
                                              double income;
                                              double expense;
                                              if (successState.income.length ==
                                                  0) {
                                                income = 0;
                                                expense = 0;
                                              } else {
                                                income = successState
                                                    .income[0].income;
                                                expense = successState
                                                    .income[0].total_expense;
                                              }

                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Balance",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  income != 0
                                                      ? Row(children: [
                                                          Icon(
                                                              CupertinoIcons
                                                                  .money_dollar,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                              "${income - expense}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    income == 0
                                                                        ? 14
                                                                        : 20,
                                                                color: income ==
                                                                        0
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .white,
                                                              ))
                                                        ])
                                                      : Text("set income"),
                                                ],
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text(
                                              "Income",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            BlocBuilder<IncomeBloc,
                                                IncomeState>(
                                              bloc: incomeBloc,
                                              builder: (context, state) {
                                                if (state
                                                    is FetchIncomeSuccess) {
                                                  final successState = state
                                                      as FetchIncomeSuccess;
                                                  double income;
                                                  double expense;
                                                  double difference;
                                                  if (successState
                                                          .income.length ==
                                                      0) {
                                                    income = 0;
                                                    expense = 0;
                                                    difference = 0;
                                                  } else {
                                                    income = successState
                                                        .income[0].income;
                                                    expense = successState
                                                        .income[0]
                                                        .total_expense;
                                                    difference =
                                                        income - expense;
                                                  }
                                                  if (income == 0) {
                                                    return Container();
                                                  }

                                                  return CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        difference >= 0
                                                            ? Color.fromARGB(
                                                                102,
                                                                32,
                                                                239,
                                                                115)
                                                            : Color.fromARGB(
                                                                102,
                                                                239,
                                                                32,
                                                                32),
                                                    child: Icon(
                                                      difference >= 0
                                                          ? Icons.arrow_upward
                                                          : Icons
                                                              .arrow_downward,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        BlocBuilder<IncomeBloc, IncomeState>(
                                            bloc: incomeBloc,
                                            builder: (context, state) {
                                              if (state is FetchIncomeSuccess) {
                                                final successState =
                                                    state as FetchIncomeSuccess;
                                                double income;
                                                if (successState
                                                        .income.length ==
                                                    0) {
                                                  income = 0;
                                                } else {
                                                  income = successState
                                                      .income[0].income;
                                                }
                                                if (income != 0) {
                                                  return Row(
                                                    children: [
                                                      Icon(
                                                          CupertinoIcons
                                                              .money_dollar,
                                                          color: Colors.white),
                                                      Text(income.toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                income == 0
                                                                    ? 14
                                                                    : 20,
                                                            color: income == 0
                                                                ? Colors.red
                                                                : Colors.white,
                                                          ))
                                                    ],
                                                  );
                                                } else {
                                                  return Text("set income");
                                                }
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  context.go('/addPage'),
                                              child: Icon(
                                                CupertinoIcons
                                                    .add_circled_solid,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Add",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 13),
                                        Row(
                                          children: [
                                            Text(
                                              "Expense",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            BlocBuilder<IncomeBloc,
                                                IncomeState>(
                                              bloc: incomeBloc,
                                              builder: (context, state) {
                                                if (state
                                                    is FetchIncomeSuccess) {
                                                  final successState = state
                                                      as FetchIncomeSuccess;
                                                  double income;
                                                  double difference;
                                                  double expense;
                                                  if (successState
                                                          .income.length ==
                                                      0) {
                                                    income = 0;
                                                    expense = 0;
                                                    difference = 0;
                                                  } else {
                                                    income = successState
                                                        .income[0].income;
                                                    expense = successState
                                                        .income[0]
                                                        .total_expense;
                                                    difference =
                                                        income - expense;
                                                  }

                                                  if (income == 0) {
                                                    return Container();
                                                  }

                                                  return CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        difference >= 0
                                                            ? Color.fromARGB(
                                                                102,
                                                                32,
                                                                239,
                                                                115)
                                                            : Color.fromARGB(
                                                                102,
                                                                239,
                                                                32,
                                                                32),
                                                    child: Icon(
                                                      difference >= 0
                                                          ? Icons.arrow_downward
                                                          : Icons.arrow_upward,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        BlocBuilder<IncomeBloc, IncomeState>(
                                            bloc: incomeBloc,
                                            builder: (context, state) {
                                              if (state is FetchIncomeSuccess) {
                                                final successState =
                                                    state as FetchIncomeSuccess;
                                                double expense;
                                                if (successState
                                                        .income.length ==
                                                    0) {
                                                  expense = 0;
                                                } else {
                                                  expense = successState
                                                      .income[0].total_expense;
                                                }

                                                return Row(
                                                  children: [
                                                    Icon(
                                                        CupertinoIcons
                                                            .money_dollar,
                                                        color: Colors.white),
                                                    Text(
                                                      "${expense}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Expense Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 15, 14, 14),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: SizedBox(
                    height: 390,
                    width: double.infinity,
                    child: BlocConsumer<CategoryBloc, CategoryState>(
                      bloc: categoryBloc,
                      listener: (context, state) {
                        if (state is DeleteCategorySuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('successfully deleted'),
                            ),
                          );

                          categoryBloc.add(GetCategoryEvent());
                          incomeBloc.add(GetIncomeEvent());
                        }
                      },
                      builder: (context, state) {
                        if (state is FetchCategorySuccess) {
                          final successState = state as FetchCategorySuccess;
                          if (successState.categories.isEmpty) {
                            return Center(
                              child: Text(
                                "No categories found, add categories",
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: successState.categories.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (ctx, index) {
                              return Container(
                                  margin: EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(22, 12, 131, 125),
                                      blurRadius: 0,
                                      offset: Offset(0, 1),
                                      spreadRadius: 1,
                                    )
                                  ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        // padding: EdgeInsets.only(top: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              successState
                                                  .categories[index].title
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      207, 0, 0, 0),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Budget:",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          255, 59, 141, 47)),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                successState.categories[index]
                                                            .budget !=
                                                        0
                                                    ? Icon(
                                                        CupertinoIcons
                                                            .money_dollar,
                                                        size: 20,
                                                        color: Colors.black)
                                                    : Container(),
                                                Text(successState
                                                            .categories[index]
                                                            .budget !=
                                                        0
                                                    ? successState
                                                        .categories[index]
                                                        .budget
                                                        .toString()
                                                    : "not set"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "expenses",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          255, 156, 44, 36)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                    CupertinoIcons.money_dollar,
                                                    size: 20,
                                                    color: Colors.black),
                                                Text(successState
                                                    .categories[index].expense
                                                    .toString()),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CreateExpense(
                                                                  successState
                                                                      .categories[
                                                                          index]
                                                                      .id,
                                                                  successState
                                                                      .categories[
                                                                          index]
                                                                      .title),
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .add_circled_solid,
                                                      color: Color.fromARGB(
                                                          255, 0, 149, 255),
                                                      size: 29,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Expense',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            207, 0, 0, 0),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => UpdateCategory(
                                                                successState
                                                                    .categories[
                                                                        index]
                                                                    .id,
                                                                successState
                                                                    .categories[
                                                                        index]
                                                                    .title,
                                                                successState
                                                                    .categories[
                                                                        index]
                                                                    .budget)),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color.fromARGB(
                                                              255,
                                                              9,
                                                              128,
                                                              149)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              BlocConsumer<CategoryBloc,
                                                  CategoryState>(
                                                bloc: categoryBloc,
                                                listener: (context, state) {},
                                                builder: (context, state) {
                                                  return Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          categoryBloc.add(
                                                              DeleteCategoryEvent(
                                                                  successState
                                                                      .categories[
                                                                          index]
                                                                      .id));
                                                        },
                                                        child: Text(
                                                          "Remove",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      156,
                                                                      44,
                                                                      36)),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            ]),
                                      )
                                    ],
                                  ));
                            },
                          );
                        } else if (state is CategoryLoading) {
                          return Center(
                              child: CupertinoActivityIndicator(radius: 50));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

//   Widget _head(context) {
//     return Stack(
//       children: [
//         SizedBox(height: 9),
//         SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 240,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 43, 153, 146),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(105),
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                             padding: EdgeInsets.only(top: 6),
//                             child: InkWell(
//                               child: Icon(
//                                 Icons.question_mark,
//                                 size: 30,
//                                 color: Colors.white,
//                               ),
//                               onTap: () => context.go('/helpPage'),
//                             )),
//                         Container(
//                             padding: EdgeInsets.only(top: 6),
//                             child: InkWell(
//                               child: Icon(
//                                 Icons.person,
//                                 size: 30,
//                                 color: Colors.white,
//                               ),
//                               onTap: () => context.go('/profilePage'),
//                             )),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 60, left: 40),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Welcome",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             "Dagim Demissew",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 20,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 120,
//           left: 16,
//           child: Container(
//               height: 170,
//               width: 360,
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 34, 123, 117),
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(80, 2, 68, 65),
//                       offset: Offset(0, 6),
//                       blurRadius: 12,
//                       spreadRadius: 6,
//                     )
//                   ]),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 20, left: 30),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         BlocBuilder<IncomeBloc, IncomeState>(
//                           bloc: incomeBloc,
//                           builder: (context, state) {
//                             if (state is FetchIncomeSuccess) {
//                               final successState = state as FetchIncomeSuccess;
//                               print(successState.income);
//                               return Container();
//                             } else {
//                               return Container();
//                             }
//                             return Text(
//                               "Balance",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             );
//                           },
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           "2000B ETB",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Text(
//                               "Income",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             CircleAvatar(
//                               radius: 13,
//                               backgroundColor:
//                                   Color.fromARGB(102, 32, 239, 115),
//                               child: Icon(
//                                 Icons.arrow_downward,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           "2000 ETB",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Add",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => context.go('/addPage'),
//                           child: Icon(
//                             CupertinoIcons.add_circled_solid,
//                             color: Colors.white,
//                             size: 40,
//                           ),
//                         ),
//                         SizedBox(height: 13),
//                         Row(
//                           children: [
//                             Text(
//                               "Expense",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             CircleAvatar(
//                               radius: 13,
//                               backgroundColor: Color.fromARGB(102, 239, 32, 32),
//                               child: Icon(
//                                 Icons.arrow_upward,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           "200 ETB",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )),
//         ),
//       ],
//     );
//   }
// }
