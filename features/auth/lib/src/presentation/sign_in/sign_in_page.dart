import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:i18n/l10n/l10n.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(context.l10n.signInAppBarTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TKSpacing.x7),
          child: Column(
            children: [
              const SizedBox(height: TKSpacing.x9),
              Text(
                context.l10n.signInTitle,
                style: TalkyTextStyles.headline1,
              ),
              const SizedBox(height: TKSpacing.x8),
              TextFormField(
                style: TalkyTextStyles.paragraph.medium,
                decoration: InputDecoration(
                  hintText: context.l10n.signInEmailFieldLabel,
                ),
              ),
              const SizedBox(height: TKSpacing.x4),
              TextFormField(
                style: TalkyTextStyles.paragraph.medium,
                decoration: InputDecoration(
                  hintText: context.l10n.signInPasswordFieldLabel,
                ),
              ),
              const SizedBox(height: TKSpacing.x4),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  context.l10n.signInForgotPassword,
                  style: TalkyTextStyles.caption.apply(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: Text(context.l10n.signInButton),
                ),
              ),
              const SizedBox(height: TKSpacing.x7),
              Text(
                context.l10n.introSignUpInfo,
                style: TalkyTextStyles.paragraph.medium,
              ),
              TextButton(
                onPressed: () => context.navigateToInternalRoute(
                  route: AuthRoutes.signUpEmailStep,
                ),
                child: Text(context.l10n.introSignUpButton),
              ),
              const SizedBox(height: TKSpacing.x10),
            ],
          ),
        ),
      ),
    );
  }
}
