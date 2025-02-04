import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    required this.isOnline,
    this.size = 50,
    this.onTap,
    super.key,
  });

  final bool isOnline;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusSize = size * 0.24;
    final statusPadding = statusSize + (statusSize * 0.6);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
