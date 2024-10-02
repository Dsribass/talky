import 'package:flutter/material.dart';

class SignUpPasswordPage extends StatelessWidget {
  const SignUpPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: Text('Password'),
      ),
    );
  }
}
