import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:project_app/screens/add_screen.dart';
import 'package:project_app/auth/screens/login_screen.dart';
import 'package:project_app/screens/navbar_roots.dart';
import 'package:project_app/auth/screens/signup_screen.dart';
import 'package:project_app/auth/screens/edit_profile.dart';
import 'package:project_app/auth/screens/user_screen.dart';
import 'package:project_app/screens/welcome_screen.dart';
import 'package:project_app/auth/screens/admin.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
    GoRoute(path: '/adminPage', builder: (context, state) => Admin()),
    GoRoute(path: '/homePage', builder: (context, state) => NavBarRoots()),
    GoRoute(path: '/loginPage', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/signupPage', builder: (context, state) => SignUpScreen()),
    GoRoute(path: '/editPage', builder: (context, state) => EditScreen()),
    GoRoute(path: '/addPage', builder: (context, state) => AddScreen()),
    GoRoute(
      path: '/profilePage',
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: ProfileScreen(),
      ),
    ),
    GoRoute(
      path: '/back',
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: NavBarRoots(),
      ),
    ),
  ],
);
