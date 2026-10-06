// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'أنشئ حسابك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get processing => 'جارٍ المعالجة...';

  @override
  String get invalidCredentials =>
      'أدخل بريدًا إلكترونيًا صحيحًا وكلمة مرور (6+ أحرف)';

  @override
  String get authError => 'خطأ في المصادقة';

  @override
  String get home => 'الرئيسية';

  @override
  String get clients => 'العملاء';

  @override
  String get invoices => 'الفواتير';

  @override
  String get reports => 'التقارير';

  @override
  String get settings => 'الإعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get business => 'النشاط التجاري';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageDescription => 'اختر لغة التطبيق.';

  @override
  String get systemDefault => 'لغة النظام';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'مرحبًا $name,\nأرسل لك فاتورتك من EzInvoice. ✅';
  }

  @override
  String get invoiceEmailSubject => 'فاتورة - EzInvoice';

  @override
  String get dashboardTitle => 'لوحة التحكم';

  @override
  String get monthWord => 'الشهر';

  @override
  String get planLabel => 'الخطة';

  @override
  String get invoicesRemaining => 'الفواتير المتبقية';

  @override
  String get proUnlimitedLabel => 'PRO · غير محدود';

  @override
  String get createNewInvoice => 'إنشاء فاتورة جديدة';

  @override
  String get limitReachedSubtitle => 'تم الوصول للحد • قم بالترقية إلى Pro';

  @override
  String get createInvoiceFastSubtitle => 'أنشئ فاتورة + PDF خلال ثوانٍ';

  @override
  String get limitReachedTitle => 'تم الوصول للحد';

  @override
  String get limitReachedBody =>
      'قم بالترقية إلى Pro لفواتير غير محدودة وإزالة الإعلانات.';

  @override
  String get upgrade => 'ترقية';

  @override
  String get monthSummaryTitle => 'ملخص الشهر';

  @override
  String get salesTitle => 'المبيعات';

  @override
  String get tipTitle => 'الإكرامية';

  @override
  String get subtotalTitle => 'المجموع الفرعي';

  @override
  String get taxTitle => 'الضريبة';

  @override
  String get beforeTaxTip => 'قبل الضريبة/الإكرامية';

  @override
  String get collectedThisMonth => 'المحصّل هذا الشهر';

  @override
  String get quickAccessTitle => 'وصول سريع';

  @override
  String get clientsManageSubtitle => 'إنشاء / تعديل العملاء';

  @override
  String get invoicesViewSendSubtitle => 'عرض وإرسال PDF';

  @override
  String get monthlyYearlySubtitle => 'شهري / سنوي';

  @override
  String get businessProfileSubtitle => 'الملف / الشعار / الضريبة';

  @override
  String invoiceCount(Object count) {
    return '$count فاتورة';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'إغلاق';

  @override
  String get paywallHeaderTitle => 'افتح كل شيء لعملك';

  @override
  String get paywallHeaderSubtitle =>
      'بدون إعلانات • فواتير غير محدودة • تقارير ضرائب • قوالب مميزة';

  @override
  String get bestValue => 'أفضل قيمة';

  @override
  String get proYearly => 'Pro سنوي';

  @override
  String get saveMoreYearly => 'وفّر أكثر بالدفع سنويًا';

  @override
  String get proMonthly => 'Pro شهري';

  @override
  String get flexible => 'مرن';

  @override
  String get cancelAnytime => 'إلغاء في أي وقت';

  @override
  String get processingPurchase => 'جارٍ معالجة الشراء…';

  @override
  String get restoringPurchases => 'جارٍ استعادة المشتريات…';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get continueFreeWithAds => 'المتابعة بالنسخة المجانية مع الإعلانات';

  @override
  String get alreadyProTitle => 'أنت Pro ✅';

  @override
  String get alreadyProBody =>
      'استمتع بفواتير غير محدودة، تقارير، وبدون إعلانات.';

  @override
  String get continueText => 'متابعة';

  @override
  String get includesInPro => 'يتضمن Pro';

  @override
  String get benefitNoAds => 'بدون إعلانات (Banner/Interstitial/Rewarded)';

  @override
  String get benefitUnlimitedInvoices =>
      'فواتير غير محدودة + حالات (مسودة/مرسلة/مدفوعة)';

  @override
  String get benefitPremiumTemplates => 'قوالب مميزة + ألوان + شعار النشاط';

  @override
  String get benefitNoWatermarkPdf => 'PDF احترافي بدون علامة مائية';

  @override
  String get benefitTaxReports =>
      'تقارير ضرائب: شهري وسنوي (ضرائب/إكرامية/صافي)';

  @override
  String get benefitExport => 'تصدير PDF/CSV/Excel (للمحاسبة)';

  @override
  String get benefitCloudBackup => 'نسخ احتياطي سحابي + استعادة (أجهزة متعددة)';

  @override
  String continueWithPlan(Object plan) {
    return 'متابعة مع $plan';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'بالاشتراك، سيتم خصم الدفع من حساب $store الخاص بك. يتجدد الاشتراك تلقائيًا ما لم تقم بالإلغاء قبل 24 ساعة على الأقل من نهاية الفترة الحالية. يمكنك إدارة اشتراكك أو إلغاؤه من إعدادات المتجر.';
  }

  @override
  String get reportsTitle => 'التقارير';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'حسب الشهر';

  @override
  String get byYear => 'حسب السنة';

  @override
  String get monthLabel => 'الشهر';

  @override
  String get yearLabel => 'السنة';

  @override
  String get businessProfileTitle => 'ملف النشاط';

  @override
  String get save => 'حفظ';

  @override
  String get uploadLogo => 'رفع الشعار';

  @override
  String get remove => 'إزالة';

  @override
  String get businessNameLabel => 'اسم النشاط';

  @override
  String get ownerNameLabel => 'المالك / اسم جهة الاتصال';

  @override
  String get phoneLabel => 'الهاتف';

  @override
  String get addressLabel => 'العنوان';

  @override
  String get currencyLabel => 'العملة';

  @override
  String get taxDefaultLabel => 'الضريبة الافتراضية (%)';

  @override
  String get invalidNumber => 'رقم غير صالح';

  @override
  String get range0to100 => 'يجب أن يكون بين 0 و 100';

  @override
  String get requiredField => 'مطلوب';

  @override
  String get footerNoteLabel => 'ملاحظة التذييل (PDF)';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get businessFooterDefault => 'شكرًا لتعاملكم معنا.';

  @override
  String get businessSavedSuccess => 'تم حفظ ملف النشاط بنجاح';

  @override
  String get businessInfoSection => 'معلومات النشاط';

  @override
  String get settingsSection => 'الإعدادات';

  @override
  String get footerSection => 'ملاحظة التذييل (PDF)';

  @override
  String get upgradeToPro => 'ترقية إلى Pro';

  @override
  String get bestValueStar => '⭐ أفضل قيمة';

  @override
  String get invoicesTitle => 'الفواتير';

  @override
  String get noInvoicesYet => 'لا توجد فواتير بعد.';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'الخطة المجانية: حد شهري $limit فاتورة • ترقية لغير محدود';
  }

  @override
  String get filtersTitle => 'الفلاتر';

  @override
  String get clientLabel => 'العميل';

  @override
  String get allMonths => 'كل الأشهر';

  @override
  String get allClients => 'كل العملاء';

  @override
  String get clear => 'مسح';

  @override
  String get invoicesSummaryLabel => 'الفواتير';

  @override
  String get totalTitle => 'الإجمالي';

  @override
  String get dateLabel => 'التاريخ';

  @override
  String get noResultsForFilters => 'لا توجد نتائج للفلاتر المحددة.';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'الخطة المجانية: $current / $limit فواتير هذا الشهر.\n\nقم بالترقية إلى Pro لغير محدود.';
  }

  @override
  String get deleteInvoiceTitle => 'حذف الفاتورة؟';

  @override
  String deleteInvoiceBody(Object invNo) {
    return 'هل أنت متأكد أنك تريد حذف $invNo؟';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get sendPdf => 'إرسال PDF';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'فاتورة $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'خطأ في إنشاء/إرسال PDF: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'تقرير • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'تقرير • سنة $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'الفواتير: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'إجمالي المبيعات: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'إجمالي الضريبة: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'إجمالي الإكرامية: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'الصافي: \$$amount';
  }

  @override
  String get calculatedFromInvoices => 'تم الحساب من فواتيرك في Firestore.';

  @override
  String get noInvoicesInPeriod => 'لا توجد فواتير في هذه الفترة.';

  @override
  String get exportPdf => 'تصدير PDF';

  @override
  String get exportCsv => 'تصدير CSV';

  @override
  String get yearlyProReason => 'التقرير السنوي PRO. قم بالترقية لفتحه.';

  @override
  String get exportPdfProReason => 'تصدير PDF للتقرير هو PRO.';

  @override
  String get exportCsvProReason => 'تصدير CSV هو PRO.';

  @override
  String get noDataToExport => 'لا توجد بيانات للتصدير.';

  @override
  String get freePlanReportsNote =>
      'الخطة المجانية: تقارير شهرية فقط. قم بالترقية للتقارير السنوية والتصدير.';

  @override
  String get genericError => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get newInvoiceTitle => 'فاتورة جديدة';

  @override
  String get editInvoiceTitle => 'تعديل الفاتورة';

  @override
  String get pickClient => 'اختر عميلًا';

  @override
  String get invoiceAutoNumberLabel => 'رقم الفاتورة (تلقائي)';

  @override
  String invoiceDateLabel(Object date) {
    return 'تاريخ الفاتورة: $date';
  }

  @override
  String get clientNameLabel => 'اسم العميل';

  @override
  String get clientNameRequired => 'اسم العميل مطلوب';

  @override
  String get clientEmailOptionalLabel => 'بريد العميل (اختياري)';

  @override
  String get clientPhoneOptionalLabel => 'هاتف العميل (اختياري)';

  @override
  String get invalidEmailFormat => 'تنسيق بريد غير صالح';

  @override
  String get itemsTitle => 'العناصر';

  @override
  String get descriptionLabel => 'الوصف';

  @override
  String itemDateLabel(Object date) {
    return 'تاريخ العنصر: $date';
  }

  @override
  String get qtyLabel => 'الكمية';

  @override
  String get priceLabel => 'السعر';

  @override
  String lineTotalLabel(Object amount) {
    return 'إجمالي السطر: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'الضريبة % (افتراضي المالك)';

  @override
  String get tipPercentChip => 'إكرامية %';

  @override
  String get tipAmountChip => 'إكرامية \$';

  @override
  String get tipPercentLabel => 'نسبة الإكرامية (%)';

  @override
  String get tipAmountLabel => 'قيمة الإكرامية (\$)';

  @override
  String get messageOptionalLabel => 'رسالة (اختياري)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'المجموع الفرعي: \$$sub\nالضريبة: \$$tax\nالإكرامية: \$$tip\nالإجمالي: \$$total';
  }

  @override
  String get saving => 'جارٍ الحفظ…';

  @override
  String get saveInvoice => 'حفظ الفاتورة';

  @override
  String get updateInvoice => 'تحديث الفاتورة';

  @override
  String get addAtLeastOneItem => 'أضف عنصرًا واحدًا على الأقل';

  @override
  String errorSavingInvoice(Object error) {
    return 'خطأ في حفظ الفاتورة: $error';
  }

  @override
  String get savedTab => 'المحفوظة';

  @override
  String get contactsTab => 'جهات الاتصال';

  @override
  String get noSavedClients => 'لا توجد عملاء محفوظون';

  @override
  String get permissionDeniedContacts => 'تم رفض الإذن: جهات الاتصال';

  @override
  String get noContactsFound => 'لا توجد جهات اتصال على هذا الجهاز/المحاكي';

  @override
  String contactsError(Object error) {
    return 'خطأ جهات الاتصال: $error';
  }

  @override
  String get noName => '(بدون اسم)';

  @override
  String get newClientTitle => 'عميل جديد';

  @override
  String get editClientTitle => 'تعديل العميل';

  @override
  String get clientInfoSection => 'معلومات العميل';

  @override
  String get notesLabel => 'ملاحظات';

  @override
  String get notesHint => 'أضف ملاحظات (اختياري)';

  @override
  String get clientCreateHint =>
      'نصيحة: أضف البريد/الهاتف لإرسال الفواتير أسرع.';

  @override
  String get clientEditHint => 'يمكنك تحديث معلومات العميل في أي وقت.';

  @override
  String errorSavingClient(Object error) {
    return 'خطأ في حفظ العميل: $error';
  }

  @override
  String get clientsTitle => 'العملاء';

  @override
  String get searchClientsLabel => 'بحث عن العملاء';

  @override
  String clientsCount(Object count) {
    return '$count عميل';
  }

  @override
  String get noClientsYet => 'لا يوجد عملاء بعد.';

  @override
  String get noClientsForSearch => 'لا يوجد عملاء مطابقون للبحث.';

  @override
  String get cannotOpenDialer => 'لا يمكن فتح لوحة الاتصال';

  @override
  String get cannotOpenSms => 'لا يمكن فتح الرسائل';

  @override
  String get whatsAppNotAvailable => 'واتساب غير متاح';

  @override
  String get cannotOpenEmail => 'لا يمكن فتح البريد الإلكتروني';

  @override
  String get deleteClientTitle => 'حذف العميل؟';

  @override
  String deleteClientBody(Object name) {
    return 'إزالة $name؟';
  }

  @override
  String get call => 'اتصال';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'البريد';

  @override
  String get shareAppTitle => 'جرّب EzInvoice 👇';

  @override
  String get shareAppBody => 'أنشئ فواتير، أرسل PDFs، وتابع التقارير بسهولة.';

  @override
  String get shareAppTooltip => 'مشاركة التطبيق';

  @override
  String get openGooglePlayTooltip => 'فتح Google Play';

  @override
  String get openAppStoreTooltip => 'فتح App Store';

  @override
  String get openWebsiteTooltip => 'فتح الموقع';

  @override
  String get availableLanguages => 'اللغات المتاحة';

  @override
  String get usePhoneLanguage => 'استخدام لغة الهاتف';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'إيصال $invoiceNumber لـ $clientName';
  }

  @override
  String get report => 'تقرير';

  @override
  String get invoicesLabel => 'الفواتير';

  @override
  String get totalSalesLabel => 'إجمالي المبيعات';

  @override
  String get totalTaxLabel => 'إجمالي الضريبة';

  @override
  String get totalTipLabel => 'إجمالي الإكرامية';

  @override
  String get netLabel => 'الصافي';

  @override
  String get sentLabel => 'مرسلة';

  @override
  String get paidLabel => 'مدفوعة';

  @override
  String get overdueLabel => 'متأخرة';

  @override
  String get reportCalculatedHint => 'تم الحساب من فواتيرك.';

  @override
  String get exportPdfComingSoon => 'تصدير PDF (قريبًا)';

  @override
  String get exportCsvComingSoon => 'تصدير CSV (قريبًا)';

  @override
  String get unsentLabel => 'غير مرسلة';

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
  String get deleteAccountTitle => 'حذف الحساب';

  @override
  String get deleteAccountWarning =>
      'سيؤدي هذا الإجراء إلى حذف حسابك وجميع البيانات المرتبطة به نهائيًا.';

  @override
  String get deleteAccountButton => 'حذف الحساب';

  @override
  String get deleteAccountConfirmTitle => 'تأكيد الحذف';

  @override
  String get deleteAccountConfirmMessage =>
      'هل أنت متأكد؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get profileSaved => 'تم الحفظ تلقائيًا';

  @override
  String get profileSaveError => 'تعذر الحفظ. لا تزال تغييراتك موجودة هنا.';

  @override
  String get profileRetry => 'إعادة المحاولة';

  @override
  String get profileAutosaveHint =>
      'تُحفظ التغييرات تلقائيًا وتبقى عند الإغلاق.';

  @override
  String get profileLogo => 'شعار الشركة';

  @override
  String get profileDefaults => 'إعدادات الفاتورة الافتراضية';

  @override
  String get profileTaxInvalid => 'تحقق من الضريبة (0–100٪).';

  @override
  String get metricLoadError => 'تعذر تحميل التقرير. حاول مرة أخرى.';

  @override
  String get totalInvoicedTitle => 'إجمالي الفواتير';
}
