import 'module_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class ModuleLocalizationsPt extends ModuleLocalizations {
  ModuleLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get chatListPageTitle => 'Conversas';

  @override
  String get chatListPageDeleteChatTitle => 'Excluir conversa';

  @override
  String get chatListPageDeleteChatContent => 'Tem certeza de que deseja excluir esta conversa?';

  @override
  String get chatListPageDeleteChatCancel => 'Cancelar';

  @override
  String get chatListPageDeleteChatDelete => 'Excluir';
}
