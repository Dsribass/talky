import 'package:chat/chat.dart';
import 'package:chat/src/presentation/list/components/profile_icon.dart';
import 'package:core/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    required this.tileKey,
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.sendAt,
    required this.isOnline,
    required this.onDeleted,
    required this.onTap,
    required this.unreadMessages,
    super.key,
  });

  final Key tileKey;
  final String name;
  final bool isOnline;
  final String? lastMessage;
  final DateTime sendAt;
  final VoidCallback onDeleted;
  final VoidCallback onTap;
  final int unreadMessages;
  final String? imageUrl;

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) =>
      showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.chatListPageDeleteChatTitle),
            content: Text(context.l10n.chatListPageDeleteChatContent),
            actions: [
              TalkyTextButton(
                foregroundColor: context.colors.onSurfaceVariant,
                onPressed: () => Navigator.of(context).pop(false),
                label: Text(context.l10n.chatListPageDeleteChatCancel),
              ),
              TalkyTextButton(
                foregroundColor: context.colors.error,
                onPressed: () => Navigator.of(context).pop(true),
                label: Text(context.l10n.chatListPageDeleteChatDelete),
              ),
            ],
          );
        },
      ).then((value) => value ?? false);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: tileKey,
      onDismissed: (_) => onDeleted(),
      confirmDismiss: (_) => _showDeleteConfirmationDialog(context),
      background: Container(
        color: context.colors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: TKSpacing.x4),
        child: Icon(Icons.delete, color: context.colors.onError),
      ),
      direction: DismissDirection.endToStart,
      child: ListTile(
        onTap: onTap,
        // TODO(any): implement imageURL
        leading: ProfileIcon(isOnline: isOnline),
        title: Text(name),
        subtitle: Text(
          lastMessage ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sendAt.format(context),
              style: TalkyTextStyles.caption.copyWith(
                color: unreadMessages > 0 ? context.colors.primary : null,
              ),
            ),
            const SizedBox(height: TKSpacing.x2),
            if (unreadMessages > 0)
              Container(
                padding: const EdgeInsets.all(TKSpacing.x2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.primary,
                ),
                child: Text(
                  unreadMessages.toString(),
                  style: TalkyTextStyles.custom(fontSize: 10).regular.copyWith(
                        color: context.colors.onPrimary,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

extension on DateTime {
  String format(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0 && difference.inDays < 7) {
      final dateFormat = DateFormat('EEEE');
      return dateFormat.format(this);
    } else if (difference.inDays >= 7) {
      final dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.format(this);
    } else {
      final dateFormat = DateFormat('HH:mm');
      return dateFormat.format(this);
    }
  }
}
