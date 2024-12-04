import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/auth/pages/signin/bloc/signin_bloc.dart';
import 'package:cinema/domain/auth_manager/auth_manager.dart';
import 'package:cinema/presentation/auth/widgets/default_auth_view.dart';
import 'package:cinema/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
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
        listener: (context, state) async {
          if (state is SignInSuccess) {
            await showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text('Success'),
                      content: Text('You have successfully logged in'),
                    ));
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome!',
              style: theme.textTheme.titleLarge,
            ),
          ),
          body: SignInWidget(
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
            child: Text('Sorry, you\'re already logged in'),
          ));
    }
  }
}

class SignInWidget extends StatelessWidget {
  const SignInWidget({
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
    return DefaultAuthView(
        emailController: emailController,
        passwordController: passwordController,
        buttonText: 'Login',
        onTextTap: () {
          context.router.replace(const SignUpRoute());
        },
        onButtonTap: () {
          signInBloc.add(SignInWithEmailPassword(
              email: emailController.text, password: passwordController.text));
        },
        smallInfoText: 'Don\'t have an account? Sign up',
        theme: theme);
  }
}
