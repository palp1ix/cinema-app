import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/auth/pages/signup/bloc/signup_bloc.dart';
import 'package:cinema/presentation/auth/widgets/default_auth_view.dart';
import 'package:cinema/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
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
      listener: (context, state) async {
        if (state is SignUpSuccess) {
          await showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Success!'),
                  content: Text('You have successfully registered!'),
                );
              });
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome',
              style: theme.textTheme.titleLarge,
            ),
          ),
          body: DefaultAuthView(
              emailController: emailController,
              passwordController: passwordController,
              secondPasswordController: passwordController2,
              theme: theme,
              buttonText: 'Sign up',
              smallInfoText: 'Already have an account? Sign in',
              onTextTap: () {
                context.router.replace(const SignInRoute());
              },
              onButtonTap: () {
                if (passwordController.text == passwordController2.text) {
                  signUpBloc.add(SignUpWithEmailPassword(
                      email: emailController.text,
                      password: passwordController.text));
                }
              })),
    );
  }
}
