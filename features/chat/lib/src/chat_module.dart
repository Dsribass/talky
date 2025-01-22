import 'package:chat/src/di/chat_container.dart';
import 'package:chat/src/presentation/chat_localization.dart';
import 'package:chat/src/router/chat_router.dart';
import 'package:core/modular.dart';

final class ChatModule extends Module {
  ChatModule()
      : super(
          router: ChatRouter(),
          container: ChatContainer(),
          localization: ChatLocalization(),
        );
}
