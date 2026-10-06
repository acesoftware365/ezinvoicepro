// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'अपना अकाउंट बनाएं';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get login => 'लॉगिन';

  @override
  String get register => 'अकाउंट बनाएं';

  @override
  String get alreadyHaveAccount => 'क्या आपके पास पहले से अकाउंट है?';

  @override
  String get signIn => 'साइन इन';

  @override
  String get dontHaveAccount => 'क्या आपका अकाउंट नहीं है?';

  @override
  String get signUp => 'साइन अप';

  @override
  String get processing => 'प्रोसेस हो रहा है...';

  @override
  String get invalidCredentials =>
      'एक वैध ईमेल और पासवर्ड दर्ज करें (6+ अक्षर)';

  @override
  String get authError => 'ऑथेंटिकेशन त्रुटि';

  @override
  String get home => 'होम';

  @override
  String get clients => 'क्लाइंट्स';

  @override
  String get invoices => 'इनवॉइस';

  @override
  String get reports => 'रिपोर्ट्स';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get business => 'बिज़नेस';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsLanguageDescription => 'ऐप की भाषा चुनें।';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get privacyPolicy => 'प्राइवेसी पॉलिसी';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'Hi $name,\nEzInvoice से आपका इनवॉइस भेज रहा हूँ। ✅';
  }

  @override
  String get invoiceEmailSubject => 'Invoice - EzInvoice';

  @override
  String get dashboardTitle => 'डैशबोर्ड';

  @override
  String get monthWord => 'महीना';

  @override
  String get planLabel => 'प्लान';

  @override
  String get invoicesRemaining => 'बचे हुए इनवॉइस';

  @override
  String get proUnlimitedLabel => 'PRO · अनलिमिटेड';

  @override
  String get createNewInvoice => 'नया इनवॉइस बनाएं';

  @override
  String get limitReachedSubtitle => 'लिमिट पूरी • Pro में अपग्रेड करें';

  @override
  String get createInvoiceFastSubtitle => 'सेकंडों में इनवॉइस + PDF बनाएं';

  @override
  String get limitReachedTitle => 'लिमिट पूरी हो गई';

  @override
  String get limitReachedBody =>
      'अनलिमिटेड इनवॉइस और विज्ञापन हटाने के लिए Pro में अपग्रेड करें।';

  @override
  String get upgrade => 'अपग्रेड';

  @override
  String get monthSummaryTitle => 'महीने का सारांश';

  @override
  String get salesTitle => 'सेल्स';

  @override
  String get tipTitle => 'टिप';

  @override
  String get subtotalTitle => 'सबटोटल';

  @override
  String get taxTitle => 'टैक्स';

  @override
  String get beforeTaxTip => 'टैक्स/टिप से पहले';

  @override
  String get collectedThisMonth => 'इस महीने कलेक्ट किया';

  @override
  String get quickAccessTitle => 'क्विक एक्सेस';

  @override
  String get clientsManageSubtitle => 'क्लाइंट बनाएं / एडिट करें';

  @override
  String get invoicesViewSendSubtitle => 'PDF देखें और भेजें';

  @override
  String get monthlyYearlySubtitle => 'मासिक / वार्षिक';

  @override
  String get businessProfileSubtitle => 'प्रोफाइल / लोगो / टैक्स';

  @override
  String invoiceCount(Object count) {
    return '$count इनवॉइस';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'बंद करें';

  @override
  String get paywallHeaderTitle => 'अपने बिज़नेस के लिए सब कुछ अनलॉक करें';

  @override
  String get paywallHeaderSubtitle =>
      'कोई विज्ञापन नहीं • अनलिमिटेड इनवॉइस • टैक्स रिपोर्ट्स • प्रीमियम टेम्पलेट्स';

  @override
  String get bestValue => 'सबसे बढ़िया';

  @override
  String get proYearly => 'Pro वार्षिक';

  @override
  String get saveMoreYearly => 'सालाना भुगतान पर अधिक बचत';

  @override
  String get proMonthly => 'Pro मासिक';

  @override
  String get flexible => 'लचीला';

  @override
  String get cancelAnytime => 'कभी भी कैंसिल करें';

  @override
  String get processingPurchase => 'खरीद प्रोसेस हो रही है…';

  @override
  String get restoringPurchases => 'खरीदें रिस्टोर हो रही हैं…';

  @override
  String get restorePurchases => 'खरीदें रिस्टोर करें';

  @override
  String get continueFreeWithAds => 'विज्ञापनों के साथ फ्री वर्ज़न जारी रखें';

  @override
  String get alreadyProTitle => 'आप Pro हैं ✅';

  @override
  String get alreadyProBody =>
      'अनलिमिटेड इनवॉइस, रिपोर्ट्स और बिना विज्ञापन का आनंद लें।';

  @override
  String get continueText => 'जारी रखें';

  @override
  String get includesInPro => 'Pro में शामिल';

  @override
  String get benefitNoAds => 'कोई विज्ञापन नहीं (Banner/Interstitial/Rewarded)';

  @override
  String get benefitUnlimitedInvoices =>
      'अनलिमिटेड इनवॉइस + स्टेटस (ड्राफ्ट/सेंट/पेड)';

  @override
  String get benefitPremiumTemplates =>
      'प्रीमियम टेम्पलेट्स + रंग + बिज़नेस लोगो';

  @override
  String get benefitNoWatermarkPdf => 'वॉटरमार्क के बिना प्रोफेशनल PDF';

  @override
  String get benefitTaxReports =>
      'टैक्स रिपोर्ट्स: मासिक और वार्षिक (टैक्स/टिप/नेट)';

  @override
  String get benefitExport => 'PDF/CSV/Excel एक्सपोर्ट (अकाउंटिंग के लिए)';

  @override
  String get benefitCloudBackup => 'क्लाउड बैकअप + रिस्टोर (मल्टी-डिवाइस)';

  @override
  String continueWithPlan(Object plan) {
    return '$plan के साथ जारी रखें';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'सब्सक्राइब करने पर भुगतान आपके $store अकाउंट से लिया जाएगा। सब्सक्रिप्शन अपने आप रिन्यू होता है जब तक कि आप वर्तमान अवधि खत्म होने से कम से कम 24 घंटे पहले कैंसिल न करें। आप स्टोर सेटिंग्स में सब्सक्रिप्शन मैनेज या कैंसिल कर सकते हैं।';
  }

  @override
  String get reportsTitle => 'रिपोर्ट्स';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'महीने के अनुसार';

  @override
  String get byYear => 'साल के अनुसार';

  @override
  String get monthLabel => 'महीना';

  @override
  String get yearLabel => 'साल';

  @override
  String get businessProfileTitle => 'बिज़नेस प्रोफाइल';

  @override
  String get save => 'सेव करें';

  @override
  String get uploadLogo => 'लोगो अपलोड करें';

  @override
  String get remove => 'हटाएं';

  @override
  String get businessNameLabel => 'बिज़नेस नाम';

  @override
  String get ownerNameLabel => 'ओनर / कॉन्टैक्ट नाम';

  @override
  String get phoneLabel => 'फ़ोन';

  @override
  String get addressLabel => 'पता';

  @override
  String get currencyLabel => 'मुद्रा';

  @override
  String get taxDefaultLabel => 'डिफ़ॉल्ट टैक्स (%)';

  @override
  String get invalidNumber => 'अमान्य संख्या';

  @override
  String get range0to100 => '0 से 100 के बीच होना चाहिए';

  @override
  String get requiredField => 'आवश्यक';

  @override
  String get footerNoteLabel => 'फुटर नोट (PDF)';

  @override
  String get saveChanges => 'परिवर्तन सेव करें';

  @override
  String get businessFooterDefault => 'आपके बिज़नेस के लिए धन्यवाद।';

  @override
  String get businessSavedSuccess => 'बिज़नेस प्रोफाइल सफलतापूर्वक सेव हुआ';

  @override
  String get businessInfoSection => 'बिज़नेस जानकारी';

  @override
  String get settingsSection => 'सेटिंग्स';

  @override
  String get footerSection => 'फुटर नोट (PDF)';

  @override
  String get upgradeToPro => 'Pro में अपग्रेड करें';

  @override
  String get bestValueStar => '⭐ सबसे बढ़िया';

  @override
  String get invoicesTitle => 'इनवॉइस';

  @override
  String get noInvoicesYet => 'अभी कोई इनवॉइस नहीं।';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'फ्री प्लान: मासिक सीमा $limit इनवॉइस • अनलिमिटेड के लिए अपग्रेड';
  }

  @override
  String get filtersTitle => 'फ़िल्टर';

  @override
  String get clientLabel => 'क्लाइंट';

  @override
  String get allMonths => 'सभी महीने';

  @override
  String get allClients => 'सभी क्लाइंट';

  @override
  String get clear => 'क्लियर';

  @override
  String get invoicesSummaryLabel => 'इनवॉइस';

  @override
  String get totalTitle => 'कुल';

  @override
  String get dateLabel => 'तारीख';

  @override
  String get noResultsForFilters => 'चुने हुए फ़िल्टर के लिए कोई परिणाम नहीं।';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'फ्री प्लान: $current / $limit इनवॉइस इस महीने।\n\nअनलिमिटेड के लिए Pro में अपग्रेड करें।';
  }

  @override
  String get deleteInvoiceTitle => 'इनवॉइस हटाएं?';

  @override
  String deleteInvoiceBody(Object invNo) {
    return 'क्या आप वाकई $invNo हटाना चाहते हैं?';
  }

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get edit => 'एडिट';

  @override
  String get sendPdf => 'PDF भेजें';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'इनवॉइस $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'PDF बनाने/भेजने में त्रुटि: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'रिपोर्ट • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'रिपोर्ट • वर्ष $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'इनवॉइस: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'कुल सेल्स: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'कुल टैक्स: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'कुल टिप: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'नेट: \$$amount';
  }

  @override
  String get calculatedFromInvoices =>
      'Firestore में आपके इनवॉइस से गणना की गई।';

  @override
  String get noInvoicesInPeriod => 'उस अवधि में कोई इनवॉइस नहीं।';

  @override
  String get exportPdf => 'PDF एक्सपोर्ट';

  @override
  String get exportCsv => 'CSV एक्सपोर्ट';

  @override
  String get yearlyProReason =>
      'वार्षिक रिपोर्ट PRO है। अनलॉक करने के लिए अपग्रेड करें।';

  @override
  String get exportPdfProReason => 'रिपोर्ट PDF एक्सपोर्ट PRO है।';

  @override
  String get exportCsvProReason => 'CSV एक्सपोर्ट PRO है।';

  @override
  String get noDataToExport => 'एक्सपोर्ट करने के लिए कोई डेटा नहीं।';

  @override
  String get freePlanReportsNote =>
      'फ्री प्लान: केवल मासिक रिपोर्ट्स। वार्षिक रिपोर्ट्स और एक्सपोर्ट के लिए अपग्रेड करें।';

  @override
  String get genericError => 'कुछ गलत हो गया। फिर से कोशिश करें।';

  @override
  String get newInvoiceTitle => 'नया इनवॉइस';

  @override
  String get editInvoiceTitle => 'इनवॉइस एडिट करें';

  @override
  String get pickClient => 'क्लाइंट चुनें';

  @override
  String get invoiceAutoNumberLabel => 'इनवॉइस # (ऑटो)';

  @override
  String invoiceDateLabel(Object date) {
    return 'इनवॉइस तारीख: $date';
  }

  @override
  String get clientNameLabel => 'क्लाइंट नाम';

  @override
  String get clientNameRequired => 'क्लाइंट नाम आवश्यक है';

  @override
  String get clientEmailOptionalLabel => 'क्लाइंट ईमेल (वैकल्पिक)';

  @override
  String get clientPhoneOptionalLabel => 'क्लाइंट फ़ोन (वैकल्पिक)';

  @override
  String get invalidEmailFormat => 'अमान्य ईमेल फ़ॉर्मेट';

  @override
  String get itemsTitle => 'आइटम्स';

  @override
  String get descriptionLabel => 'विवरण';

  @override
  String itemDateLabel(Object date) {
    return 'आइटम तारीख: $date';
  }

  @override
  String get qtyLabel => 'मात्रा';

  @override
  String get priceLabel => 'कीमत';

  @override
  String lineTotalLabel(Object amount) {
    return 'लाइन टोटल: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'टैक्स % (डिफ़ॉल्ट ओनर)';

  @override
  String get tipPercentChip => 'टिप %';

  @override
  String get tipAmountChip => 'टिप \$';

  @override
  String get tipPercentLabel => 'टिप प्रतिशत (%)';

  @override
  String get tipAmountLabel => 'टिप राशि (\$)';

  @override
  String get messageOptionalLabel => 'मैसेज (वैकल्पिक)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'सबटोटल: \$$sub\nटैक्स: \$$tax\nटिप: \$$tip\nटोटल: \$$total';
  }

  @override
  String get saving => 'सेव हो रहा है…';

  @override
  String get saveInvoice => 'इनवॉइस सेव करें';

  @override
  String get updateInvoice => 'इनवॉइस अपडेट करें';

  @override
  String get addAtLeastOneItem => 'कम से कम 1 आइटम जोड़ें';

  @override
  String errorSavingInvoice(Object error) {
    return 'इनवॉइस सेव करने में त्रुटि: $error';
  }

  @override
  String get savedTab => 'सेव्ड';

  @override
  String get contactsTab => 'कॉन्टैक्ट्स';

  @override
  String get noSavedClients => 'कोई सेव्ड क्लाइंट नहीं';

  @override
  String get permissionDeniedContacts => 'परमिशन डिनाइड: कॉन्टैक्ट्स';

  @override
  String get noContactsFound => 'इस डिवाइस/एमुलेटर पर कोई कॉन्टैक्ट नहीं मिला';

  @override
  String contactsError(Object error) {
    return 'कॉन्टैक्ट त्रुटि: $error';
  }

  @override
  String get noName => '(कोई नाम नहीं)';

  @override
  String get newClientTitle => 'नया क्लाइंट';

  @override
  String get editClientTitle => 'क्लाइंट एडिट करें';

  @override
  String get clientInfoSection => 'क्लाइंट जानकारी';

  @override
  String get notesLabel => 'नोट्स';

  @override
  String get notesHint => 'नोट्स जोड़ें (वैकल्पिक)';

  @override
  String get clientCreateHint =>
      'टिप: तेज़ी से इनवॉइस भेजने के लिए ईमेल/फ़ोन जोड़ें।';

  @override
  String get clientEditHint => 'आप कभी भी क्लाइंट जानकारी अपडेट कर सकते हैं।';

  @override
  String errorSavingClient(Object error) {
    return 'क्लाइंट सेव करने में त्रुटि: $error';
  }

  @override
  String get clientsTitle => 'क्लाइंट्स';

  @override
  String get searchClientsLabel => 'क्लाइंट खोजें';

  @override
  String clientsCount(Object count) {
    return '$count क्लाइंट';
  }

  @override
  String get noClientsYet => 'अभी कोई क्लाइंट नहीं।';

  @override
  String get noClientsForSearch => 'आपकी खोज से कोई क्लाइंट मेल नहीं खाता।';

  @override
  String get cannotOpenDialer => 'डायलर नहीं खुल सका';

  @override
  String get cannotOpenSms => 'SMS नहीं खुल सका';

  @override
  String get whatsAppNotAvailable => 'WhatsApp उपलब्ध नहीं';

  @override
  String get cannotOpenEmail => 'ईमेल नहीं खुल सका';

  @override
  String get deleteClientTitle => 'क्लाइंट हटाएं?';

  @override
  String deleteClientBody(Object name) {
    return '$name हटाएं?';
  }

  @override
  String get call => 'कॉल';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'ईमेल';

  @override
  String get shareAppTitle => 'EzInvoice आज़माएं 👇';

  @override
  String get shareAppBody =>
      'इनवॉइस बनाएं, PDFs भेजें, और रिपोर्ट्स आसानी से ट्रैक करें।';

  @override
  String get shareAppTooltip => 'ऐप शेयर करें';

  @override
  String get openGooglePlayTooltip => 'Google Play खोलें';

  @override
  String get openAppStoreTooltip => 'App Store खोलें';

  @override
  String get openWebsiteTooltip => 'वेबसाइट खोलें';

  @override
  String get availableLanguages => 'उपलब्ध भाषाएँ';

  @override
  String get usePhoneLanguage => 'फोन की भाषा उपयोग करें';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'रसीद $invoiceNumber — $clientName के लिए';
  }

  @override
  String get report => 'रिपोर्ट';

  @override
  String get invoicesLabel => 'इनवॉइस';

  @override
  String get totalSalesLabel => 'कुल सेल्स';

  @override
  String get totalTaxLabel => 'कुल टैक्स';

  @override
  String get totalTipLabel => 'कुल टिप';

  @override
  String get netLabel => 'नेट';

  @override
  String get sentLabel => 'सेंट';

  @override
  String get paidLabel => 'पेड';

  @override
  String get overdueLabel => 'ओवरड्यू';

  @override
  String get reportCalculatedHint => 'आपके इनवॉइस से गणना की गई।';

  @override
  String get exportPdfComingSoon => 'PDF एक्सपोर्ट (जल्द)';

  @override
  String get exportCsvComingSoon => 'CSV एक्सपोर्ट (जल्द)';

  @override
  String get unsentLabel => 'अनसेंट';

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
  String get deleteAccountTitle => 'アカウントを削除';

  @override
  String get deleteAccountWarning => 'この操作を行うと、アカウントおよび関連するすべてのデータが完全に削除されます。';

  @override
  String get deleteAccountButton => 'アカウントを削除';

  @override
  String get deleteAccountConfirmTitle => '削除の確認';

  @override
  String get deleteAccountConfirmMessage => '本当に削除しますか？この操作は元に戻せません。';

  @override
  String get profileSaved => 'अपने आप सहेजा गया';

  @override
  String get profileSaveError =>
      'सहेजा नहीं जा सका। आपके बदलाव अभी यहाँ मौजूद हैं।';

  @override
  String get profileRetry => 'फिर कोशिश करें';

  @override
  String get profileAutosaveHint =>
      'बदलाव अपने आप सहेजे जाते हैं और बंद करने पर बने रहते हैं।';

  @override
  String get profileLogo => 'व्यवसाय का लोगो';

  @override
  String get profileDefaults => 'इनवॉइस के डिफ़ॉल्ट';

  @override
  String get profileTaxInvalid => 'कर दर जाँचें (0–100%)।';

  @override
  String get metricLoadError => 'रिपोर्ट लोड नहीं हो सकी। फिर कोशिश करें।';

  @override
  String get totalInvoicedTitle => 'कुल बिल राशि';
}
