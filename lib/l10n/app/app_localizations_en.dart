// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'Create your account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get register => 'Create account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get signIn => 'Sign in';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign up';

  @override
  String get processing => 'Processing...';

  @override
  String get invalidCredentials =>
      'Enter a valid email and password (6+ characters)';

  @override
  String get authError => 'Authentication error';

  @override
  String get home => 'Home';

  @override
  String get clients => 'Clients';

  @override
  String get invoices => 'Invoices';

  @override
  String get reports => 'Reports';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Log out';

  @override
  String get business => 'Business';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageDescription => 'Choose the language for the app.';

  @override
  String get systemDefault => 'System default';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'Hi $name,\nsending your invoice from EzInvoice. ✅';
  }

  @override
  String get invoiceEmailSubject => 'Invoice - EzInvoice';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get monthWord => 'Month';

  @override
  String get planLabel => 'Plan';

  @override
  String get invoicesRemaining => 'Invoices remaining';

  @override
  String get proUnlimitedLabel => 'PRO · Unlimited';

  @override
  String get createNewInvoice => 'Create new invoice';

  @override
  String get limitReachedSubtitle => 'Limit reached • Upgrade to Pro';

  @override
  String get createInvoiceFastSubtitle => 'Create invoice + PDF in seconds';

  @override
  String get limitReachedTitle => 'Limit reached';

  @override
  String get limitReachedBody =>
      'Upgrade to Pro for unlimited invoices and remove ads.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get monthSummaryTitle => 'Month summary';

  @override
  String get salesTitle => 'Sales';

  @override
  String get tipTitle => 'Tip';

  @override
  String get subtotalTitle => 'Subtotal';

  @override
  String get taxTitle => 'Tax';

  @override
  String get beforeTaxTip => 'Before tax/tip';

  @override
  String get collectedThisMonth => 'Collected this month';

  @override
  String get quickAccessTitle => 'Quick access';

  @override
  String get clientsManageSubtitle => 'Create / edit clients';

  @override
  String get invoicesViewSendSubtitle => 'View and send PDF';

  @override
  String get monthlyYearlySubtitle => 'Monthly / yearly';

  @override
  String get businessProfileSubtitle => 'Profile / logo / tax';

  @override
  String invoiceCount(Object count) {
    return '$count invoice(s)';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'Close';

  @override
  String get paywallHeaderTitle => 'Unlock everything for your business';

  @override
  String get paywallHeaderSubtitle =>
      'No ads • Unlimited invoices • Tax reports • Premium templates';

  @override
  String get bestValue => 'Best value';

  @override
  String get proYearly => 'Pro Yearly';

  @override
  String get saveMoreYearly => 'Save more by paying yearly';

  @override
  String get proMonthly => 'Pro Monthly';

  @override
  String get flexible => 'Flexible';

  @override
  String get cancelAnytime => 'Cancel anytime';

  @override
  String get processingPurchase => 'Processing purchase…';

  @override
  String get restoringPurchases => 'Restoring purchases…';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get continueFreeWithAds => 'Continue with free version with Ads';

  @override
  String get alreadyProTitle => 'You are Pro ✅';

  @override
  String get alreadyProBody => 'Enjoy unlimited invoices, reports, and no ads.';

  @override
  String get continueText => 'Continue';

  @override
  String get includesInPro => 'Included in Pro';

  @override
  String get benefitNoAds => 'No ads (Banner/Interstitial/Rewarded)';

  @override
  String get benefitUnlimitedInvoices =>
      'Unlimited invoices + statuses (draft/sent/paid)';

  @override
  String get benefitPremiumTemplates =>
      'Premium templates + colors + business logo';

  @override
  String get benefitNoWatermarkPdf => 'Professional PDF without watermark';

  @override
  String get benefitTaxReports =>
      'Tax reports: monthly and yearly (taxes/tips/net)';

  @override
  String get benefitExport => 'Export PDF/CSV/Excel (for accounting)';

  @override
  String get benefitCloudBackup => 'Cloud backup + restore (multi-device)';

  @override
  String continueWithPlan(Object plan) {
    return 'Continue with $plan';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'By subscribing, payment will be charged to your $store account. The subscription renews automatically unless you cancel at least 24 hours before the end of the current period. You can manage or cancel your subscription in your store settings.';
  }

  @override
  String get reportsTitle => 'Reports';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'By month';

  @override
  String get byYear => 'By year';

  @override
  String get monthLabel => 'Month';

  @override
  String get yearLabel => 'Year';

  @override
  String get businessProfileTitle => 'Business Profile';

  @override
  String get save => 'Save';

  @override
  String get uploadLogo => 'Upload logo';

  @override
  String get remove => 'Remove';

  @override
  String get businessNameLabel => 'Business name';

  @override
  String get ownerNameLabel => 'Owner / contact name';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get addressLabel => 'Address';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get taxDefaultLabel => 'Default tax (%)';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get range0to100 => 'Must be between 0 and 100';

  @override
  String get requiredField => 'Required';

  @override
  String get footerNoteLabel => 'Footer note (PDF)';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get businessFooterDefault => 'Thank you for your business.';

  @override
  String get businessSavedSuccess => 'Business profile saved successfully';

  @override
  String get businessInfoSection => 'Business information';

  @override
  String get settingsSection => 'Settings';

  @override
  String get footerSection => 'Footer note (PDF)';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get bestValueStar => '⭐ Best value';

  @override
  String get invoicesTitle => 'Invoices';

  @override
  String get noInvoicesYet => 'No invoices yet.';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'Free plan: monthly limit $limit invoices • Upgrade for unlimited';
  }

  @override
  String get filtersTitle => 'Filters';

  @override
  String get clientLabel => 'Client';

  @override
  String get allMonths => 'All months';

  @override
  String get allClients => 'All clients';

  @override
  String get clear => 'Clear';

  @override
  String get invoicesSummaryLabel => 'Invoices';

  @override
  String get totalTitle => 'Total';

  @override
  String get dateLabel => 'Date';

  @override
  String get noResultsForFilters => 'No results for selected filters.';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'Free plan: $current / $limit invoices this month.\n\nUpgrade to Pro for unlimited.';
  }

  @override
  String get deleteInvoiceTitle => 'Delete invoice?';

  @override
  String deleteInvoiceBody(Object invNo) {
    return 'Are you sure you want to delete $invNo?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get sendPdf => 'Send PDF';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'Invoice $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'Error creating/sending PDF: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'Report • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'Report • Year $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'Invoices: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'Total Sales: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'Total Tax: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'Total Tip: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'Net: \$$amount';
  }

  @override
  String get calculatedFromInvoices =>
      'Calculated from your invoices in Firestore.';

  @override
  String get noInvoicesInPeriod => 'No invoices in that period.';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get yearlyProReason => 'Yearly report is PRO. Upgrade to unlock it.';

  @override
  String get exportPdfProReason => 'Exporting report PDF is PRO.';

  @override
  String get exportCsvProReason => 'Exporting CSV is PRO.';

  @override
  String get noDataToExport => 'No data to export.';

  @override
  String get freePlanReportsNote =>
      'Free plan: monthly reports only. Upgrade for yearly reports and export.';

  @override
  String get genericError => 'Something went wrong. Try again.';

  @override
  String get newInvoiceTitle => 'New Invoice';

  @override
  String get editInvoiceTitle => 'Edit Invoice';

  @override
  String get pickClient => 'Pick client';

  @override
  String get invoiceAutoNumberLabel => 'Invoice # (auto)';

  @override
  String invoiceDateLabel(Object date) {
    return 'Invoice date: $date';
  }

  @override
  String get clientNameLabel => 'Client name';

  @override
  String get clientNameRequired => 'Client name required';

  @override
  String get clientEmailOptionalLabel => 'Client email (optional)';

  @override
  String get clientPhoneOptionalLabel => 'Client phone (optional)';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get itemsTitle => 'Items';

  @override
  String get descriptionLabel => 'Description';

  @override
  String itemDateLabel(Object date) {
    return 'Item date: $date';
  }

  @override
  String get qtyLabel => 'Qty';

  @override
  String get priceLabel => 'Price';

  @override
  String lineTotalLabel(Object amount) {
    return 'Line total: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'Tax % (default owner)';

  @override
  String get tipPercentChip => 'Tip %';

  @override
  String get tipAmountChip => 'Tip \$';

  @override
  String get tipPercentLabel => 'Tip percent (%)';

  @override
  String get tipAmountLabel => 'Tip amount (\$)';

  @override
  String get messageOptionalLabel => 'Message (optional)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'Subtotal: \$$sub\nTax: \$$tax\nTip: \$$tip\nTotal: \$$total';
  }

  @override
  String get saving => 'Saving…';

  @override
  String get saveInvoice => 'Save invoice';

  @override
  String get updateInvoice => 'Update invoice';

  @override
  String get addAtLeastOneItem => 'Add at least 1 item';

  @override
  String errorSavingInvoice(Object error) {
    return 'Error saving invoice: $error';
  }

  @override
  String get savedTab => 'Saved';

  @override
  String get contactsTab => 'Contacts';

  @override
  String get noSavedClients => 'No saved clients';

  @override
  String get permissionDeniedContacts => 'Permission denied: Contacts';

  @override
  String get noContactsFound => 'No contacts found on this device/emulator';

  @override
  String contactsError(Object error) {
    return 'Contacts error: $error';
  }

  @override
  String get noName => '(No name)';

  @override
  String get newClientTitle => 'New client';

  @override
  String get editClientTitle => 'Edit client';

  @override
  String get clientInfoSection => 'Client information';

  @override
  String get notesLabel => 'Notes';

  @override
  String get notesHint => 'Add notes (optional)';

  @override
  String get clientCreateHint =>
      'Tip: Add email/phone to send invoices faster.';

  @override
  String get clientEditHint => 'You can update client info anytime.';

  @override
  String errorSavingClient(Object error) {
    return 'Error saving client: $error';
  }

  @override
  String get clientsTitle => 'Clients';

  @override
  String get searchClientsLabel => 'Search clients';

  @override
  String clientsCount(Object count) {
    return '$count client(s)';
  }

  @override
  String get noClientsYet => 'No clients yet.';

  @override
  String get noClientsForSearch => 'No clients match your search.';

  @override
  String get cannotOpenDialer => 'Cannot open dialer';

  @override
  String get cannotOpenSms => 'Cannot open SMS';

  @override
  String get whatsAppNotAvailable => 'WhatsApp not available';

  @override
  String get cannotOpenEmail => 'Cannot open email';

  @override
  String get deleteClientTitle => 'Delete client?';

  @override
  String deleteClientBody(Object name) {
    return 'Remove $name?';
  }

  @override
  String get call => 'Call';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'Email';

  @override
  String get shareAppTitle => 'Try EzInvoice 👇';

  @override
  String get shareAppBody =>
      'Create invoices, send PDFs, and track reports easily.';

  @override
  String get shareAppTooltip => 'Share app';

  @override
  String get openGooglePlayTooltip => 'Open Google Play';

  @override
  String get openAppStoreTooltip => 'Open App Store';

  @override
  String get openWebsiteTooltip => 'Open website';

  @override
  String get availableLanguages => 'Available languages';

  @override
  String get usePhoneLanguage => 'Use your phone language';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'Receipt $invoiceNumber for $clientName';
  }

  @override
  String get report => 'Report';

  @override
  String get invoicesLabel => 'Invoices';

  @override
  String get totalSalesLabel => 'Total Sales';

  @override
  String get totalTaxLabel => 'Total Tax';

  @override
  String get totalTipLabel => 'Total Tip';

  @override
  String get netLabel => 'Net';

  @override
  String get sentLabel => 'Sent';

  @override
  String get paidLabel => 'Paid';

  @override
  String get overdueLabel => 'Overdue';

  @override
  String get reportCalculatedHint =>
      'Calculated from your invoices in Firestore.';

  @override
  String get exportPdfComingSoon => 'Export PDF (coming soon)';

  @override
  String get exportCsvComingSoon => 'Export CSV (coming soon)';

  @override
  String get unsentLabel => 'Unsent';

  @override
  String get deleteAccountTitle => 'Delete Account';

  @override
  String get deleteAccountWarning =>
      'This action will permanently delete your account and all associated data.';

  @override
  String get deleteAccountButton => 'Delete Account';

  @override
  String get deleteAccountConfirmTitle => 'Confirm Deletion';

  @override
  String get deleteAccountConfirmMessage =>
      'Are you sure? This action cannot be undone.';
}
