import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'app/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
    Locale('fr'),
    Locale('de'),
    Locale('ar'),
    Locale('hi'),
    Locale('ja'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Ez Invoice'**
  String get appName;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get loginSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get register;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email and password (6+ characters)'**
  String get invalidCredentials;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get authError;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language for the app.'**
  String get settingsLanguageDescription;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @clientMessageTemplateMultiline.
  ///
  /// In en, this message translates to:
  /// **'Hi {name},\nsending your invoice from EzInvoice. ✅'**
  String clientMessageTemplateMultiline(Object name);

  /// No description provided for @invoiceEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'Invoice - EzInvoice'**
  String get invoiceEmailSubject;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @monthWord.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthWord;

  /// No description provided for @planLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get planLabel;

  /// No description provided for @invoicesRemaining.
  ///
  /// In en, this message translates to:
  /// **'Invoices remaining'**
  String get invoicesRemaining;

  /// No description provided for @proUnlimitedLabel.
  ///
  /// In en, this message translates to:
  /// **'PRO · Unlimited'**
  String get proUnlimitedLabel;

  /// No description provided for @createNewInvoice.
  ///
  /// In en, this message translates to:
  /// **'Create new invoice'**
  String get createNewInvoice;

  /// No description provided for @limitReachedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Limit reached • Upgrade to Pro'**
  String get limitReachedSubtitle;

  /// No description provided for @createInvoiceFastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create invoice + PDF in seconds'**
  String get createInvoiceFastSubtitle;

  /// No description provided for @limitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Limit reached'**
  String get limitReachedTitle;

  /// No description provided for @limitReachedBody.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro for unlimited invoices and remove ads.'**
  String get limitReachedBody;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @monthSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Month summary'**
  String get monthSummaryTitle;

  /// No description provided for @salesTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get salesTitle;

  /// No description provided for @tipTitle.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tipTitle;

  /// No description provided for @subtotalTitle.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotalTitle;

  /// No description provided for @taxTitle.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get taxTitle;

  /// No description provided for @beforeTaxTip.
  ///
  /// In en, this message translates to:
  /// **'Before tax/tip'**
  String get beforeTaxTip;

  /// No description provided for @collectedThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Collected this month'**
  String get collectedThisMonth;

  /// No description provided for @quickAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick access'**
  String get quickAccessTitle;

  /// No description provided for @clientsManageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create / edit clients'**
  String get clientsManageSubtitle;

  /// No description provided for @invoicesViewSendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and send PDF'**
  String get invoicesViewSendSubtitle;

  /// No description provided for @monthlyYearlySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly / yearly'**
  String get monthlyYearlySubtitle;

  /// No description provided for @businessProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Profile / logo / tax'**
  String get businessProfileSubtitle;

  /// No description provided for @invoiceCount.
  ///
  /// In en, this message translates to:
  /// **'{count} invoice(s)'**
  String invoiceCount(Object count);

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Ez Invoice Pro'**
  String get paywallTitle;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @paywallHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock everything for your business'**
  String get paywallHeaderTitle;

  /// No description provided for @paywallHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No ads • Unlimited invoices • Tax reports • Premium templates'**
  String get paywallHeaderSubtitle;

  /// No description provided for @bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best value'**
  String get bestValue;

  /// No description provided for @proYearly.
  ///
  /// In en, this message translates to:
  /// **'Pro Yearly'**
  String get proYearly;

  /// No description provided for @saveMoreYearly.
  ///
  /// In en, this message translates to:
  /// **'Save more by paying yearly'**
  String get saveMoreYearly;

  /// No description provided for @proMonthly.
  ///
  /// In en, this message translates to:
  /// **'Pro Monthly'**
  String get proMonthly;

  /// No description provided for @flexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get flexible;

  /// No description provided for @cancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime'**
  String get cancelAnytime;

  /// No description provided for @processingPurchase.
  ///
  /// In en, this message translates to:
  /// **'Processing purchase…'**
  String get processingPurchase;

  /// No description provided for @restoringPurchases.
  ///
  /// In en, this message translates to:
  /// **'Restoring purchases…'**
  String get restoringPurchases;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @continueFreeWithAds.
  ///
  /// In en, this message translates to:
  /// **'Continue with free version with Ads'**
  String get continueFreeWithAds;

  /// No description provided for @alreadyProTitle.
  ///
  /// In en, this message translates to:
  /// **'You are Pro ✅'**
  String get alreadyProTitle;

  /// No description provided for @alreadyProBody.
  ///
  /// In en, this message translates to:
  /// **'Enjoy unlimited invoices, reports, and no ads.'**
  String get alreadyProBody;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @includesInPro.
  ///
  /// In en, this message translates to:
  /// **'Included in Pro'**
  String get includesInPro;

  /// No description provided for @benefitNoAds.
  ///
  /// In en, this message translates to:
  /// **'No ads (Banner/Interstitial/Rewarded)'**
  String get benefitNoAds;

  /// No description provided for @benefitUnlimitedInvoices.
  ///
  /// In en, this message translates to:
  /// **'Unlimited invoices + statuses (draft/sent/paid)'**
  String get benefitUnlimitedInvoices;

  /// No description provided for @benefitPremiumTemplates.
  ///
  /// In en, this message translates to:
  /// **'Premium templates + colors + business logo'**
  String get benefitPremiumTemplates;

  /// No description provided for @benefitNoWatermarkPdf.
  ///
  /// In en, this message translates to:
  /// **'Professional PDF without watermark'**
  String get benefitNoWatermarkPdf;

  /// No description provided for @benefitTaxReports.
  ///
  /// In en, this message translates to:
  /// **'Tax reports: monthly and yearly (taxes/tips/net)'**
  String get benefitTaxReports;

  /// No description provided for @benefitExport.
  ///
  /// In en, this message translates to:
  /// **'Export PDF/CSV/Excel (for accounting)'**
  String get benefitExport;

  /// No description provided for @benefitCloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup + restore (multi-device)'**
  String get benefitCloudBackup;

  /// No description provided for @continueWithPlan.
  ///
  /// In en, this message translates to:
  /// **'Continue with {plan}'**
  String continueWithPlan(Object plan);

  /// No description provided for @paywallFinePrint.
  ///
  /// In en, this message translates to:
  /// **'By subscribing, payment will be charged to your {store} account. The subscription renews automatically unless you cancel at least 24 hours before the end of the current period. You can manage or cancel your subscription in your store settings.'**
  String paywallFinePrint(Object store);

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @proBadge.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get proBadge;

  /// No description provided for @byMonth.
  ///
  /// In en, this message translates to:
  /// **'By month'**
  String get byMonth;

  /// No description provided for @byYear.
  ///
  /// In en, this message translates to:
  /// **'By year'**
  String get byYear;

  /// No description provided for @monthLabel.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthLabel;

  /// No description provided for @yearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get yearLabel;

  /// No description provided for @businessProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Profile'**
  String get businessProfileTitle;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @uploadLogo.
  ///
  /// In en, this message translates to:
  /// **'Upload logo'**
  String get uploadLogo;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @businessNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get businessNameLabel;

  /// No description provided for @ownerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner / contact name'**
  String get ownerNameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @currencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyLabel;

  /// No description provided for @taxDefaultLabel.
  ///
  /// In en, this message translates to:
  /// **'Default tax (%)'**
  String get taxDefaultLabel;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @range0to100.
  ///
  /// In en, this message translates to:
  /// **'Must be between 0 and 100'**
  String get range0to100;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @footerNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Footer note (PDF)'**
  String get footerNoteLabel;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @businessFooterDefault.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your business.'**
  String get businessFooterDefault;

  /// No description provided for @businessSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Business profile saved successfully'**
  String get businessSavedSuccess;

  /// No description provided for @businessInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Business information'**
  String get businessInfoSection;

  /// No description provided for @settingsSection.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsSection;

  /// No description provided for @footerSection.
  ///
  /// In en, this message translates to:
  /// **'Footer note (PDF)'**
  String get footerSection;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @bestValueStar.
  ///
  /// In en, this message translates to:
  /// **'⭐ Best value'**
  String get bestValueStar;

  /// No description provided for @invoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesTitle;

  /// No description provided for @noInvoicesYet.
  ///
  /// In en, this message translates to:
  /// **'No invoices yet.'**
  String get noInvoicesYet;

  /// No description provided for @freePlanMonthlyLimitBanner.
  ///
  /// In en, this message translates to:
  /// **'Free plan: monthly limit {limit} invoices • Upgrade for unlimited'**
  String freePlanMonthlyLimitBanner(Object limit);

  /// No description provided for @filtersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTitle;

  /// No description provided for @clientLabel.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get clientLabel;

  /// No description provided for @allMonths.
  ///
  /// In en, this message translates to:
  /// **'All months'**
  String get allMonths;

  /// No description provided for @allClients.
  ///
  /// In en, this message translates to:
  /// **'All clients'**
  String get allClients;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @invoicesSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesSummaryLabel;

  /// No description provided for @totalTitle.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalTitle;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @noResultsForFilters.
  ///
  /// In en, this message translates to:
  /// **'No results for selected filters.'**
  String get noResultsForFilters;

  /// No description provided for @freePlanLimitDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Free plan: {current} / {limit} invoices this month.\n\nUpgrade to Pro for unlimited.'**
  String freePlanLimitDialogBody(Object current, Object limit);

  /// No description provided for @deleteInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete invoice?'**
  String get deleteInvoiceTitle;

  /// No description provided for @deleteInvoiceBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {invNo}?'**
  String deleteInvoiceBody(Object invNo);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @sendPdf.
  ///
  /// In en, this message translates to:
  /// **'Send PDF'**
  String get sendPdf;

  /// No description provided for @shareInvoiceText.
  ///
  /// In en, this message translates to:
  /// **'Invoice {invNo} - {client}'**
  String shareInvoiceText(Object invNo, Object client);

  /// No description provided for @pdfSendError.
  ///
  /// In en, this message translates to:
  /// **'Error creating/sending PDF: {error}'**
  String pdfSendError(Object error);

  /// No description provided for @reportTitleMonth.
  ///
  /// In en, this message translates to:
  /// **'Report • {month} {year}'**
  String reportTitleMonth(Object month, Object year);

  /// No description provided for @reportTitleYear.
  ///
  /// In en, this message translates to:
  /// **'Report • Year {year}'**
  String reportTitleYear(Object year);

  /// No description provided for @invoicesLine.
  ///
  /// In en, this message translates to:
  /// **'Invoices: {count}'**
  String invoicesLine(Object count);

  /// No description provided for @totalSalesLine.
  ///
  /// In en, this message translates to:
  /// **'Total Sales: \${amount}'**
  String totalSalesLine(Object amount);

  /// No description provided for @totalTaxLine.
  ///
  /// In en, this message translates to:
  /// **'Total Tax: \${amount}'**
  String totalTaxLine(Object amount);

  /// No description provided for @totalTipLine.
  ///
  /// In en, this message translates to:
  /// **'Total Tip: \${amount}'**
  String totalTipLine(Object amount);

  /// No description provided for @netLine.
  ///
  /// In en, this message translates to:
  /// **'Net: \${amount}'**
  String netLine(Object amount);

  /// No description provided for @calculatedFromInvoices.
  ///
  /// In en, this message translates to:
  /// **'Calculated from your invoices in Firestore.'**
  String get calculatedFromInvoices;

  /// No description provided for @noInvoicesInPeriod.
  ///
  /// In en, this message translates to:
  /// **'No invoices in that period.'**
  String get noInvoicesInPeriod;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @yearlyProReason.
  ///
  /// In en, this message translates to:
  /// **'Yearly report is PRO. Upgrade to unlock it.'**
  String get yearlyProReason;

  /// No description provided for @exportPdfProReason.
  ///
  /// In en, this message translates to:
  /// **'Exporting report PDF is PRO.'**
  String get exportPdfProReason;

  /// No description provided for @exportCsvProReason.
  ///
  /// In en, this message translates to:
  /// **'Exporting CSV is PRO.'**
  String get exportCsvProReason;

  /// No description provided for @noDataToExport.
  ///
  /// In en, this message translates to:
  /// **'No data to export.'**
  String get noDataToExport;

  /// No description provided for @freePlanReportsNote.
  ///
  /// In en, this message translates to:
  /// **'Free plan: monthly reports only. Upgrade for yearly reports and export.'**
  String get freePlanReportsNote;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get genericError;

  /// No description provided for @newInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'New Invoice'**
  String get newInvoiceTitle;

  /// No description provided for @editInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Invoice'**
  String get editInvoiceTitle;

  /// No description provided for @pickClient.
  ///
  /// In en, this message translates to:
  /// **'Pick client'**
  String get pickClient;

  /// No description provided for @invoiceAutoNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice # (auto)'**
  String get invoiceAutoNumberLabel;

  /// No description provided for @invoiceDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice date: {date}'**
  String invoiceDateLabel(Object date);

  /// No description provided for @clientNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Client name'**
  String get clientNameLabel;

  /// No description provided for @clientNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Client name required'**
  String get clientNameRequired;

  /// No description provided for @clientEmailOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Client email (optional)'**
  String get clientEmailOptionalLabel;

  /// No description provided for @clientPhoneOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Client phone (optional)'**
  String get clientPhoneOptionalLabel;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormat;

  /// No description provided for @itemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get itemsTitle;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @itemDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Item date: {date}'**
  String itemDateLabel(Object date);

  /// No description provided for @qtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qtyLabel;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @lineTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Line total: \${amount}'**
  String lineTotalLabel(Object amount);

  /// No description provided for @taxDefaultOwnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax % (default owner)'**
  String get taxDefaultOwnerLabel;

  /// No description provided for @tipPercentChip.
  ///
  /// In en, this message translates to:
  /// **'Tip %'**
  String get tipPercentChip;

  /// No description provided for @tipAmountChip.
  ///
  /// In en, this message translates to:
  /// **'Tip \$'**
  String get tipAmountChip;

  /// No description provided for @tipPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'Tip percent (%)'**
  String get tipPercentLabel;

  /// No description provided for @tipAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Tip amount (\$)'**
  String get tipAmountLabel;

  /// No description provided for @messageOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Message (optional)'**
  String get messageOptionalLabel;

  /// No description provided for @totalsBlock.
  ///
  /// In en, this message translates to:
  /// **'Subtotal: \${sub}\nTax: \${tax}\nTip: \${tip}\nTotal: \${total}'**
  String totalsBlock(Object sub, Object tax, Object tip, Object total);

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get saving;

  /// No description provided for @saveInvoice.
  ///
  /// In en, this message translates to:
  /// **'Save invoice'**
  String get saveInvoice;

  /// No description provided for @updateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Update invoice'**
  String get updateInvoice;

  /// No description provided for @addAtLeastOneItem.
  ///
  /// In en, this message translates to:
  /// **'Add at least 1 item'**
  String get addAtLeastOneItem;

  /// No description provided for @errorSavingInvoice.
  ///
  /// In en, this message translates to:
  /// **'Error saving invoice: {error}'**
  String errorSavingInvoice(Object error);

  /// No description provided for @savedTab.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedTab;

  /// No description provided for @contactsTab.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsTab;

  /// No description provided for @noSavedClients.
  ///
  /// In en, this message translates to:
  /// **'No saved clients'**
  String get noSavedClients;

  /// No description provided for @permissionDeniedContacts.
  ///
  /// In en, this message translates to:
  /// **'Permission denied: Contacts'**
  String get permissionDeniedContacts;

  /// No description provided for @noContactsFound.
  ///
  /// In en, this message translates to:
  /// **'No contacts found on this device/emulator'**
  String get noContactsFound;

  /// No description provided for @contactsError.
  ///
  /// In en, this message translates to:
  /// **'Contacts error: {error}'**
  String contactsError(Object error);

  /// No description provided for @noName.
  ///
  /// In en, this message translates to:
  /// **'(No name)'**
  String get noName;

  /// No description provided for @newClientTitle.
  ///
  /// In en, this message translates to:
  /// **'New client'**
  String get newClientTitle;

  /// No description provided for @editClientTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit client'**
  String get editClientTitle;

  /// No description provided for @clientInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Client information'**
  String get clientInfoSection;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Add notes (optional)'**
  String get notesHint;

  /// No description provided for @clientCreateHint.
  ///
  /// In en, this message translates to:
  /// **'Tip: Add email/phone to send invoices faster.'**
  String get clientCreateHint;

  /// No description provided for @clientEditHint.
  ///
  /// In en, this message translates to:
  /// **'You can update client info anytime.'**
  String get clientEditHint;

  /// No description provided for @errorSavingClient.
  ///
  /// In en, this message translates to:
  /// **'Error saving client: {error}'**
  String errorSavingClient(Object error);

  /// No description provided for @clientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clientsTitle;

  /// No description provided for @searchClientsLabel.
  ///
  /// In en, this message translates to:
  /// **'Search clients'**
  String get searchClientsLabel;

  /// No description provided for @clientsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} client(s)'**
  String clientsCount(Object count);

  /// No description provided for @noClientsYet.
  ///
  /// In en, this message translates to:
  /// **'No clients yet.'**
  String get noClientsYet;

  /// No description provided for @noClientsForSearch.
  ///
  /// In en, this message translates to:
  /// **'No clients match your search.'**
  String get noClientsForSearch;

  /// No description provided for @cannotOpenDialer.
  ///
  /// In en, this message translates to:
  /// **'Cannot open dialer'**
  String get cannotOpenDialer;

  /// No description provided for @cannotOpenSms.
  ///
  /// In en, this message translates to:
  /// **'Cannot open SMS'**
  String get cannotOpenSms;

  /// No description provided for @whatsAppNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp not available'**
  String get whatsAppNotAvailable;

  /// No description provided for @cannotOpenEmail.
  ///
  /// In en, this message translates to:
  /// **'Cannot open email'**
  String get cannotOpenEmail;

  /// No description provided for @deleteClientTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete client?'**
  String get deleteClientTitle;

  /// No description provided for @deleteClientBody.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String deleteClientBody(Object name);

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @emailAction.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailAction;

  /// No description provided for @shareAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Try EzInvoice 👇'**
  String get shareAppTitle;

  /// No description provided for @shareAppBody.
  ///
  /// In en, this message translates to:
  /// **'Create invoices, send PDFs, and track reports easily.'**
  String get shareAppBody;

  /// No description provided for @shareAppTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get shareAppTooltip;

  /// No description provided for @openGooglePlayTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open Google Play'**
  String get openGooglePlayTooltip;

  /// No description provided for @openAppStoreTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open App Store'**
  String get openAppStoreTooltip;

  /// No description provided for @openWebsiteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open website'**
  String get openWebsiteTooltip;

  /// No description provided for @availableLanguages.
  ///
  /// In en, this message translates to:
  /// **'Available languages'**
  String get availableLanguages;

  /// No description provided for @usePhoneLanguage.
  ///
  /// In en, this message translates to:
  /// **'Use your phone language'**
  String get usePhoneLanguage;

  /// No description provided for @shareReceiptText.
  ///
  /// In en, this message translates to:
  /// **'Receipt {invoiceNumber} for {clientName}'**
  String shareReceiptText(Object invoiceNumber, Object clientName);

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @invoicesLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesLabel;

  /// No description provided for @totalSalesLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get totalSalesLabel;

  /// No description provided for @totalTaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Tax'**
  String get totalTaxLabel;

  /// No description provided for @totalTipLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Tip'**
  String get totalTipLabel;

  /// No description provided for @netLabel.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get netLabel;

  /// No description provided for @sentLabel.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sentLabel;

  /// No description provided for @paidLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLabel;

  /// No description provided for @overdueLabel.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdueLabel;

  /// No description provided for @reportCalculatedHint.
  ///
  /// In en, this message translates to:
  /// **'Calculated from your invoices.'**
  String get reportCalculatedHint;

  /// No description provided for @exportPdfComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Export PDF (coming soon)'**
  String get exportPdfComingSoon;

  /// No description provided for @exportCsvComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Export CSV (coming soon)'**
  String get exportCsvComingSoon;

  /// No description provided for @unsentLabel.
  ///
  /// In en, this message translates to:
  /// **'Unsent'**
  String get unsentLabel;

  /// No description provided for @servicePresetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Service presets'**
  String get servicePresetsTitle;

  /// No description provided for @servicePresetsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Presets'**
  String get servicePresetsScreenTitle;

  /// No description provided for @servicePresetsAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add new preset'**
  String get servicePresetsAddNew;

  /// No description provided for @servicePresetsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Cleaning, Repair, Consultation...'**
  String get servicePresetsHint;

  /// No description provided for @servicePresetsAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get servicePresetsAddButton;

  /// No description provided for @addServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Add a service'**
  String get addServiceLabel;

  /// No description provided for @yourPresets.
  ///
  /// In en, this message translates to:
  /// **'Your presets'**
  String get yourPresets;

  /// No description provided for @noPresetsYet.
  ///
  /// In en, this message translates to:
  /// **'No presets yet.'**
  String get noPresetsYet;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @openPaywallPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Open Paywall (connect PaywallScreen here)'**
  String get openPaywallPlaceholder;

  /// No description provided for @invoiceStyleTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice style'**
  String get invoiceStyleTitle;

  /// No description provided for @invoiceFreeStyleHint.
  ///
  /// In en, this message translates to:
  /// **'Free plan uses one invoice version (Minimal). Upgrade to Pro to unlock all layouts and palettes.'**
  String get invoiceFreeStyleHint;

  /// No description provided for @invoicePaletteLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice palette'**
  String get invoicePaletteLabel;

  /// No description provided for @invoiceLayoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice layout'**
  String get invoiceLayoutLabel;

  /// No description provided for @saveInvoicePaletteError.
  ///
  /// In en, this message translates to:
  /// **'Could not save invoice palette.'**
  String get saveInvoicePaletteError;

  /// No description provided for @saveInvoiceLayoutError.
  ///
  /// In en, this message translates to:
  /// **'Could not save invoice layout.'**
  String get saveInvoiceLayoutError;

  /// No description provided for @reportStyleTitle.
  ///
  /// In en, this message translates to:
  /// **'Report style'**
  String get reportStyleTitle;

  /// No description provided for @reportFreeStyleHint.
  ///
  /// In en, this message translates to:
  /// **'Free plan uses one report version (Minimal). Upgrade to Pro to unlock all layouts and palettes.'**
  String get reportFreeStyleHint;

  /// No description provided for @reportPaletteLabel.
  ///
  /// In en, this message translates to:
  /// **'Report palette'**
  String get reportPaletteLabel;

  /// No description provided for @reportLayoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Report layout'**
  String get reportLayoutLabel;

  /// No description provided for @saveReportPaletteError.
  ///
  /// In en, this message translates to:
  /// **'Could not save report palette.'**
  String get saveReportPaletteError;

  /// No description provided for @saveReportLayoutError.
  ///
  /// In en, this message translates to:
  /// **'Could not save report layout.'**
  String get saveReportLayoutError;

  /// No description provided for @stylePaletteFootnote.
  ///
  /// In en, this message translates to:
  /// **'{docType} style: {style} | Palette: {palette}'**
  String stylePaletteFootnote(Object docType, Object style, Object palette);

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This action will permanently delete your account and all associated data.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountButton;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This action cannot be undone.'**
  String get deleteAccountConfirmMessage;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved automatically'**
  String get profileSaved;

  /// No description provided for @profileSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save. Your changes are still here.'**
  String get profileSaveError;

  /// No description provided for @profileRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get profileRetry;

  /// No description provided for @profileAutosaveHint.
  ///
  /// In en, this message translates to:
  /// **'Changes save automatically. Closing keeps your changes.'**
  String get profileAutosaveHint;

  /// No description provided for @profileLogo.
  ///
  /// In en, this message translates to:
  /// **'Business logo'**
  String get profileLogo;

  /// No description provided for @profileDefaults.
  ///
  /// In en, this message translates to:
  /// **'Invoice defaults'**
  String get profileDefaults;

  /// No description provided for @profileTaxInvalid.
  ///
  /// In en, this message translates to:
  /// **'Check the tax rate (0–100%).'**
  String get profileTaxInvalid;

  /// No description provided for @metricLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load this report. Try again.'**
  String get metricLoadError;

  /// No description provided for @totalInvoicedTitle.
  ///
  /// In en, this message translates to:
  /// **'Total invoiced'**
  String get totalInvoicedTitle;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(Object version);

  /// No description provided for @errorWithDetails.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorWithDetails(Object error);

  /// No description provided for @rememberEmail.
  ///
  /// In en, this message translates to:
  /// **'Remember my email'**
  String get rememberEmail;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @passwordResetEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to send the reset link.'**
  String get passwordResetEnterEmail;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'We sent you an email to reset your password. Check Spam or Junk.'**
  String get passwordResetSent;

  /// No description provided for @passwordResetNoAccount.
  ///
  /// In en, this message translates to:
  /// **'No account was found for that email.'**
  String get passwordResetNoAccount;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email.'**
  String get invalidEmail;

  /// No description provided for @passwordResetError.
  ///
  /// In en, this message translates to:
  /// **'Could not send the email. Try again.'**
  String get passwordResetError;

  /// No description provided for @updateRequired.
  ///
  /// In en, this message translates to:
  /// **'Update required'**
  String get updateRequired;

  /// No description provided for @updateRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'A new version of Ez Invoice is available. To continue, update the app from the store.'**
  String get updateRequiredBody;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get free;

  /// No description provided for @clientInformation.
  ///
  /// In en, this message translates to:
  /// **'Client information'**
  String get clientInformation;

  /// No description provided for @clientName.
  ///
  /// In en, this message translates to:
  /// **'Client name'**
  String get clientName;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @saveClient.
  ///
  /// In en, this message translates to:
  /// **'Save client'**
  String get saveClient;

  /// No description provided for @importFromContacts.
  ///
  /// In en, this message translates to:
  /// **'Import from contacts'**
  String get importFromContacts;

  /// No description provided for @importContactsDescription.
  ///
  /// In en, this message translates to:
  /// **'Fill name, phone, and email instantly.'**
  String get importContactsDescription;

  /// No description provided for @loadContacts.
  ///
  /// In en, this message translates to:
  /// **'Load contacts'**
  String get loadContacts;

  /// No description provided for @clientPhone.
  ///
  /// In en, this message translates to:
  /// **'Client phone'**
  String get clientPhone;

  /// No description provided for @searchContacts.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get searchContacts;

  /// No description provided for @shareClient.
  ///
  /// In en, this message translates to:
  /// **'Share client'**
  String get shareClient;

  /// No description provided for @clientProfile.
  ///
  /// In en, this message translates to:
  /// **'Client profile'**
  String get clientProfile;

  /// No description provided for @chooseSavedService.
  ///
  /// In en, this message translates to:
  /// **'Choose saved service'**
  String get chooseSavedService;

  /// No description provided for @searchSavedServices.
  ///
  /// In en, this message translates to:
  /// **'Search saved services'**
  String get searchSavedServices;

  /// No description provided for @noSavedServicesFound.
  ///
  /// In en, this message translates to:
  /// **'No saved services found'**
  String get noSavedServicesFound;

  /// No description provided for @noSavedServicesToUse.
  ///
  /// In en, this message translates to:
  /// **'No saved services yet. Type one above, then save it for later.'**
  String get noSavedServicesToUse;

  /// No description provided for @savedServiceAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Already saved: {service}'**
  String savedServiceAlreadyExists(Object service);

  /// No description provided for @savedService.
  ///
  /// In en, this message translates to:
  /// **'Saved service: {service}'**
  String savedService(Object service);

  /// No description provided for @savePresetError.
  ///
  /// In en, this message translates to:
  /// **'Could not save the service: {error}'**
  String savePresetError(Object error);

  /// No description provided for @saveServiceForLater.
  ///
  /// In en, this message translates to:
  /// **'Save service for later'**
  String get saveServiceForLater;

  /// No description provided for @removeClient.
  ///
  /// In en, this message translates to:
  /// **'Remove client'**
  String get removeClient;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @taxAndTip.
  ///
  /// In en, this message translates to:
  /// **'Tax & tip'**
  String get taxAndTip;

  /// No description provided for @totals.
  ///
  /// In en, this message translates to:
  /// **'Totals'**
  String get totals;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date: {date}'**
  String dueDate(Object date);

  /// No description provided for @paidDate.
  ///
  /// In en, this message translates to:
  /// **'Paid date: {date}'**
  String paidDate(Object date);

  /// No description provided for @notPaidYet.
  ///
  /// In en, this message translates to:
  /// **'Not paid yet'**
  String get notPaidYet;

  /// No description provided for @paymentMethodWithValue.
  ///
  /// In en, this message translates to:
  /// **'Method: {method}'**
  String paymentMethodWithValue(Object method);

  /// No description provided for @paymentNoteWithValue.
  ///
  /// In en, this message translates to:
  /// **'Note: {note}'**
  String paymentNoteWithValue(Object note);

  /// No description provided for @markAsPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark as paid'**
  String get markAsPaid;

  /// No description provided for @markAsUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Mark as unpaid'**
  String get markAsUnpaid;

  /// No description provided for @editTax.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editTax;

  /// No description provided for @addClient.
  ///
  /// In en, this message translates to:
  /// **'Add a client'**
  String get addClient;

  /// No description provided for @firstClientHint.
  ///
  /// In en, this message translates to:
  /// **'Create your first client to reuse it in future invoices.'**
  String get firstClientHint;

  /// No description provided for @searchSavedClients.
  ///
  /// In en, this message translates to:
  /// **'Search saved clients'**
  String get searchSavedClients;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @invoiceMarkPaidError.
  ///
  /// In en, this message translates to:
  /// **'Could not mark the invoice as paid: {error}'**
  String invoiceMarkPaidError(Object error);

  /// No description provided for @invoiceMarkUnpaidError.
  ///
  /// In en, this message translates to:
  /// **'Could not mark the invoice as unpaid: {error}'**
  String invoiceMarkUnpaidError(Object error);

  /// No description provided for @deleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete the invoice: {error}'**
  String deleteError(Object error);

  /// No description provided for @invoiceDeleted.
  ///
  /// In en, this message translates to:
  /// **'Invoice deleted'**
  String get invoiceDeleted;

  /// No description provided for @invoiceMarkedSent.
  ///
  /// In en, this message translates to:
  /// **'Marked as sent ✅'**
  String get invoiceMarkedSent;

  /// No description provided for @invoiceMarkSentError.
  ///
  /// In en, this message translates to:
  /// **'Could not mark as sent: {error}'**
  String invoiceMarkSentError(Object error);

  /// No description provided for @invoiceMarkedUnsent.
  ///
  /// In en, this message translates to:
  /// **'Marked as unsent ✅'**
  String get invoiceMarkedUnsent;

  /// No description provided for @invoiceMarkUnsentError.
  ///
  /// In en, this message translates to:
  /// **'Could not mark as unsent: {error}'**
  String invoiceMarkUnsentError(Object error);

  /// No description provided for @invoiceMarkedPaid.
  ///
  /// In en, this message translates to:
  /// **'Marked as paid ✅'**
  String get invoiceMarkedPaid;

  /// No description provided for @invoiceMarkedUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Marked as unpaid ✅'**
  String get invoiceMarkedUnpaid;

  /// No description provided for @invoiceLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Could not load invoices'**
  String get invoiceLoadingError;

  /// No description provided for @tipType.
  ///
  /// In en, this message translates to:
  /// **'Tip type'**
  String get tipType;

  /// No description provided for @amountOption.
  ///
  /// In en, this message translates to:
  /// **'Amount (\$)'**
  String get amountOption;

  /// No description provided for @percentageOption.
  ///
  /// In en, this message translates to:
  /// **'Percentage (%)'**
  String get percentageOption;

  /// No description provided for @pdfPreview.
  ///
  /// In en, this message translates to:
  /// **'PDF preview'**
  String get pdfPreview;

  /// No description provided for @openPdf.
  ///
  /// In en, this message translates to:
  /// **'Open PDF'**
  String get openPdf;

  /// No description provided for @sharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdf;

  /// No description provided for @selectReportMonth.
  ///
  /// In en, this message translates to:
  /// **'Select report month'**
  String get selectReportMonth;

  /// No description provided for @reportForBusiness.
  ///
  /// In en, this message translates to:
  /// **'Reports • {business}'**
  String reportForBusiness(Object business);

  /// No description provided for @tapToChangeMonth.
  ///
  /// In en, this message translates to:
  /// **'Tap to change the month'**
  String get tapToChangeMonth;

  /// No description provided for @csvSaved.
  ///
  /// In en, this message translates to:
  /// **'CSV saved: {path}'**
  String csvSaved(Object path);

  /// No description provided for @csvExportError.
  ///
  /// In en, this message translates to:
  /// **'Could not export CSV: {error}'**
  String csvExportError(Object error);

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutTagline.
  ///
  /// In en, this message translates to:
  /// **'Clear invoicing for businesses in motion'**
  String get aboutTagline;

  /// No description provided for @aboutAppTitle.
  ///
  /// In en, this message translates to:
  /// **'The app'**
  String get aboutAppTitle;

  /// No description provided for @aboutAppBody.
  ///
  /// In en, this message translates to:
  /// **'EzInvoice brings invoices, clients, payments, and reports into one simple flow so you can see what matters and get paid with confidence.'**
  String get aboutAppBody;

  /// No description provided for @aboutCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'The company'**
  String get aboutCompanyTitle;

  /// No description provided for @aboutCompanyBody.
  ///
  /// In en, this message translates to:
  /// **'Liisgo LLC creates practical tools that help small businesses work with more order, clarity, and confidence.'**
  String get aboutCompanyBody;

  /// No description provided for @aboutPromiseTitle.
  ///
  /// In en, this message translates to:
  /// **'Made for your day-to-day'**
  String get aboutPromiseTitle;

  /// No description provided for @aboutPromiseBody.
  ///
  /// In en, this message translates to:
  /// **'Every EzInvoice decision aims to reduce steps, keep details visible, and make running your business feel simpler.'**
  String get aboutPromiseBody;

  /// No description provided for @visitLiisgo.
  ///
  /// In en, this message translates to:
  /// **'Visit Liisgo'**
  String get visitLiisgo;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get contactSupport;

  /// No description provided for @shareEzInvoice.
  ///
  /// In en, this message translates to:
  /// **'Share EzInvoice'**
  String get shareEzInvoice;

  /// No description provided for @sendIdeaOrBug.
  ///
  /// In en, this message translates to:
  /// **'Send an idea or bug'**
  String get sendIdeaOrBug;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Your feedback matters'**
  String get feedbackTitle;

  /// No description provided for @feedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you would improve or what did not work well.'**
  String get feedbackSubtitle;

  /// No description provided for @feedbackIdea.
  ///
  /// In en, this message translates to:
  /// **'Idea'**
  String get feedbackIdea;

  /// No description provided for @feedbackBug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get feedbackBug;

  /// No description provided for @feedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Write your idea or explain what happened…'**
  String get feedbackHint;

  /// No description provided for @feedbackRequired.
  ///
  /// In en, this message translates to:
  /// **'Write a message before sending.'**
  String get feedbackRequired;

  /// No description provided for @continueToEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue to email'**
  String get continueToEmail;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open this link.'**
  String get couldNotOpenLink;

  /// No description provided for @shareAppText.
  ///
  /// In en, this message translates to:
  /// **'Meet EzInvoice Pro: invoices, clients, and reports in one place.\n{storeUrl}'**
  String shareAppText(Object storeUrl);

  /// No description provided for @feedbackEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'{kind} for EzInvoice'**
  String feedbackEmailSubject(Object kind);

  /// No description provided for @supportEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'EzInvoice support'**
  String get supportEmailSubject;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your account password.'**
  String get changePasswordSubtitle;

  /// No description provided for @confirmCurrentPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'For security, confirm your current password first.'**
  String get confirmCurrentPasswordHint;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get updatePassword;

  /// No description provided for @passwordAtLeastSix.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 6 characters.'**
  String get passwordAtLeastSix;

  /// No description provided for @noActiveSession.
  ///
  /// In en, this message translates to:
  /// **'No active session.'**
  String get noActiveSession;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'The new password does not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordMustDiffer.
  ///
  /// In en, this message translates to:
  /// **'The new password must be different.'**
  String get passwordMustDiffer;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully.'**
  String get passwordUpdated;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password is wrong.'**
  String get incorrectPassword;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The new password is too weak.'**
  String get weakPassword;

  /// No description provided for @reauthenticationNeeded.
  ///
  /// In en, this message translates to:
  /// **'For security, sign in again and try once more.'**
  String get reauthenticationNeeded;

  /// No description provided for @changePasswordError.
  ///
  /// In en, this message translates to:
  /// **'Could not change password.'**
  String get changePasswordError;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @reauthCancelled.
  ///
  /// In en, this message translates to:
  /// **'Reauthentication cancelled.'**
  String get reauthCancelled;

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Your account and data were permanently deleted.'**
  String get accountDeleted;

  /// No description provided for @deleteAccountIncorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get deleteAccountIncorrectPassword;

  /// No description provided for @deleteAccountError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete account.'**
  String get deleteAccountError;

  /// No description provided for @deleteAccountBody.
  ///
  /// In en, this message translates to:
  /// **'If you delete your account:\n\n• Your clients, invoices, reports, and business profile will be permanently deleted.\n• This action cannot be undone.\n• If you have an active subscription, manage or cancel it in App Store/Google Play.'**
  String get deleteAccountBody;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @agreeTermsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms & Conditions and Privacy Policy first.'**
  String get agreeTermsPrivacy;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current plan'**
  String get currentPlan;

  /// No description provided for @currentPlanFree.
  ///
  /// In en, this message translates to:
  /// **'Current plan: Free'**
  String get currentPlanFree;

  /// No description provided for @proPlanDescription.
  ///
  /// In en, this message translates to:
  /// **'Free includes ads and limited usage. Pro removes ads and unlocks unlimited invoices, reports, premium templates, exports, and cloud backup.'**
  String get proPlanDescription;

  /// No description provided for @adsIncluded.
  ///
  /// In en, this message translates to:
  /// **'Ads included'**
  String get adsIncluded;

  /// No description provided for @limitedInvoicesPerMonth.
  ///
  /// In en, this message translates to:
  /// **'Limited invoices each month'**
  String get limitedInvoicesPerMonth;

  /// No description provided for @basicInvoiceStyle.
  ///
  /// In en, this message translates to:
  /// **'Basic invoice style'**
  String get basicInvoiceStyle;

  /// No description provided for @basicReports.
  ///
  /// In en, this message translates to:
  /// **'Basic reports'**
  String get basicReports;

  /// No description provided for @pdfIncludesBranding.
  ///
  /// In en, this message translates to:
  /// **'PDF includes EzInvoice branding'**
  String get pdfIncludesBranding;

  /// No description provided for @unpaidLabel.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaidLabel;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @storeProductLoadingOne.
  ///
  /// In en, this message translates to:
  /// **'One subscription product is still loading. You can continue with the available plan while the other product loads.'**
  String get storeProductLoadingOne;

  /// No description provided for @storeProductsLoading.
  ///
  /// In en, this message translates to:
  /// **'Connecting to store subscription products. If this does not finish loading, confirm the subscriptions are ready in your store console.'**
  String get storeProductsLoading;

  /// No description provided for @agreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get agreeTo;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @currentProPlanDescription.
  ///
  /// In en, this message translates to:
  /// **'You already have Ez Invoice Pro. You can review both subscription options below.'**
  String get currentProPlanDescription;

  /// No description provided for @freeVsPro.
  ///
  /// In en, this message translates to:
  /// **'Free vs {pro}'**
  String freeVsPro(Object pro);

  /// No description provided for @openInvoices.
  ///
  /// In en, this message translates to:
  /// **'Open invoices.'**
  String get openInvoices;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'All caught up'**
  String get allCaughtUp;

  /// No description provided for @itemsToReview.
  ///
  /// In en, this message translates to:
  /// **'{count} to review'**
  String itemsToReview(Object count);

  /// No description provided for @pdfInvoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get pdfInvoice;

  /// No description provided for @pdfReceipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get pdfReceipt;

  /// No description provided for @pdfBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get pdfBusiness;

  /// No description provided for @pdfPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get pdfPhone;

  /// No description provided for @pdfEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get pdfEmail;

  /// No description provided for @pdfNumber.
  ///
  /// In en, this message translates to:
  /// **'No.'**
  String get pdfNumber;

  /// No description provided for @pdfDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pdfDate;

  /// No description provided for @pdfDue.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get pdfDue;

  /// No description provided for @pdfPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get pdfPaid;

  /// No description provided for @pdfPaidDate.
  ///
  /// In en, this message translates to:
  /// **'Paid date'**
  String get pdfPaidDate;

  /// No description provided for @pdfMethod.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get pdfMethod;

  /// No description provided for @pdfBillTo.
  ///
  /// In en, this message translates to:
  /// **'Bill to'**
  String get pdfBillTo;

  /// No description provided for @pdfClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get pdfClient;

  /// No description provided for @pdfDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get pdfDescription;

  /// No description provided for @pdfQuantity.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get pdfQuantity;

  /// No description provided for @pdfPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get pdfPrice;

  /// No description provided for @pdfSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get pdfSubtotal;

  /// No description provided for @pdfTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get pdfTax;

  /// No description provided for @pdfTaxWithRate.
  ///
  /// In en, this message translates to:
  /// **'Tax ({rate}%)'**
  String pdfTaxWithRate(Object rate);

  /// No description provided for @pdfTip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get pdfTip;

  /// No description provided for @pdfTipWithRate.
  ///
  /// In en, this message translates to:
  /// **'Tip ({rate}%)'**
  String pdfTipWithRate(Object rate);

  /// No description provided for @pdfDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get pdfDiscount;

  /// No description provided for @pdfMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get pdfMessage;

  /// No description provided for @pdfPaymentNote.
  ///
  /// In en, this message translates to:
  /// **'Payment note'**
  String get pdfPaymentNote;

  /// No description provided for @pdfThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your business.'**
  String get pdfThankYou;

  /// No description provided for @pdfPoweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by EzInvoice'**
  String get pdfPoweredBy;

  /// No description provided for @pdfFreeVersion.
  ///
  /// In en, this message translates to:
  /// **'FREE VERSION'**
  String get pdfFreeVersion;

  /// No description provided for @pdfTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get pdfTotal;

  /// No description provided for @styleMinimal.
  ///
  /// In en, this message translates to:
  /// **'Minimal'**
  String get styleMinimal;

  /// No description provided for @styleProfessional.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get styleProfessional;

  /// No description provided for @styleCorporate.
  ///
  /// In en, this message translates to:
  /// **'Corporate'**
  String get styleCorporate;

  /// No description provided for @styleModern.
  ///
  /// In en, this message translates to:
  /// **'Modern'**
  String get styleModern;

  /// No description provided for @styleSlate.
  ///
  /// In en, this message translates to:
  /// **'Slate'**
  String get styleSlate;

  /// No description provided for @reportDocument.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportDocument;

  /// No description provided for @reportPrintDocument.
  ///
  /// In en, this message translates to:
  /// **'Print report'**
  String get reportPrintDocument;

  /// No description provided for @reportMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get reportMonth;

  /// No description provided for @reportYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get reportYear;

  /// No description provided for @reportGeneratedOn.
  ///
  /// In en, this message translates to:
  /// **'Generated on'**
  String get reportGeneratedOn;

  /// No description provided for @reportInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get reportInvoices;

  /// No description provided for @reportStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get reportStatus;

  /// No description provided for @reportTotals.
  ///
  /// In en, this message translates to:
  /// **'Totals'**
  String get reportTotals;

  /// No description provided for @reportSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get reportSales;

  /// No description provided for @reportTotalTax.
  ///
  /// In en, this message translates to:
  /// **'Total tax'**
  String get reportTotalTax;

  /// No description provided for @reportTotalTip.
  ///
  /// In en, this message translates to:
  /// **'Total tip'**
  String get reportTotalTip;

  /// No description provided for @reportTotalInvoiced.
  ///
  /// In en, this message translates to:
  /// **'Total invoiced'**
  String get reportTotalInvoiced;

  /// No description provided for @reportUnsent.
  ///
  /// In en, this message translates to:
  /// **'Unsent'**
  String get reportUnsent;

  /// No description provided for @reportSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get reportSent;

  /// No description provided for @reportPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get reportPaid;

  /// No description provided for @reportOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get reportOverdue;

  /// No description provided for @reportInvoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice no.'**
  String get reportInvoiceNumber;

  /// No description provided for @reportClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get reportClient;

  /// No description provided for @reportDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get reportDueDate;

  /// No description provided for @reportDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get reportDescription;

  /// No description provided for @reportDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reportDate;

  /// No description provided for @reportFreeVersion.
  ///
  /// In en, this message translates to:
  /// **'FREE VERSION'**
  String get reportFreeVersion;

  /// No description provided for @reportPoweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by EzInvoice'**
  String get reportPoweredBy;

  /// No description provided for @reportPdfShareText.
  ///
  /// In en, this message translates to:
  /// **'PDF report: {title}'**
  String reportPdfShareText(Object title);

  /// No description provided for @reportCsvShareText.
  ///
  /// In en, this message translates to:
  /// **'CSV report: {title}'**
  String reportCsvShareText(Object title);

  /// No description provided for @reportPrintShareText.
  ///
  /// In en, this message translates to:
  /// **'Print: {title}'**
  String reportPrintShareText(Object title);

  /// No description provided for @reportFileMonthly.
  ///
  /// In en, this message translates to:
  /// **'Report_{month}_{year}'**
  String reportFileMonthly(Object month, Object year);

  /// No description provided for @reportFileYearly.
  ///
  /// In en, this message translates to:
  /// **'Report_Year_{year}'**
  String reportFileYearly(Object year);

  /// No description provided for @reportTextMonthly.
  ///
  /// In en, this message translates to:
  /// **'Report | {month} {year}'**
  String reportTextMonthly(Object month, Object year);

  /// No description provided for @reportTextYearly.
  ///
  /// In en, this message translates to:
  /// **'Report | {year}'**
  String reportTextYearly(Object year);

  /// No description provided for @reportBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get reportBreakdown;

  /// No description provided for @reportInvoicesStatus.
  ///
  /// In en, this message translates to:
  /// **'Invoice status'**
  String get reportInvoicesStatus;

  /// No description provided for @viewReport.
  ///
  /// In en, this message translates to:
  /// **'View report'**
  String get viewReport;

  /// No description provided for @reviewBeforeExport.
  ///
  /// In en, this message translates to:
  /// **'Review the PDF or CSV before exporting.'**
  String get reviewBeforeExport;

  /// No description provided for @customizeReport.
  ///
  /// In en, this message translates to:
  /// **'Customize the report'**
  String get customizeReport;

  /// No description provided for @reportPreviewUpdates.
  ///
  /// In en, this message translates to:
  /// **'Changes appear immediately in your preview.'**
  String get reportPreviewUpdates;

  /// No description provided for @yourReportPreview.
  ///
  /// In en, this message translates to:
  /// **'Your report preview'**
  String get yourReportPreview;

  /// No description provided for @reportStyleLiveHint.
  ///
  /// In en, this message translates to:
  /// **'Change the design and see it live.'**
  String get reportStyleLiveHint;

  /// No description provided for @watchAdToExportReport.
  ///
  /// In en, this message translates to:
  /// **'Watch the full ad to export this report. Upgrade to Pro to export without ads.'**
  String get watchAdToExportReport;

  /// No description provided for @reportExportError.
  ///
  /// In en, this message translates to:
  /// **'Could not export report: {error}'**
  String reportExportError(Object error);

  /// No description provided for @shareCsvFile.
  ///
  /// In en, this message translates to:
  /// **'Share CSV file'**
  String get shareCsvFile;

  /// No description provided for @shareCsvFileDescription.
  ///
  /// In en, this message translates to:
  /// **'Share the .csv attachment by email, Drive, or another app.'**
  String get shareCsvFileDescription;

  /// No description provided for @shareReportAsText.
  ///
  /// In en, this message translates to:
  /// **'Share as text (WhatsApp / SMS)'**
  String get shareReportAsText;

  /// No description provided for @shareReportAsTextDescription.
  ///
  /// In en, this message translates to:
  /// **'Send a report summary as text.'**
  String get shareReportAsTextDescription;

  /// No description provided for @printCsv.
  ///
  /// In en, this message translates to:
  /// **'Print CSV'**
  String get printCsv;

  /// No description provided for @printReportDescription.
  ///
  /// In en, this message translates to:
  /// **'Print the report as a PDF table.'**
  String get printReportDescription;

  /// No description provided for @reportPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get reportPreview;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @proFeatureUnlimitedInvoices.
  ///
  /// In en, this message translates to:
  /// **'Unlimited invoices'**
  String get proFeatureUnlimitedInvoices;

  /// No description provided for @proFeatureRemovePdfBranding.
  ///
  /// In en, this message translates to:
  /// **'Remove PDF branding'**
  String get proFeatureRemovePdfBranding;

  /// No description provided for @proFeatureExportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get proFeatureExportCsv;

  /// No description provided for @proFeaturePremiumTemplates.
  ///
  /// In en, this message translates to:
  /// **'Premium templates'**
  String get proFeaturePremiumTemplates;

  /// No description provided for @proFeatureDetailedTaxReport.
  ///
  /// In en, this message translates to:
  /// **'Detailed tax report'**
  String get proFeatureDetailedTaxReport;

  /// No description provided for @proFeatureUnlimitedInvoicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Free plan allows up to {limit} invoices per month.'**
  String proFeatureUnlimitedInvoicesDescription(Object limit);

  /// No description provided for @proFeatureRemovePdfBrandingDescription.
  ///
  /// In en, this message translates to:
  /// **'Remove “Powered by EzInvoice” from PDFs.'**
  String get proFeatureRemovePdfBrandingDescription;

  /// No description provided for @proFeatureExportCsvDescription.
  ///
  /// In en, this message translates to:
  /// **'Export your invoices to CSV.'**
  String get proFeatureExportCsvDescription;

  /// No description provided for @proFeaturePremiumTemplatesDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlock premium invoice templates.'**
  String get proFeaturePremiumTemplatesDescription;

  /// No description provided for @proFeatureDetailedTaxReportDescription.
  ///
  /// In en, this message translates to:
  /// **'See detailed tax breakdown reports.'**
  String get proFeatureDetailedTaxReportDescription;

  /// No description provided for @pdfShareText.
  ///
  /// In en, this message translates to:
  /// **'Invoice PDF from EzInvoice'**
  String get pdfShareText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'ja',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
