import 'package:cinema/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final signInBloc = SignInBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
            const CinemaTextField(
              hintText: 'Почта',
            ),
            const SizedBox(
              height: 20,
            ),
            const CinemaTextField(
              obscureText: true,
              hintText: 'Пароль',
            ),
            const SizedBox(
              height: 20,
            ),
            const CinemaTextField(
              obscureText: true,
              hintText: 'Повторите пароль',
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SignUpPage()));
                },
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Уже есть аккаунт? Войти'))),
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
    );
  }
}

class CinemaTextField extends StatelessWidget {
  const CinemaTextField({
    super.key,
    required this.hintText,
    this.obscureText,
  });

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
