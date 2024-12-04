import 'package:cinema/presentation/auth/widgets/cinema_text_field.dart';
import 'package:flutter/material.dart';

class DefaultAuthView extends StatelessWidget {
  const DefaultAuthView({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.theme,
    this.secondPasswordController,
    required this.buttonText,
    required this.smallInfoText,
    required this.onButtonTap,
    required this.onTextTap,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? secondPasswordController;
  final String buttonText;
  final String smallInfoText;
  final void Function() onButtonTap;
  final void Function() onTextTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 30),
          CinemaTextField(
            controller: emailController,
            hintText: 'Email',
          ),
          const SizedBox(
            height: 20,
          ),
          CinemaTextField(
            controller: passwordController,
            obscureText: true,
            hintText: 'Password',
          ),
          if (secondPasswordController != null)
            const SizedBox(
              height: 20,
            ),
          if (secondPasswordController != null)
            CinemaTextField(
              controller: secondPasswordController!,
              obscureText: true,
              hintText: 'Repeat password',
            ),
          GestureDetector(
              onTap: () {
                onTextTap.call();
              },
              child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(smallInfoText))),
          GestureDetector(
            onTap: () {
              onButtonTap.call();
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
                  buttonText,
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
