import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'module_localizations_en.dart';
import 'module_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ModuleLocalizations
/// returned by `ModuleLocalizations.of(context)`.
///
/// Applications need to include `ModuleLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/module_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ModuleLocalizations.localizationsDelegates,
///   supportedLocales: ModuleLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ModuleLocalizations.supportedLocales
/// property.
abstract class ModuleLocalizations {
  ModuleLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ModuleLocalizations of(BuildContext context) {
    return Localizations.of<ModuleLocalizations>(context, ModuleLocalizations)!;
  }

  static const LocalizationsDelegate<ModuleLocalizations> delegate = _ModuleLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// Logo text on the introduction screen
  ///
  /// In en, this message translates to:
  /// **'Talky'**
  String get introLogo;

  /// Sign in button text on the introduction screen
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get introSignInButton;

  /// Sign up information text on the introduction screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet?'**
  String get introSignUpInfo;

  /// Sign up button text on the introduction screen
  ///
  /// In en, this message translates to:
  /// **'Register here!'**
  String get introSignUpButton;

  /// App bar title on the login screen
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get signInAppBarTitle;

  /// Welcome title on the login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get signInTitle;

  /// Email field label on the login screen
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get signInEmailFieldLabel;

  /// Password field label on the login screen
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get signInPasswordFieldLabel;

  /// Error message when email field is Wrong on the sign in screen
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get signInIncorrectError;

  /// Error message when email field is invalid on the sign in screen
  ///
  /// In en, this message translates to:
  /// **'Field is invalid'**
  String get signInInvalidError;

  /// Error message when email field is empty on the sign in screen
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get signInEmptyError;

  /// Error message when something went wrong on the sign in screen
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong'**
  String get signInError;

  /// Sign in button text on the login screen
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// Forgot password text on the login screen
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get signInForgotPassword;

  /// App bar title on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpAppBarTitle;

  /// Email field title on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get signUpEmailTitle;

  /// Email field label on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signUpEmailFieldLabel;

  /// Error message when the email is invalid on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get signUpEmailInvalidError;

  /// Error message when the email field is empty on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get signUpEmailEmptyError;

  /// Password field title on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get signUpPasswordTitle;

  /// Password field label on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signUpPasswordFieldLabel;

  /// Error message when the password is less than N characters on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Invalid password. Must be at least 8 characters long'**
  String get signUpPasswordInvalidLengthError;

  /// Error message when the password does not contain at least one number and one letter on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Invalid password. Must contain at least one number and one letter'**
  String get signUpPasswordInvalidTypeError;

  /// Error message when the password field is empty on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get signUpPasswordEmptyError;

  /// Next button text on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get signUpEmailButton;

  /// Finish button text on the sign up screen
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get signUpPasswordButton;
}

class _ModuleLocalizationsDelegate extends LocalizationsDelegate<ModuleLocalizations> {
  const _ModuleLocalizationsDelegate();

  @override
  Future<ModuleLocalizations> load(Locale locale) {
    return SynchronousFuture<ModuleLocalizations>(lookupModuleLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_ModuleLocalizationsDelegate old) => false;
}

ModuleLocalizations lookupModuleLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return ModuleLocalizationsEn();
    case 'pt': return ModuleLocalizationsPt();
  }

  throw FlutterError(
    'ModuleLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
