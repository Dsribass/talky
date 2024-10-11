import 'package:auth/src/presentation/auth_localization.dart';
import 'package:auth/src/router/auth_router.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:talky_ui_kit/talky_ui_kit.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TKSpacing.x7),
          child: Column(
            children: [
              const Expanded(child: _Logo()),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.navigateToInternalRoute(
                    route: AuthRoutes.signIn,
                  ),
                  child: Text(context.l10n.introSignInButton),
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

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 124),
        TalkyAssets.icons.logo(),
        RichText(
          text: TextSpan(
            text: context.l10n.introLogo,
            style: TalkyTextStyles.custom(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
            children: [
              TextSpan(
                text: '.',
                style: TalkyTextStyles.custom(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
