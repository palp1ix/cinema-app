import 'package:cinema/presentation/signin/bloc/signin_bloc.dart';
import 'package:cinema/presentation/signup/view/signup.dart';
import 'package:cinema/repository/managers/auth_manager/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final signInBloc = SignInBloc();
  final authManager = GetIt.I<AuthManager>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (authManager.getStatus() == AuthStatus.notLoggedIn) {
      final theme = Theme.of(context);
      return BlocListener<SignInBloc, SignInState>(
        bloc: signInBloc,
        listener: (context, state) {
          if (state is SignInSuccess) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text('Успешно'),
                      content: Text('Вы успешно вошли в систему'),
                    )).then((_) {
              Navigator.of(context).pop();
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Добро пожаловать!',
              style: theme.textTheme.titleLarge,
            ),
          ),
          body: SignUpWidget(
              signInBloc: signInBloc,
              emailController: emailController,
              passwordController: passwordController,
              theme: theme),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Извините, вы уже вошли в систему'),
          ));
    }
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    super.key,
    required this.signInBloc,
    required this.emailController,
    required this.passwordController,
    required this.theme,
  });

  final SignInBloc signInBloc;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            'assets/images/cinema-sample.png',
            height: 250,
          ),
          const SizedBox(height: 30),
          CinemaTextField(
            controller: emailController,
            hintText: 'Почта',
          ),
          const SizedBox(
            height: 20,
          ),
          CinemaTextField(
            controller: passwordController,
            obscureText: true,
            hintText: 'Пароль',
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignUpPage()));
              },
              child: Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text('Еще нет аккаунта? Зарегистрируйся'))),
          GestureDetector(
            onTap: () {
              signInBloc.add(SignInWithEmailPassword(
                  email: emailController.text,
                  password: passwordController.text));
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.primaryColor,
              ),
              child: Center(
                child: Text(
                  'Войти',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CinemaTextField extends StatelessWidget {
  const CinemaTextField({
    super.key,
    required this.hintText,
    this.obscureText,
    required this.controller,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: obscureText ?? false,
        controller: TextEditingController(),
        cursorColor: theme.primaryColor,
        decoration: InputDecoration(
            hintText: hintText, fillColor: theme.colorScheme.surfaceContainer),
      ),
    );
  }
}
