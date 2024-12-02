import 'package:cinema/presentation/signin/view/signin.dart';
import 'package:cinema/presentation/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();

  final signUpBloc = SignUpBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<SignUpBloc, SignUpState>(
      bloc: signUpBloc,
      listener: (context, state) {
        if (state is SignUpSuccess) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Успешно!'),
                  content: Text('Вы успешно зарегистрировались!'),
                );
              }).then((_) {
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
        body: SingleChildScrollView(
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
              const SizedBox(
                height: 20,
              ),
              CinemaTextField(
                controller: passwordController2,
                obscureText: true,
                hintText: 'Повторите пароль',
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignInPage()));
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text('Уже есть аккаунт? Войти'))),
              GestureDetector(
                onTap: () {
                  if (passwordController.text == passwordController2.text) {
                    signUpBloc.add(SignUpWithEmailPassword(
                        email: emailController.text,
                        password: passwordController.text));
                  }
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
                      'Зарегистрироваться',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: obscureText ?? false,
        controller: controller,
        cursorColor: theme.primaryColor,
        decoration: InputDecoration(
            hintText: hintText, fillColor: theme.colorScheme.surfaceContainer),
      ),
    );
  }
}
