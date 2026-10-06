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
  String get reportCalculatedHint => 'Calculated from your invoices.';

  @override
  String get exportPdfComingSoon => 'Export PDF (coming soon)';

  @override
  String get exportCsvComingSoon => 'Export CSV (coming soon)';

  @override
  String get unsentLabel => 'Unsent';

  @override
  String get servicePresetsTitle => 'Service presets';

  @override
  String get servicePresetsScreenTitle => 'Service Presets';

  @override
  String get servicePresetsAddNew => 'Add new preset';

  @override
  String get servicePresetsHint => 'e.g. Cleaning, Repair, Consultation...';

  @override
  String get servicePresetsAddButton => 'Add';

  @override
  String get addServiceLabel => 'Add a service';

  @override
  String get yourPresets => 'Your presets';

  @override
  String get noPresetsYet => 'No presets yet.';

  @override
  String get notNow => 'Not now';

  @override
  String get openPaywallPlaceholder =>
      'Open Paywall (connect PaywallScreen here)';

  @override
  String get invoiceStyleTitle => 'Invoice style';

  @override
  String get invoiceFreeStyleHint =>
      'Free plan uses one invoice version (Minimal). Upgrade to Pro to unlock all layouts and palettes.';

  @override
  String get invoicePaletteLabel => 'Invoice palette';

  @override
  String get invoiceLayoutLabel => 'Invoice layout';

  @override
  String get saveInvoicePaletteError => 'Could not save invoice palette.';

  @override
  String get saveInvoiceLayoutError => 'Could not save invoice layout.';

  @override
  String get reportStyleTitle => 'Report style';

  @override
  String get reportFreeStyleHint =>
      'Free plan uses one report version (Minimal). Upgrade to Pro to unlock all layouts and palettes.';

  @override
  String get reportPaletteLabel => 'Report palette';

  @override
  String get reportLayoutLabel => 'Report layout';

  @override
  String get saveReportPaletteError => 'Could not save report palette.';

  @override
  String get saveReportLayoutError => 'Could not save report layout.';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return '$docType style: $style | Palette: $palette';
  }

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

  @override
  String get profileSaved => 'Saved automatically';

  @override
  String get profileSaveError => 'Could not save. Your changes are still here.';

  @override
  String get profileRetry => 'Retry';

  @override
  String get profileAutosaveHint =>
      'Changes save automatically. Closing keeps your changes.';

  @override
  String get profileLogo => 'Business logo';

  @override
  String get profileDefaults => 'Invoice defaults';

  @override
  String get profileTaxInvalid => 'Check the tax rate (0–100%).';

  @override
  String get metricLoadError => 'Could not load this report. Try again.';

  @override
  String get totalInvoicedTitle => 'Total invoiced';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'Error: $error';
  }

  @override
  String get rememberEmail => 'Remember my email';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get passwordResetEnterEmail =>
      'Enter your email to send the reset link.';

  @override
  String get passwordResetSent =>
      'We sent you an email to reset your password. Check Spam or Junk.';

  @override
  String get passwordResetNoAccount => 'No account was found for that email.';

  @override
  String get invalidEmail => 'Invalid email.';

  @override
  String get passwordResetError => 'Could not send the email. Try again.';

  @override
  String get updateRequired => 'Update required';

  @override
  String get updateRequiredBody =>
      'A new version of Ez Invoice is available. To continue, update the app from the store.';

  @override
  String get updateNow => 'Update now';

  @override
  String get open => 'Open';

  @override
  String get share => 'Share';

  @override
  String get actions => 'Actions';

  @override
  String get message => 'Message';

  @override
  String get done => 'Done';

  @override
  String get confirm => 'Confirm';

  @override
  String get free => 'FREE';

  @override
  String get clientInformation => 'Client information';

  @override
  String get clientName => 'Client name';

  @override
  String get notesOptional => 'Notes (optional)';

  @override
  String get saveClient => 'Save client';

  @override
  String get importFromContacts => 'Import from contacts';

  @override
  String get importContactsDescription =>
      'Fill name, phone, and email instantly.';

  @override
  String get loadContacts => 'Load contacts';

  @override
  String get clientPhone => 'Client phone';

  @override
  String get searchContacts => 'Search contacts';

  @override
  String get shareClient => 'Share client';

  @override
  String get clientProfile => 'Client profile';

  @override
  String get chooseSavedService => 'Choose saved service';

  @override
  String get searchSavedServices => 'Search saved services';

  @override
  String get noSavedServicesFound => 'No saved services found';

  @override
  String get noSavedServicesToUse =>
      'No saved services yet. Type one above, then save it for later.';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'Already saved: $service';
  }

  @override
  String savedService(Object service) {
    return 'Saved service: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'Could not save the service: $error';
  }

  @override
  String get saveServiceForLater => 'Save service for later';

  @override
  String get removeClient => 'Remove client';

  @override
  String get service => 'Service';

  @override
  String get taxAndTip => 'Tax & tip';

  @override
  String get totals => 'Totals';

  @override
  String dueDate(Object date) {
    return 'Due date: $date';
  }

  @override
  String paidDate(Object date) {
    return 'Paid date: $date';
  }

  @override
  String get notPaidYet => 'Not paid yet';

  @override
  String paymentMethodWithValue(Object method) {
    return 'Method: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'Note: $note';
  }

  @override
  String get markAsPaid => 'Mark as paid';

  @override
  String get markAsUnpaid => 'Mark as unpaid';

  @override
  String get editTax => 'Edit';

  @override
  String get addClient => 'Add a client';

  @override
  String get firstClientHint =>
      'Create your first client to reuse it in future invoices.';

  @override
  String get searchSavedClients => 'Search saved clients';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get cash => 'Cash';

  @override
  String get card => 'Card';

  @override
  String get check => 'Check';

  @override
  String get other => 'Other';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'Could not mark the invoice as paid: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'Could not mark the invoice as unpaid: $error';
  }

  @override
  String deleteError(Object error) {
    return 'Could not delete the invoice: $error';
  }

  @override
  String get invoiceDeleted => 'Invoice deleted';

  @override
  String get invoiceMarkedSent => 'Marked as sent ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'Could not mark as sent: $error';
  }

  @override
  String get invoiceMarkedUnsent => 'Marked as unsent ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'Could not mark as unsent: $error';
  }

  @override
  String get invoiceMarkedPaid => 'Marked as paid ✅';

  @override
  String get invoiceMarkedUnpaid => 'Marked as unpaid ✅';

  @override
  String get invoiceLoadingError => 'Could not load invoices';

  @override
  String get tipType => 'Tip type';

  @override
  String get amountOption => 'Amount (\$)';

  @override
  String get percentageOption => 'Percentage (%)';

  @override
  String get pdfPreview => 'PDF preview';

  @override
  String get openPdf => 'Open PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get selectReportMonth => 'Select report month';

  @override
  String reportForBusiness(Object business) {
    return 'Reports • $business';
  }

  @override
  String get tapToChangeMonth => 'Tap to change the month';

  @override
  String csvSaved(Object path) {
    return 'CSV saved: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'Could not export CSV: $error';
  }

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutTagline => 'Clear invoicing for businesses in motion';

  @override
  String get aboutAppTitle => 'The app';

  @override
  String get aboutAppBody =>
      'EzInvoice brings invoices, clients, payments, and reports into one simple flow so you can see what matters and get paid with confidence.';

  @override
  String get aboutCompanyTitle => 'The company';

  @override
  String get aboutCompanyBody =>
      'Liisgo LLC creates practical tools that help small businesses work with more order, clarity, and confidence.';

  @override
  String get aboutPromiseTitle => 'Made for your day-to-day';

  @override
  String get aboutPromiseBody =>
      'Every EzInvoice decision aims to reduce steps, keep details visible, and make running your business feel simpler.';

  @override
  String get visitLiisgo => 'Visit Liisgo';

  @override
  String get contactSupport => 'Contact support';

  @override
  String get shareEzInvoice => 'Share EzInvoice';

  @override
  String get sendIdeaOrBug => 'Send an idea or bug';

  @override
  String get feedbackTitle => 'Your feedback matters';

  @override
  String get feedbackSubtitle =>
      'Tell us what you would improve or what did not work well.';

  @override
  String get feedbackIdea => 'Idea';

  @override
  String get feedbackBug => 'Bug';

  @override
  String get feedbackHint => 'Write your idea or explain what happened…';

  @override
  String get feedbackRequired => 'Write a message before sending.';

  @override
  String get continueToEmail => 'Continue to email';

  @override
  String get couldNotOpenLink => 'Could not open this link.';

  @override
  String shareAppText(Object storeUrl) {
    return 'Meet EzInvoice Pro: invoices, clients, and reports in one place.\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return '$kind for EzInvoice';
  }

  @override
  String get supportEmailSubject => 'EzInvoice support';

  @override
  String get changePassword => 'Change password';

  @override
  String get changePasswordSubtitle => 'Update your account password.';

  @override
  String get confirmCurrentPasswordHint =>
      'For security, confirm your current password first.';

  @override
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get updatePassword => 'Update password';

  @override
  String get passwordAtLeastSix => 'Must be at least 6 characters.';

  @override
  String get noActiveSession => 'No active session.';

  @override
  String get passwordsDoNotMatch => 'The new password does not match.';

  @override
  String get passwordMustDiffer => 'The new password must be different.';

  @override
  String get passwordUpdated => 'Password updated successfully.';

  @override
  String get incorrectPassword => 'Current password is wrong.';

  @override
  String get weakPassword => 'The new password is too weak.';

  @override
  String get reauthenticationNeeded =>
      'For security, sign in again and try once more.';

  @override
  String get changePasswordError => 'Could not change password.';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get reauthCancelled => 'Reauthentication cancelled.';

  @override
  String get accountDeleted =>
      'Your account and data were permanently deleted.';

  @override
  String get deleteAccountIncorrectPassword => 'Incorrect password.';

  @override
  String get deleteAccountError => 'Could not delete account.';

  @override
  String get deleteAccountBody =>
      'If you delete your account:\n\n• Your clients, invoices, reports, and business profile will be permanently deleted.\n• This action cannot be undone.\n• If you have an active subscription, manage or cancel it in App Store/Google Play.';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get agreeTermsPrivacy =>
      'Please agree to the Terms & Conditions and Privacy Policy first.';

  @override
  String get currentPlan => 'Current plan';

  @override
  String get currentPlanFree => 'Current plan: Free';

  @override
  String get proPlanDescription =>
      'Free includes ads and limited usage. Pro removes ads and unlocks unlimited invoices, reports, premium templates, exports, and cloud backup.';

  @override
  String get adsIncluded => 'Ads included';

  @override
  String get limitedInvoicesPerMonth => 'Limited invoices each month';

  @override
  String get basicInvoiceStyle => 'Basic invoice style';

  @override
  String get basicReports => 'Basic reports';

  @override
  String get pdfIncludesBranding => 'PDF includes EzInvoice branding';

  @override
  String get unpaidLabel => 'Unpaid';

  @override
  String get loading => 'Loading...';

  @override
  String get store => 'Store';

  @override
  String get storeProductLoadingOne =>
      'One subscription product is still loading. You can continue with the available plan while the other product loads.';

  @override
  String get storeProductsLoading =>
      'Connecting to store subscription products. If this does not finish loading, confirm the subscriptions are ready in your store console.';

  @override
  String get agreeTo => 'I agree to the ';

  @override
  String get and => ' and ';

  @override
  String get currentProPlanDescription =>
      'You already have Ez Invoice Pro. You can review both subscription options below.';

  @override
  String freeVsPro(Object pro) {
    return 'Free vs $pro';
  }

  @override
  String get openInvoices => 'Open invoices.';

  @override
  String get allCaughtUp => 'All caught up';

  @override
  String itemsToReview(Object count) {
    return '$count to review';
  }

  @override
  String get pdfInvoice => 'Invoice';

  @override
  String get pdfReceipt => 'Receipt';

  @override
  String get pdfBusiness => 'Business';

  @override
  String get pdfPhone => 'Phone';

  @override
  String get pdfEmail => 'Email';

  @override
  String get pdfNumber => 'No.';

  @override
  String get pdfDate => 'Date';

  @override
  String get pdfDue => 'Due';

  @override
  String get pdfPaid => 'Paid';

  @override
  String get pdfPaidDate => 'Paid date';

  @override
  String get pdfMethod => 'Method';

  @override
  String get pdfBillTo => 'Bill to';

  @override
  String get pdfClient => 'Client';

  @override
  String get pdfDescription => 'Description';

  @override
  String get pdfQuantity => 'Qty';

  @override
  String get pdfPrice => 'Price';

  @override
  String get pdfSubtotal => 'Subtotal';

  @override
  String get pdfTax => 'Tax';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'Tax ($rate%)';
  }

  @override
  String get pdfTip => 'Tip';

  @override
  String pdfTipWithRate(Object rate) {
    return 'Tip ($rate%)';
  }

  @override
  String get pdfDiscount => 'Discount';

  @override
  String get pdfMessage => 'Message';

  @override
  String get pdfPaymentNote => 'Payment note';

  @override
  String get pdfThankYou => 'Thank you for your business.';

  @override
  String get pdfPoweredBy => 'Powered by EzInvoice';

  @override
  String get pdfFreeVersion => 'FREE VERSION';

  @override
  String get pdfTotal => 'Total';

  @override
  String get styleMinimal => 'Minimal';

  @override
  String get styleProfessional => 'Professional';

  @override
  String get styleCorporate => 'Corporate';

  @override
  String get styleModern => 'Modern';

  @override
  String get styleSlate => 'Slate';

  @override
  String get reportDocument => 'Report';

  @override
  String get reportPrintDocument => 'Print report';

  @override
  String get reportMonth => 'Month';

  @override
  String get reportYear => 'Year';

  @override
  String get reportGeneratedOn => 'Generated on';

  @override
  String get reportInvoices => 'Invoices';

  @override
  String get reportStatus => 'Status';

  @override
  String get reportTotals => 'Totals';

  @override
  String get reportSales => 'Sales';

  @override
  String get reportTotalTax => 'Total tax';

  @override
  String get reportTotalTip => 'Total tip';

  @override
  String get reportTotalInvoiced => 'Total invoiced';

  @override
  String get reportUnsent => 'Unsent';

  @override
  String get reportSent => 'Sent';

  @override
  String get reportPaid => 'Paid';

  @override
  String get reportOverdue => 'Overdue';

  @override
  String get reportInvoiceNumber => 'Invoice no.';

  @override
  String get reportClient => 'Client';

  @override
  String get reportDueDate => 'Due date';

  @override
  String get reportDescription => 'Description';

  @override
  String get reportDate => 'Date';

  @override
  String get reportFreeVersion => 'FREE VERSION';

  @override
  String get reportPoweredBy => 'Powered by EzInvoice';

  @override
  String reportPdfShareText(Object title) {
    return 'PDF report: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'CSV report: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'Print: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'Report_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'Report_Year_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'Report | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'Report | $year';
  }

  @override
  String get reportBreakdown => 'Breakdown';

  @override
  String get reportInvoicesStatus => 'Invoice status';

  @override
  String get viewReport => 'View report';

  @override
  String get reviewBeforeExport => 'Review the PDF or CSV before exporting.';

  @override
  String get customizeReport => 'Customize the report';

  @override
  String get reportPreviewUpdates =>
      'Changes appear immediately in your preview.';

  @override
  String get yourReportPreview => 'Your report preview';

  @override
  String get reportStyleLiveHint => 'Change the design and see it live.';

  @override
  String get watchAdToExportReport =>
      'Watch the full ad to export this report. Upgrade to Pro to export without ads.';

  @override
  String reportExportError(Object error) {
    return 'Could not export report: $error';
  }

  @override
  String get shareCsvFile => 'Share CSV file';

  @override
  String get shareCsvFileDescription =>
      'Share the .csv attachment by email, Drive, or another app.';

  @override
  String get shareReportAsText => 'Share as text (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription => 'Send a report summary as text.';

  @override
  String get printCsv => 'Print CSV';

  @override
  String get printReportDescription => 'Print the report as a PDF table.';

  @override
  String get reportPreview => 'Preview';

  @override
  String get live => 'Live';

  @override
  String get proFeatureUnlimitedInvoices => 'Unlimited invoices';

  @override
  String get proFeatureRemovePdfBranding => 'Remove PDF branding';

  @override
  String get proFeatureExportCsv => 'Export CSV';

  @override
  String get proFeaturePremiumTemplates => 'Premium templates';

  @override
  String get proFeatureDetailedTaxReport => 'Detailed tax report';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'Free plan allows up to $limit invoices per month.';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'Remove “Powered by EzInvoice” from PDFs.';

  @override
  String get proFeatureExportCsvDescription => 'Export your invoices to CSV.';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'Unlock premium invoice templates.';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'See detailed tax breakdown reports.';

  @override
  String get pdfShareText => 'Invoice PDF from EzInvoice';
}
