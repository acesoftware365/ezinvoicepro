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
  String get servicePresetsTitle => 'सहेजी गई सेवाएँ';

  @override
  String get servicePresetsScreenTitle => 'सहेजी गई सेवाएँ';

  @override
  String get servicePresetsAddNew => 'नई सेवा जोड़ें';

  @override
  String get servicePresetsHint => 'जैसे सफाई, मरम्मत, परामर्श...';

  @override
  String get servicePresetsAddButton => 'जोड़ें';

  @override
  String get addServiceLabel => 'सेवा जोड़ें';

  @override
  String get yourPresets => 'आपकी सहेजी गई सेवाएँ';

  @override
  String get noPresetsYet => 'अभी कोई सहेजी गई सेवा नहीं है।';

  @override
  String get notNow => 'अभी नहीं';

  @override
  String get openPaywallPlaceholder => 'सदस्यताएँ खोलें';

  @override
  String get invoiceStyleTitle => 'इनवॉइस शैली';

  @override
  String get invoiceFreeStyleHint =>
      'मुफ्त योजना में एक इनवॉइस संस्करण (Minimal) है। सभी लेआउट और पैलेट खोलने के लिए Pro में अपग्रेड करें।';

  @override
  String get invoicePaletteLabel => 'इनवॉइस पैलेट';

  @override
  String get invoiceLayoutLabel => 'इनवॉइस लेआउट';

  @override
  String get saveInvoicePaletteError => 'इनवॉइस पैलेट सहेजा नहीं जा सका।';

  @override
  String get saveInvoiceLayoutError => 'इनवॉइस लेआउट सहेजा नहीं जा सका।';

  @override
  String get reportStyleTitle => 'रिपोर्ट शैली';

  @override
  String get reportFreeStyleHint =>
      'मुफ्त योजना में एक रिपोर्ट संस्करण (Minimal) है। सभी लेआउट और पैलेट खोलने के लिए Pro में अपग्रेड करें।';

  @override
  String get reportPaletteLabel => 'रिपोर्ट पैलेट';

  @override
  String get reportLayoutLabel => 'रिपोर्ट लेआउट';

  @override
  String get saveReportPaletteError => 'रिपोर्ट पैलेट सहेजा नहीं जा सका।';

  @override
  String get saveReportLayoutError => 'रिपोर्ट लेआउट सहेजा नहीं जा सका।';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return '$docType शैली: $style | पैलेट: $palette';
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

  @override
  String versionLabel(Object version) {
    return 'संस्करण $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get rememberEmail => 'मेरा ईमेल याद रखें';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get passwordResetEnterEmail =>
      'रीसेट लिंक भेजने के लिए अपना ईमेल दर्ज करें।';

  @override
  String get passwordResetSent =>
      'हमने पासवर्ड रीसेट करने के लिए ईमेल भेजा है। स्पैम या जंक फ़ोल्डर देखें।';

  @override
  String get passwordResetNoAccount => 'इस ईमेल के लिए कोई खाता नहीं मिला।';

  @override
  String get invalidEmail => 'अमान्य ईमेल।';

  @override
  String get passwordResetError => 'ईमेल भेजा नहीं जा सका। फिर से प्रयास करें।';

  @override
  String get updateRequired => 'अपडेट आवश्यक है';

  @override
  String get updateRequiredBody =>
      'Ez Invoice का नया संस्करण उपलब्ध है। जारी रखने के लिए स्टोर से ऐप अपडेट करें।';

  @override
  String get updateNow => 'अभी अपडेट करें';

  @override
  String get open => 'खोलें';

  @override
  String get share => 'साझा करें';

  @override
  String get actions => 'क्रियाएं';

  @override
  String get message => 'संदेश';

  @override
  String get done => 'हो गया';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get free => 'मुफ़्त';

  @override
  String get clientInformation => 'ग्राहक जानकारी';

  @override
  String get clientName => 'ग्राहक का नाम';

  @override
  String get notesOptional => 'नोट्स (वैकल्पिक)';

  @override
  String get saveClient => 'ग्राहक सहेजें';

  @override
  String get importFromContacts => 'संपर्कों से आयात करें';

  @override
  String get importContactsDescription => 'नाम, फोन और ईमेल तुरंत भरें।';

  @override
  String get loadContacts => 'संपर्क लोड करें';

  @override
  String get clientPhone => 'ग्राहक का फ़ोन';

  @override
  String get searchContacts => 'संपर्क खोजें';

  @override
  String get shareClient => 'ग्राहक साझा करें';

  @override
  String get clientProfile => 'ग्राहक प्रोफ़ाइल';

  @override
  String get chooseSavedService => 'सहेजी गई सेवा चुनें';

  @override
  String get searchSavedServices => 'सहेजी गई सेवाएं खोजें';

  @override
  String get noSavedServicesFound => 'कोई सहेजी गई सेवा नहीं मिली';

  @override
  String get noSavedServicesToUse =>
      'अभी कोई सहेजी गई सेवा नहीं है। ऊपर एक लिखें और बाद के लिए सहेजें।';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'पहले से सहेजा गया: $service';
  }

  @override
  String savedService(Object service) {
    return 'सेवा सहेजी गई: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'सेवा सहेजी नहीं जा सकी: $error';
  }

  @override
  String get saveServiceForLater => 'सेवा को बाद के लिए सहेजें';

  @override
  String get removeClient => 'ग्राहक हटाएं';

  @override
  String get service => 'सेवा';

  @override
  String get taxAndTip => 'कर और टिप';

  @override
  String get totals => 'योग';

  @override
  String dueDate(Object date) {
    return 'देय तिथि: $date';
  }

  @override
  String paidDate(Object date) {
    return 'भुगतान तिथि: $date';
  }

  @override
  String get notPaidYet => 'अभी भुगतान नहीं हुआ';

  @override
  String paymentMethodWithValue(Object method) {
    return 'तरीका: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'नोट: $note';
  }

  @override
  String get markAsPaid => 'भुगतान के रूप में चिह्नित करें';

  @override
  String get markAsUnpaid => 'अवैतनिक के रूप में चिह्नित करें';

  @override
  String get editTax => 'संपादित करें';

  @override
  String get addClient => 'ग्राहक जोड़ें';

  @override
  String get firstClientHint =>
      'भविष्य के चालानों में उपयोग के लिए अपना पहला ग्राहक बनाएं।';

  @override
  String get searchSavedClients => 'सहेजे गए ग्राहक खोजें';

  @override
  String get paymentMethod => 'भुगतान का तरीका';

  @override
  String get cash => 'नकद';

  @override
  String get card => 'कार्ड';

  @override
  String get check => 'चेक';

  @override
  String get other => 'अन्य';

  @override
  String get noteOptional => 'नोट (वैकल्पिक)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'चालान को भुगतान के रूप में चिह्नित नहीं किया जा सका: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'चालान को अवैतनिक के रूप में चिह्नित नहीं किया जा सका: $error';
  }

  @override
  String deleteError(Object error) {
    return 'चालान हटाया नहीं जा सका: $error';
  }

  @override
  String get invoiceDeleted => 'चालान हटा दिया गया';

  @override
  String get invoiceMarkedSent => 'भेजा गया के रूप में चिह्नित ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'भेजा गया के रूप में चिह्नित नहीं किया जा सका: $error';
  }

  @override
  String get invoiceMarkedUnsent => 'न भेजे गए के रूप में चिह्नित ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'न भेजे गए के रूप में चिह्नित नहीं किया जा सका: $error';
  }

  @override
  String get invoiceMarkedPaid => 'भुगतान के रूप में चिह्नित ✅';

  @override
  String get invoiceMarkedUnpaid => 'अवैतनिक के रूप में चिह्नित ✅';

  @override
  String get invoiceLoadingError => 'चालान लोड नहीं किए जा सके';

  @override
  String get tipType => 'टिप का प्रकार';

  @override
  String get amountOption => 'राशि (\$)';

  @override
  String get percentageOption => 'प्रतिशत (%)';

  @override
  String get pdfPreview => 'PDF पूर्वावलोकन';

  @override
  String get openPdf => 'PDF खोलें';

  @override
  String get sharePdf => 'PDF साझा करें';

  @override
  String get selectReportMonth => 'रिपोर्ट माह चुनें';

  @override
  String reportForBusiness(Object business) {
    return 'रिपोर्ट • $business';
  }

  @override
  String get tapToChangeMonth => 'महीना बदलने के लिए टैप करें';

  @override
  String csvSaved(Object path) {
    return 'CSV सहेजा गया: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'CSV निर्यात नहीं किया जा सका: $error';
  }

  @override
  String get aboutTitle => 'ऐप के बारे में';

  @override
  String get aboutTagline => 'गतिशील व्यवसायों के लिए स्पष्ट इनवॉइस';

  @override
  String get aboutAppTitle => 'ऐप';

  @override
  String get aboutAppBody =>
      'EzInvoice चालान, ग्राहक, भुगतान और रिपोर्ट को एक सरल प्रवाह में लाता है, ताकि आप महत्वपूर्ण चीजें देख सकें और आत्मविश्वास से भुगतान पा सकें।';

  @override
  String get aboutCompanyTitle => 'कंपनी';

  @override
  String get aboutCompanyBody =>
      'Liisgo LLC छोटे व्यवसायों को अधिक व्यवस्थित, स्पष्ट और आत्मविश्वास से काम करने में मदद करने वाले व्यावहारिक उपकरण बनाती है।';

  @override
  String get aboutPromiseTitle => 'आपके रोज़मर्रा के लिए बनाया गया';

  @override
  String get aboutPromiseBody =>
      'EzInvoice का हर निर्णय चरणों को कम करने, विवरणों को दिखाई देने और आपके व्यवसाय को चलाना आसान बनाने के लिए है।';

  @override
  String get visitLiisgo => 'Liisgo पर जाएँ';

  @override
  String get contactSupport => 'सहायता से संपर्क करें';

  @override
  String get shareEzInvoice => 'EzInvoice साझा करें';

  @override
  String get sendIdeaOrBug => 'विचार या बग भेजें';

  @override
  String get feedbackTitle => 'आपकी प्रतिक्रिया मायने रखती है';

  @override
  String get feedbackSubtitle =>
      'हमें बताएं कि आप क्या सुधारना चाहेंगे या क्या ठीक से काम नहीं किया।';

  @override
  String get feedbackIdea => 'विचार';

  @override
  String get feedbackBug => 'बग';

  @override
  String get feedbackHint => 'अपना विचार लिखें या बताएं कि क्या हुआ…';

  @override
  String get feedbackRequired => 'भेजने से पहले एक संदेश लिखें।';

  @override
  String get continueToEmail => 'ईमेल पर जारी रखें';

  @override
  String get couldNotOpenLink => 'यह लिंक नहीं खोला जा सका।';

  @override
  String shareAppText(Object storeUrl) {
    return 'EzInvoice Pro देखें: चालान, ग्राहक और रिपोर्ट एक ही जगह।\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return 'EzInvoice के लिए $kind';
  }

  @override
  String get supportEmailSubject => 'EzInvoice सहायता';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get changePasswordSubtitle => 'अपने खाते का पासवर्ड अपडेट करें।';

  @override
  String get confirmCurrentPasswordHint =>
      'सुरक्षा के लिए पहले अपना वर्तमान पासवर्ड पुष्टि करें।';

  @override
  String get currentPassword => 'वर्तमान पासवर्ड';

  @override
  String get newPassword => 'नया पासवर्ड';

  @override
  String get confirmNewPassword => 'नए पासवर्ड की पुष्टि करें';

  @override
  String get updatePassword => 'पासवर्ड अपडेट करें';

  @override
  String get passwordAtLeastSix => 'कम से कम 6 वर्ण होने चाहिए।';

  @override
  String get noActiveSession => 'कोई सक्रिय सत्र नहीं है।';

  @override
  String get passwordsDoNotMatch => 'नया पासवर्ड मेल नहीं खाता।';

  @override
  String get passwordMustDiffer => 'नया पासवर्ड अलग होना चाहिए।';

  @override
  String get passwordUpdated => 'पासवर्ड सफलतापूर्वक अपडेट हो गया।';

  @override
  String get incorrectPassword => 'वर्तमान पासवर्ड गलत है।';

  @override
  String get weakPassword => 'नया पासवर्ड बहुत कमजोर है।';

  @override
  String get reauthenticationNeeded =>
      'सुरक्षा के लिए फिर से साइन इन करें और दोबारा प्रयास करें।';

  @override
  String get changePasswordError => 'पासवर्ड बदला नहीं जा सका।';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get reauthCancelled => 'पुनः प्रमाणीकरण रद्द कर दिया गया।';

  @override
  String get accountDeleted => 'आपका खाता और डेटा स्थायी रूप से हटा दिया गया।';

  @override
  String get deleteAccountIncorrectPassword => 'पासवर्ड गलत है।';

  @override
  String get deleteAccountError => 'खाता हटाया नहीं जा सका।';

  @override
  String get deleteAccountBody =>
      'यदि आप अपना खाता हटाते हैं:\n\n• आपके ग्राहक, चालान, रिपोर्ट और व्यावसायिक प्रोफ़ाइल स्थायी रूप से हटा दिए जाएंगे।\n• इस कार्रवाई को वापस नहीं किया जा सकता।\n• यदि आपकी सदस्यता सक्रिय है, तो उसे App Store/Google Play में प्रबंधित या रद्द करें।';

  @override
  String get termsConditions => 'नियम और शर्तें';

  @override
  String get agreeTermsPrivacy =>
      'कृपया पहले नियम और शर्तों तथा गोपनीयता नीति से सहमत हों।';

  @override
  String get currentPlan => 'वर्तमान योजना';

  @override
  String get currentPlanFree => 'वर्तमान योजना: मुफ़्त';

  @override
  String get proPlanDescription =>
      'मुफ़्त योजना में विज्ञापन और सीमित उपयोग शामिल है। Pro विज्ञापन हटाता है और असीमित चालान, रिपोर्ट, प्रीमियम टेम्पलेट, निर्यात और क्लाउड बैकअप खोलता है।';

  @override
  String get adsIncluded => 'विज्ञापन शामिल';

  @override
  String get limitedInvoicesPerMonth => 'हर महीने सीमित चालान';

  @override
  String get basicInvoiceStyle => 'मूल चालान शैली';

  @override
  String get basicReports => 'मूल रिपोर्ट';

  @override
  String get pdfIncludesBranding => 'PDF में EzInvoice ब्रांडिंग शामिल है';

  @override
  String get unpaidLabel => 'अवैतनिक';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get store => 'स्टोर';

  @override
  String get storeProductLoadingOne =>
      'एक सदस्यता उत्पाद अभी लोड हो रहा है। दूसरा उत्पाद लोड होने तक आप उपलब्ध योजना के साथ जारी रख सकते हैं।';

  @override
  String get storeProductsLoading =>
      'स्टोर सदस्यता उत्पादों से कनेक्ट किया जा रहा है। यदि लोडिंग पूरी नहीं होती, तो अपने स्टोर कंसोल में सदस्यताओं की तैयारी जांचें।';

  @override
  String get agreeTo => 'मैं सहमत हूं ';

  @override
  String get and => ' और ';

  @override
  String get currentProPlanDescription =>
      'आपके पास पहले से Ez Invoice Pro है। आप नीचे दोनों सदस्यता विकल्पों की समीक्षा कर सकते हैं।';

  @override
  String freeVsPro(Object pro) {
    return 'मुफ़्त बनाम $pro';
  }

  @override
  String get openInvoices => 'चालान खोलें।';

  @override
  String get allCaughtUp => 'सब ठीक है';

  @override
  String itemsToReview(Object count) {
    return '$count समीक्षा के लिए';
  }

  @override
  String get pdfInvoice => 'चालान';

  @override
  String get pdfReceipt => 'रसीद';

  @override
  String get pdfBusiness => 'व्यवसाय';

  @override
  String get pdfPhone => 'फ़ोन';

  @override
  String get pdfEmail => 'ईमेल';

  @override
  String get pdfNumber => 'संख्या';

  @override
  String get pdfDate => 'तारीख';

  @override
  String get pdfDue => 'देय';

  @override
  String get pdfPaid => 'भुगतान किया';

  @override
  String get pdfPaidDate => 'भुगतान तिथि';

  @override
  String get pdfMethod => 'तरीका';

  @override
  String get pdfBillTo => 'बिल भेजें';

  @override
  String get pdfClient => 'ग्राहक';

  @override
  String get pdfDescription => 'विवरण';

  @override
  String get pdfQuantity => 'मात्रा';

  @override
  String get pdfPrice => 'कीमत';

  @override
  String get pdfSubtotal => 'उप-योग';

  @override
  String get pdfTax => 'कर';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'कर ($rate%)';
  }

  @override
  String get pdfTip => 'टिप';

  @override
  String pdfTipWithRate(Object rate) {
    return 'टिप ($rate%)';
  }

  @override
  String get pdfDiscount => 'छूट';

  @override
  String get pdfMessage => 'संदेश';

  @override
  String get pdfPaymentNote => 'भुगतान नोट';

  @override
  String get pdfThankYou => 'आपके व्यवसाय के लिए धन्यवाद।';

  @override
  String get pdfPoweredBy => 'EzInvoice द्वारा संचालित';

  @override
  String get pdfFreeVersion => 'मुफ़्त संस्करण';

  @override
  String get pdfTotal => 'कुल';

  @override
  String get styleMinimal => 'न्यूनतम';

  @override
  String get styleProfessional => 'पेशेवर';

  @override
  String get styleCorporate => 'कॉर्पोरेट';

  @override
  String get styleModern => 'आधुनिक';

  @override
  String get styleSlate => 'स्लेट';

  @override
  String get reportDocument => 'रिपोर्ट';

  @override
  String get reportPrintDocument => 'रिपोर्ट प्रिंट करें';

  @override
  String get reportMonth => 'माह';

  @override
  String get reportYear => 'वर्ष';

  @override
  String get reportGeneratedOn => 'जनरेट किया गया';

  @override
  String get reportInvoices => 'इनवॉइस';

  @override
  String get reportStatus => 'स्थिति';

  @override
  String get reportTotals => 'कुल';

  @override
  String get reportSales => 'बिक्री';

  @override
  String get reportTotalTax => 'कुल कर';

  @override
  String get reportTotalTip => 'कुल टिप';

  @override
  String get reportTotalInvoiced => 'कुल इनवॉइस';

  @override
  String get reportUnsent => 'नहीं भेजा गया';

  @override
  String get reportSent => 'भेजा गया';

  @override
  String get reportPaid => 'भुगतान किया गया';

  @override
  String get reportOverdue => 'अतिदेय';

  @override
  String get reportInvoiceNumber => 'इनवॉइस नं.';

  @override
  String get reportClient => 'ग्राहक';

  @override
  String get reportDueDate => 'देय तिथि';

  @override
  String get reportDescription => 'विवरण';

  @override
  String get reportDate => 'तारीख';

  @override
  String get reportFreeVersion => 'मुफ्त संस्करण';

  @override
  String get reportPoweredBy => 'EzInvoice द्वारा संचालित';

  @override
  String reportPdfShareText(Object title) {
    return 'PDF रिपोर्ट: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'CSV रिपोर्ट: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'प्रिंट: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'रिपोर्ट_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'रिपोर्ट_वर्ष_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'रिपोर्ट | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'रिपोर्ट | $year';
  }

  @override
  String get reportBreakdown => 'विवरण';

  @override
  String get reportInvoicesStatus => 'इनवॉइस स्थिति';

  @override
  String get viewReport => 'रिपोर्ट देखें';

  @override
  String get reviewBeforeExport => 'निर्यात करने से पहले PDF या CSV देखें।';

  @override
  String get customizeReport => 'रिपोर्ट को अनुकूलित करें';

  @override
  String get reportPreviewUpdates => 'बदलाव आपकी झलक में तुरंत दिखाई देंगे।';

  @override
  String get yourReportPreview => 'आपकी रिपोर्ट की झलक';

  @override
  String get reportStyleLiveHint => 'डिज़ाइन बदलें और उसे लाइव देखें।';

  @override
  String get watchAdToExportReport =>
      'इस रिपोर्ट को निर्यात करने के लिए पूरा विज्ञापन देखें। बिना विज्ञापन निर्यात करने के लिए Pro में अपग्रेड करें।';

  @override
  String reportExportError(Object error) {
    return 'रिपोर्ट निर्यात नहीं की जा सकी: $error';
  }

  @override
  String get shareCsvFile => 'CSV फ़ाइल साझा करें';

  @override
  String get shareCsvFileDescription =>
      'ईमेल, Drive या किसी अन्य ऐप से .csv संलग्नक साझा करें।';

  @override
  String get shareReportAsText =>
      'टेक्स्ट के रूप में साझा करें (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription =>
      'रिपोर्ट सारांश टेक्स्ट के रूप में भेजें।';

  @override
  String get printCsv => 'CSV प्रिंट करें';

  @override
  String get printReportDescription =>
      'रिपोर्ट को PDF तालिका के रूप में प्रिंट करें।';

  @override
  String get reportPreview => 'पूर्वावलोकन';

  @override
  String get live => 'लाइव';

  @override
  String get proFeatureUnlimitedInvoices => 'असीमित इनवॉइस';

  @override
  String get proFeatureRemovePdfBranding => 'PDF ब्रांडिंग हटाएँ';

  @override
  String get proFeatureExportCsv => 'CSV निर्यात करें';

  @override
  String get proFeaturePremiumTemplates => 'प्रीमियम टेम्पलेट';

  @override
  String get proFeatureDetailedTaxReport => 'विस्तृत कर रिपोर्ट';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'मुफ्त योजना में प्रति माह $limit तक इनवॉइस की अनुमति है।';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'PDF से “Powered by EzInvoice” हटाता है।';

  @override
  String get proFeatureExportCsvDescription =>
      'अपने इनवॉइस CSV में निर्यात करें।';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'प्रीमियम इनवॉइस टेम्पलेट अनलॉक करें।';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'विस्तृत कर विवरण रिपोर्ट देखें।';

  @override
  String get pdfShareText => 'EzInvoice से इनवॉइस PDF';

  @override
  String get rewardedExportTitle => 'इस रिपोर्ट को निर्यात करें';

  @override
  String get watchAd => 'विज्ञापन देखें';

  @override
  String get rewardedAdCouldNotComplete =>
      'विज्ञापन पूरा नहीं हो सका। कृपया कुछ देर बाद फिर प्रयास करें।';
}
