import 'package:flutter/material.dart';
import 'package:flutter_app_for_customers/components/big_text.dart';
import 'package:flutter_app_for_customers/components/my_text_field.dart';
import 'package:flutter_app_for_customers/domain/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app_for_customers/domain/blocs/sign_in/sign_in_bloc.dart';
import 'package:flutter_app_for_customers/domain/repositories/sign_in_repo/sign_in_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(SignInRepo()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('SignInPage'),
        ),
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            state.maybeWhen(
                failure: (_) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Ошибка: state.errorMessage')));
                },
                orElse: () {});
          },
          builder: (context, state) {
            return BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return state.when(initial: () {
                  return buildCompleteUI(context);
                }, loading: () //String email, String password
                    {
                  return circularProgressIndicatorUI();
                }, failure: (error) {
                  return buildCompleteUI(context);
                }, success: (user) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationEvent.userLoggedIn(user));
                    Navigator.of(context).pushReplacementNamed('/');
                  });
                  return const SizedBox.shrink();
                });
              },
            );
          },
        ),
      ),
    );
  }
}

Widget circularProgressIndicatorUI() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildCompleteUI(BuildContext context) {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: (context, state) {
      return state.when(authenticated: (user) {
        return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            BigText(text: "Вы вошли в аккаунт ${user.email}"),
            const SizedBox(
              height: 12,
            ),
            FilledButton(
              onPressed: () async {
                context
                    .read<AuthenticationBloc>()
                    .add(const AuthenticationEvent.userLoggedOut());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6750a4),
              ),
              child: const Text(
                'Выйти из аккаунта?',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ]),
        );
      }, unauthenticated: () {
        return Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            MyTextField(labelText: 'Email', controller: _emailController),
            const SizedBox(
              height: 15,
            ),
            MyTextField(
              labelText: 'password',
              controller: _passwordController,
              hiddenText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            FilledButton(
                onPressed: () {
                  context.read<SignInBloc>().add(SignInEvent.signInWithEmail(
                      email: _emailController.text,
                      password: _passwordController.text));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6750a4),
                ),
                child: const BigText(
                  text: "Войти",
                  color: Colors.white,
                )),
            const SizedBox(
              height: 15,
            ),
            IconButton(
                color: const Color(0xff6750a4),
                onPressed: () {
                  context
                      .read<SignInBloc>()
                      .add(const SignInEvent.signInWithSocialNetwork());
                },
                icon: const Icon(
                  Icons.discord,
                  size: 36,
                )), //Icons.reddit
          ],
        );
      });
    },
  );
}

Widget buildFailureUI(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BigText(text: 'Sign In failed'),
        const SizedBox(height: 16),
        FilledButton(
            onPressed: () {
              context.read<SignInBloc>().add(const SignInEvent.started());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff6750a4),
            ),
            child: const BigText(
              text: "Retry",
              color: Colors.white,
            )),
      ],
    ),
  );
}

Widget buildSuccessUI(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BigText(text: 'Sign In failed'),
        const SizedBox(height: 16),
        FilledButton(
            onPressed: () {
              context.read<SignInBloc>().add(const SignInEvent.started());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff6750a4),
            ),
            child: const BigText(
              text: "Retry",
              color: Colors.white,
            )),
      ],
    ),
  );
}
