import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/theme/theme.dart';
import 'package:talky_ui_kit/src/tokens/tokens.dart';

class ValidationList extends StatelessWidget {
  const ValidationList({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<ValidationItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TalkyTextStyles.paragraph,
        ),
        const SizedBox(height: TKSpacing.x2),
        Padding(
          padding: const EdgeInsets.only(left: TKSpacing.x2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
        ),
      ],
    );
  }
}

enum ValidationItemState {
  idle,
  valid,
  invalid,
}

class ValidationItem extends StatelessWidget {
  const ValidationItem({
    required this.state,
    required this.text,
    super.key,
  });

  final ValidationItemState state;
  final String text;

  String get _icon => switch (state) {
        ValidationItemState.idle => '•',
        ValidationItemState.valid => '✓',
        ValidationItemState.invalid => '✕',
      };

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TalkyTextStyles.paragraph.copyWith(
          color: switch (state) {
            ValidationItemState.idle => context.colors.onSurface,
            ValidationItemState.valid => context.colors.success,
            ValidationItemState.invalid => context.colors.error,
          },
        ),
        children: [
          TextSpan(text: _icon),
          const TextSpan(text: ' '),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
