import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:i18n/l10n/l10n.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class SignUpEmailPage extends StatelessWidget {
  const SignUpEmailPage({super.key});

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
                context.l10n.signUpEmailTitle,
                style: TalkyTextStyles.headline1,
              ),
              const SizedBox(height: TKSpacing.x8),
              TextFormField(
                style: TalkyTextStyles.paragraph.medium,
                decoration: InputDecoration(
                  hintText: context.l10n.signUpEmailFieldLabel,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.navigateToInternalRoute(
                    route: AuthRoutes.signUpPasswordStep,
                  ),
                  child: Text(context.l10n.signUpEmailButton),
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
