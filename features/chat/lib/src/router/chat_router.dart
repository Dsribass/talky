import 'package:core/core.dart';
import 'package:flutter/material.dart';

enum ChatRoutes implements InternalRoutes {
  channels('channels');

  const ChatRoutes(this.path);

  @override
  final String path;

  @override
  String get name => toString().split('.').last;
}

final class ChatRouter implements RouterModule {
  @override
  List<GoRoute> get configuration => [
        GoRoute(
          name: GlobalRoutes.chat.name,
          path: GlobalRoutes.chat.path,
          builder: (_, __) => const Scaffold(
            body: Center(
              child: Text('Chat'),
            ),
          ),
        ),
      ];
}
