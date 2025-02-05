import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    required this.imageURL,
    required this.isOnline,
    this.size = 50,
    this.onTap,
    super.key,
  });

  final String? imageURL;
  final bool isOnline;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusSize = size * 0.24;
    final statusPadding = statusSize + (statusSize * 0.6);

    final imagePlaceholder = _imagePlaceholder(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipOval(
            child: imageURL != null
                ? CachedNetworkImage(
                    imageUrl: imageURL!,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => imagePlaceholder,
                    errorWidget: (context, url, error) => imagePlaceholder,
                  )
                : imagePlaceholder,
          ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: statusPadding,
                height: statusPadding,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  width: statusSize,
                  height: statusSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.success,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: context.colors.outline,
      alignment: Alignment.center,
      child: Icon(
        Icons.person,
        color: context.colors.surface,
        size: size * 0.5,
      ),
    );
  }
}
