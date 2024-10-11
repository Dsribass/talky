import 'package:auth/src/presentation/auth_localization.dart';
import 'package:flutter/material.dart';

import 'package:talky_ui_kit/talky_ui_kit.dart';

class SignUpPasswordPage extends StatelessWidget {
  const SignUpPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.signUpAppBarTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TKSpacing.x7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TKSpacing.x9),
              Text(
                context.l10n.signUpPasswordTitle,
                style: TalkyTextStyles.headline1,
              ),
              const SizedBox(height: TKSpacing.x8),
              TextFormField(
                style: TalkyTextStyles.paragraph.medium,
                decoration: InputDecoration(
                  hintText: context.l10n.signUpPasswordFieldLabel,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: Text(context.l10n.signUpPasswordButton),
                ),
              ),
              const SizedBox(height: TKSpacing.x8),
            ],
          ),
        ),
      ),
    );
  }
}
