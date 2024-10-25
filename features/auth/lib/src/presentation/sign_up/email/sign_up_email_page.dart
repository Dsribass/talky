import 'package:auth/src/presentation/auth_localization.dart';
import 'package:auth/src/presentation/sign_up/email/sign_up_email_bloc.dart';
import 'package:auth/src/presentation/sign_up/email/sign_up_email_models.dart';
import 'package:auth/src/router/auth_router.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class SignUpEmailPage extends StatefulWidget {
  const SignUpEmailPage({super.key});

  @override
  State<SignUpEmailPage> createState() => _SignUpEmailPageState();
}

class _SignUpEmailPageState extends State<SignUpEmailPage> {
  late final SignUpEmailBloc _bloc;

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _bloc = SignUpEmailBloc(
      validateEmail: inject(),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _emailFocusNode.unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.signUpAppBarTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TKSpacing.x7),
            child: BlocConsumer<SignUpEmailBloc, SignUpEmailState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state.shouldProceedToNextStep) {
                  context.navigateToInternalRoute(
                    route: AuthRoutes.signUpPasswordStep,
                    pathParameters: {
                      AuthRouteParameters.email: _emailController.text,
                    },
                  );
                }
              },
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: TKSpacing.x9),
                  Text(
                    context.l10n.signUpEmailTitle,
                    style: TalkyTextStyles.headline1,
                  ),
                  const SizedBox(height: TKSpacing.x8),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    style: TalkyTextStyles.paragraph.medium,
                    decoration: InputDecoration(
                      hintText: context.l10n.signUpEmailFieldLabel,
                      errorText: _getErrorMessage(
                        state.emailInputStatus,
                        context,
                      ),
                    ),
                    onChanged: (value) => _bloc.add(
                      SignUpEmailEmailChanged(email: value),
                    ),
                  ),
                  const Spacer(),
                  TalkyFilledButton(
                    width: double.infinity,
                    onPressed: state.shouldEnableSignUpButton
                        ? () => _bloc.add(
                              SignUpEmailSubmitted(
                                email: _emailController.text,
                              ),
                            )
                        : null,
                    label: Text(context.l10n.signUpEmailButton),
                  ),
                  const SizedBox(height: TKSpacing.x8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _getErrorMessage(
    SignUpEmailModelInputStatus status,
    BuildContext context,
  ) =>
      switch (status) {
        SignUpEmailModelInputStatus.invalid =>
          context.l10n.signUpEmailInvalidError,
        SignUpEmailModelInputStatus.empty => context.l10n.signUpEmailEmptyError,
        _ => null,
      };
}
