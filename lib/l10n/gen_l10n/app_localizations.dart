import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// No description provided for @victory.
  ///
  /// In en, this message translates to:
  /// **'Victory!'**
  String get victory;

  /// No description provided for @returnToMenu.
  ///
  /// In en, this message translates to:
  /// **'Return to Menu'**
  String get returnToMenu;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @pauseTitle.
  ///
  /// In en, this message translates to:
  /// **'Game Paused'**
  String get pauseTitle;

  /// No description provided for @pauseContent.
  ///
  /// In en, this message translates to:
  /// **'Take a break or adjust your strategy.'**
  String get pauseContent;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @quit.
  ///
  /// In en, this message translates to:
  /// **'Quit'**
  String get quit;

  /// No description provided for @upgradeTower.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Tower'**
  String get upgradeTower;

  /// No description provided for @currentLevel.
  ///
  /// In en, this message translates to:
  /// **'Current Level: {level}'**
  String currentLevel(Object level);

  /// No description provided for @upgradeCost.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Cost: {cost}'**
  String upgradeCost(Object cost);

  /// No description provided for @upgradeWill.
  ///
  /// In en, this message translates to:
  /// **'Upgrading will:'**
  String get upgradeWill;

  /// No description provided for @upgradeEffect1.
  ///
  /// In en, this message translates to:
  /// **'• Increase damage by 20%'**
  String get upgradeEffect1;

  /// No description provided for @upgradeEffect2.
  ///
  /// In en, this message translates to:
  /// **'• Increase range by 10%'**
  String get upgradeEffect2;

  /// No description provided for @upgradeEffect3.
  ///
  /// In en, this message translates to:
  /// **'• Increase fire rate by 10%'**
  String get upgradeEffect3;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @selectLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Level'**
  String get selectLevelTitle;

  /// No description provided for @selectLevelCampaign.
  ///
  /// In en, this message translates to:
  /// **'Campaign'**
  String get selectLevelCampaign;

  /// No description provided for @selectLevelSpecial.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get selectLevelSpecial;

  /// No description provided for @selectLevelEndlessTitle.
  ///
  /// In en, this message translates to:
  /// **'ENDLESS'**
  String get selectLevelEndlessTitle;

  /// No description provided for @selectLevelEndlessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'MODE'**
  String get selectLevelEndlessSubtitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSection;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @versionNumber.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get versionNumber;

  /// No description provided for @whyThisGame.
  ///
  /// In en, this message translates to:
  /// **'Why This Game?'**
  String get whyThisGame;

  /// No description provided for @githubRepository.
  ///
  /// In en, this message translates to:
  /// **'GitHub Repository'**
  String get githubRepository;

  /// No description provided for @viewSourceCode.
  ///
  /// In en, this message translates to:
  /// **'View source code'**
  String get viewSourceCode;

  /// No description provided for @dependencies.
  ///
  /// In en, this message translates to:
  /// **'Dependencies'**
  String get dependencies;

  /// No description provided for @viewUsedLibraries.
  ///
  /// In en, this message translates to:
  /// **'View used libraries and licenses'**
  String get viewUsedLibraries;

  /// No description provided for @imprint.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get imprint;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About This Game'**
  String get aboutTitle;

  /// No description provided for @aboutDescription1.
  ///
  /// In en, this message translates to:
  /// **'This Tower Defense game was created as a passion project because I always wanted to build one! It was developed in just 5 hours using AI as a quick exercise in game / Flutter development with AI.'**
  String get aboutDescription1;

  /// No description provided for @aboutDescription2.
  ///
  /// In en, this message translates to:
  /// **'The project is completely open source and available on GitHub. Feel free to explore, modify, or contribute to the code!'**
  String get aboutDescription2;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @playGame.
  ///
  /// In en, this message translates to:
  /// **'Play Game'**
  String get playGame;

  /// No description provided for @aboutThisGame.
  ///
  /// In en, this message translates to:
  /// **'About This Game'**
  String get aboutThisGame;

  /// No description provided for @aboutThisGameDescription.
  ///
  /// In en, this message translates to:
  /// **'This Tower Defense game was created as a passion project because I always wanted to build one! It was developed in just 5 hours using AI as a quick exercise in game and Flutter development.'**
  String get aboutThisGameDescription;

  /// No description provided for @aboutThisGameGithub.
  ///
  /// In en, this message translates to:
  /// **'The project is completely open source and available on GitHub. Feel free to explore, modify, or contribute to the code!'**
  String get aboutThisGameGithub;

  /// No description provided for @imprintTitle.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get imprintTitle;

  /// No description provided for @companyInformation.
  ///
  /// In en, this message translates to:
  /// **'Company Information'**
  String get companyInformation;

  /// No description provided for @legalInformation.
  ///
  /// In en, this message translates to:
  /// **'Legal Information'**
  String get legalInformation;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer;

  /// No description provided for @yourImprintTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Provider'**
  String get yourImprintTitle;

  /// No description provided for @yourImprintContent.
  ///
  /// In en, this message translates to:
  /// **'Publisher according to § 5 TMG:\nChristian Scheub\nZiegeläcker 56\n71560 Sulzbach an der Murr\n\nContact:\nPhone: +49 176 21674883\nEmail: christian.developer.app@gmail.com'**
  String get yourImprintContent;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyline1.
  ///
  /// In en, this message translates to:
  /// **'<strong>This privacy policy is available in English and other languages.</strong>'**
  String get privacyline1;

  /// No description provided for @privacyline2.
  ///
  /// In en, this message translates to:
  /// **'<strong>To switch languages, simply change your device language setting.</strong><br /><br />'**
  String get privacyline2;

  /// No description provided for @privacyline3.
  ///
  /// In en, this message translates to:
  /// **'<strong>Privacy Policy for Website/App</strong><br /><br />'**
  String get privacyline3;

  /// No description provided for @privacyline4.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using our website/app. We value your privacy. This app works entirely offline and does not transmit any data to servers or third parties.<br /><br />'**
  String get privacyline4;

  /// No description provided for @privacyline5.
  ///
  /// In en, this message translates to:
  /// **'<strong>1. Responsible Entity</strong><br />'**
  String get privacyline5;

  /// No description provided for @privacyline6.
  ///
  /// In en, this message translates to:
  /// **'The person responsible for data processing is:<br />'**
  String get privacyline6;

  /// No description provided for @privacyline7.
  ///
  /// In en, this message translates to:
  /// **'Christian Scheub<br />'**
  String get privacyline7;

  /// No description provided for @privacyline8.
  ///
  /// In en, this message translates to:
  /// **'Ziegeläcker 56<br />'**
  String get privacyline8;

  /// No description provided for @privacyline9.
  ///
  /// In en, this message translates to:
  /// **'71560 Sulzbach an der Murr<br /><br />'**
  String get privacyline9;

  /// No description provided for @privacyline10.
  ///
  /// In en, this message translates to:
  /// **'Phone: +49 176 21674883<br />'**
  String get privacyline10;

  /// No description provided for @privacyline11.
  ///
  /// In en, this message translates to:
  /// **'Email: christian.developer.app@gmail.com<br />'**
  String get privacyline11;

  /// No description provided for @privacyline12.
  ///
  /// In en, this message translates to:
  /// **'Owner/Operator: Christian Scheub<br />'**
  String get privacyline12;

  /// No description provided for @privacyline13.
  ///
  /// In en, this message translates to:
  /// **'Link to legal notice: https://kind-dune-0dfff9903.4.azurestaticapps.net/imprint<br /><br />'**
  String get privacyline13;

  /// No description provided for @privacyline14.
  ///
  /// In en, this message translates to:
  /// **'<strong>2. Local Data Storage</strong><br />'**
  String get privacyline14;

  /// No description provided for @privacyline15.
  ///
  /// In en, this message translates to:
  /// **'This app stores all data locally on your device using technologies such as Local Storage or IndexedDB. No data is transmitted to any server or third party.<br />'**
  String get privacyline15;

  /// No description provided for @privacyline16.
  ///
  /// In en, this message translates to:
  /// **'All data, such as tasks, settings, or notes, remain solely on your device.<br /><br />'**
  String get privacyline16;

  /// No description provided for @privacyline17.
  ///
  /// In en, this message translates to:
  /// **'<strong>3. No Tracking or Analytics</strong><br />'**
  String get privacyline17;

  /// No description provided for @privacyline18.
  ///
  /// In en, this message translates to:
  /// **'This app does not use cookies, trackers, ad IDs, or any external analytics or tracking services.<br /><br />'**
  String get privacyline18;

  /// No description provided for @privacyline19.
  ///
  /// In en, this message translates to:
  /// **'<strong>4. Your Rights</strong><br />'**
  String get privacyline19;

  /// No description provided for @privacyline20.
  ///
  /// In en, this message translates to:
  /// **'Since no personal data is processed or stored, legal rights like access or deletion do not apply. You can delete local data at any time via the app or your device settings.<br /><br />'**
  String get privacyline20;

  /// No description provided for @privacyline21.
  ///
  /// In en, this message translates to:
  /// **'<strong>5. Data Security</strong><br />'**
  String get privacyline21;

  /// No description provided for @privacyline22.
  ///
  /// In en, this message translates to:
  /// **'Your data is stored only on your device. Please protect your device using system security measures. The app itself does not transfer data.<br /><br />'**
  String get privacyline22;

  /// No description provided for @privacyline23.
  ///
  /// In en, this message translates to:
  /// **'<strong>6. Changes to This Privacy Policy</strong><br />'**
  String get privacyline23;

  /// No description provided for @privacyline24.
  ///
  /// In en, this message translates to:
  /// **'This privacy policy may be updated due to technical or legal changes. Please check regularly for updates.<br />'**
  String get privacyline24;

  /// No description provided for @privacyline25.
  ///
  /// In en, this message translates to:
  /// **'Date: 2025-05-06<br /><br />'**
  String get privacyline25;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
