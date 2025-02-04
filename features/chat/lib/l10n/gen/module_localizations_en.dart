import 'module_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ModuleLocalizationsEn extends ModuleLocalizations {
  ModuleLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get chatListPageTitle => 'Conversations';

  @override
  String get chatListPageDeleteChatTitle => 'Delete chat';

  @override
  String get chatListPageDeleteChatContent => 'Are you sure you want to delete this chat?';

  @override
  String get chatListPageDeleteChatCancel => 'Cancel';

  @override
  String get chatListPageDeleteChatDelete => 'Delete';
}
