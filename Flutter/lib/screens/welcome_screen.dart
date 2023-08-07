// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_app/screens/home_screen.dart';
import 'package:project_app/sqlDB.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveToken(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return HomeScreen();
        } else {
          return Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset("images/image2.jpg"),
                ),
                SizedBox(height: 50),
                Text(
                  "Expense Boss",
                  style: TextStyle(
                    color: Color.fromARGB(255, 29, 132, 82),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 1,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Save Your expenses!",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Color.fromARGB(255, 29, 132, 82),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => context.go('/loginPage'),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Color.fromARGB(255, 29, 132, 82),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => context.go('/signupPage'),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          );
        }
      },
    );
  }
}
