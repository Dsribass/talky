import 'package:auth/src/router/auth_router.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SignUpEmailPage extends StatelessWidget {
  const SignUpEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Email'),
            ElevatedButton(
              onPressed: () => context.navigateToInternalRoute(
                route: AuthRoutes.signUpPasswordStep,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
