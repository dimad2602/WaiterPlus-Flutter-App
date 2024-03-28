import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_for_customers/domain/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app_for_customers/pages/first/first_page.dart';
import 'package:flutter_app_for_customers/pages/sign_in/sign_In_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


final Map<String, Widget Function(BuildContext context)> routes = {
  '/': (BuildContext context) =>
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return state.maybeMap(
            authenticated: (authenticatedState) {
              return PopScope(
                  canPop: true,
                  onPopInvoked: (didPop) async {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                  },
                  child: Scaffold(
                      body:
                          FirstPage())); // Здесь отображается контент для аутентифицированного пользователя
            },
            orElse: () {
              return const SignInPage();
            },
          );
        },
      ),
  //'/ActiveOrdersOldPage': (BuildContext context) => const ActiveOrdersOldPage(),
};
