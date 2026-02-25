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
  /// **'Calculated from your invoices in Firestore.'**
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
