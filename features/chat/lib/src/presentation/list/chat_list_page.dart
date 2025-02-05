import 'dart:developer';

import 'package:chat/chat.dart';
import 'package:chat/src/presentation/components/conversation_tile.dart';
import 'package:chat/src/presentation/components/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: TKSpacing.x4),
            ProfileImage(
              imageURL: _fakeUserList.first.imageURL,
              isOnline: false,
              size: 36,
            ),
          ],
        ),
        title: Text(context.l10n.chatListPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: context.colors.onSurface,
            onPressed: () {}, // TODO(any): Implement search
          ),
          TalkyIconButton(
            icon: const Icon(Icons.add),
            onPressed: () {}, // TODO(any): Implement add chat
          ),
          const SizedBox(width: TKSpacing.x4),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView.separated(
          itemCount: _fakeUserList.length,
          padding: const EdgeInsets.symmetric(vertical: TKSpacing.x4),
          separatorBuilder: (context, index) => Divider(
            height: 0,
            color: context.colors.surfaceContainer,
          ),
          itemBuilder: (context, index) {
            final user = _fakeUserList[index];
            return ConversationTile(
              tileKey: ValueKey(user.id),
              imageUrl: user.imageURL,
              name: user.name,
              lastMessage: user.lastMessage,
              sendAt: user.sendAt,
              isOnline: user.isOnline,
              unreadMessages: user.unreadMessages,
              onDeleted: () => setState(() => _fakeUserList.removeAt(index)),
              onTap: () => log('Tapped on ${user.name}'),
            );
          },
        ),
      ),
    );
  }
}

@immutable
class _FakeUser {
  const _FakeUser({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.lastMessage,
    required this.imageURL,
    required this.unreadMessages,
    required this.sendAt,
  });

  final String id;
  final String name;
  final bool isOnline;
  final String? lastMessage;
  final String? imageURL;
  final int unreadMessages;
  final DateTime sendAt;
}

final _fakeUserList = [
  _FakeUser(
    unreadMessages: 5,
    id: '1',
    name: 'João',
    isOnline: true,
    lastMessage: 'Olá, tudo bem?',
    sendAt: DateTime.now(),
    imageURL: 'https://picsum.photos/60/60',
  ),
  _FakeUser(
    unreadMessages: 2,
    id: '2',
    name: 'Maria',
    isOnline: false,
    lastMessage: 'Tudo bem, e você?',
    sendAt: DateTime.now().subtract(const Duration(minutes: 5)),
    imageURL: 'https://randomuser.me/api/port',
  ),
  _FakeUser(
    unreadMessages: 0,
    id: '3',
    name: 'Pedro',
    isOnline: true,
    lastMessage: 'Estou bem, obrigado!',
    sendAt: DateTime.now().subtract(const Duration(hours: 6)),
    imageURL: 'https://picsum.photos/50/50',
  ),
  _FakeUser(
    unreadMessages: 0,
    id: '4',
    name: 'José',
    isOnline: true,
    lastMessage: 'Estou bem, obrigado!',
    sendAt: DateTime.now().subtract(const Duration(days: 1)),
    imageURL: 'https://picsum.photos/50/50',
  ),
  _FakeUser(
    unreadMessages: 0,
    id: '5',
    name: 'Ana',
    isOnline: false,
    lastMessage: 'Que bom!',
    sendAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
    imageURL: null,
  ),
  _FakeUser(
    unreadMessages: 0,
    id: '6',
    name: 'Carlos',
    isOnline: false,
    lastMessage: 'Que bom!',
    sendAt: DateTime.now().subtract(const Duration(days: 6)),
    imageURL: 'https://picsum.photos/50/50',
  ),
  _FakeUser(
    unreadMessages: 0,
    id: '7',
    name: 'Mariana',
    isOnline: true,
    lastMessage:
        'Olha, você não vai acreditar! 😱. Ontem eu descobri que o fulano está fazendo faculdade',
    sendAt: DateTime.now().subtract(const Duration(days: 10)),
    imageURL: 'https://picsum.photos/50/50',
  ),
  _FakeUser(
    unreadMessages: 0,
    id: '8',
    name: 'Fernanda',
    isOnline: false,
    lastMessage: null,
    sendAt: DateTime.now().subtract(const Duration(days: 60)),
    imageURL: null,
  ),
];
