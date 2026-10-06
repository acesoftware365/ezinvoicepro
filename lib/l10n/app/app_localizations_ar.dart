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
  String get servicePresetsTitle => 'الخدمات المحفوظة';

  @override
  String get servicePresetsScreenTitle => 'الخدمات المحفوظة';

  @override
  String get servicePresetsAddNew => 'إضافة خدمة جديدة';

  @override
  String get servicePresetsHint => 'مثل: تنظيف، إصلاح، استشارة...';

  @override
  String get servicePresetsAddButton => 'إضافة';

  @override
  String get addServiceLabel => 'إضافة خدمة';

  @override
  String get yourPresets => 'خدماتك المحفوظة';

  @override
  String get noPresetsYet => 'لا توجد خدمات محفوظة بعد.';

  @override
  String get notNow => 'ليس الآن';

  @override
  String get openPaywallPlaceholder => 'فتح الاشتراكات';

  @override
  String get invoiceStyleTitle => 'نمط الفاتورة';

  @override
  String get invoiceFreeStyleHint =>
      'تستخدم الخطة المجانية نسخة فاتورة واحدة (Minimal). قم بالترقية إلى Pro لفتح جميع التخطيطات واللوحات.';

  @override
  String get invoicePaletteLabel => 'لوحة ألوان الفاتورة';

  @override
  String get invoiceLayoutLabel => 'تخطيط الفاتورة';

  @override
  String get saveInvoicePaletteError => 'تعذر حفظ لوحة ألوان الفاتورة.';

  @override
  String get saveInvoiceLayoutError => 'تعذر حفظ تخطيط الفاتورة.';

  @override
  String get reportStyleTitle => 'نمط التقرير';

  @override
  String get reportFreeStyleHint =>
      'تستخدم الخطة المجانية نسخة تقرير واحدة (Minimal). قم بالترقية إلى Pro لفتح جميع التخطيطات واللوحات.';

  @override
  String get reportPaletteLabel => 'لوحة ألوان التقرير';

  @override
  String get reportLayoutLabel => 'تخطيط التقرير';

  @override
  String get saveReportPaletteError => 'تعذر حفظ لوحة ألوان التقرير.';

  @override
  String get saveReportLayoutError => 'تعذر حفظ تخطيط التقرير.';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return 'نمط $docType: $style | اللوحة: $palette';
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

  @override
  String versionLabel(Object version) {
    return 'الإصدار $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get rememberEmail => 'تذكر بريدي الإلكتروني';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get passwordResetEnterEmail =>
      'أدخل بريدك الإلكتروني لإرسال رابط إعادة التعيين.';

  @override
  String get passwordResetSent =>
      'أرسلنا رسالة لإعادة تعيين كلمة المرور. تحقق من البريد العشوائي.';

  @override
  String get passwordResetNoAccount =>
      'لم يتم العثور على حساب بهذا البريد الإلكتروني.';

  @override
  String get invalidEmail => 'البريد الإلكتروني غير صالح.';

  @override
  String get passwordResetError =>
      'تعذر إرسال البريد الإلكتروني. حاول مرة أخرى.';

  @override
  String get updateRequired => 'التحديث مطلوب';

  @override
  String get updateRequiredBody =>
      'يتوفر إصدار جديد من Ez Invoice. للمتابعة، حدّث التطبيق من المتجر.';

  @override
  String get updateNow => 'حدّث الآن';

  @override
  String get open => 'فتح';

  @override
  String get share => 'مشاركة';

  @override
  String get actions => 'إجراءات';

  @override
  String get message => 'رسالة';

  @override
  String get done => 'تم';

  @override
  String get confirm => 'تأكيد';

  @override
  String get free => 'مجاني';

  @override
  String get clientInformation => 'معلومات العميل';

  @override
  String get clientName => 'اسم العميل';

  @override
  String get notesOptional => 'ملاحظات (اختياري)';

  @override
  String get saveClient => 'حفظ العميل';

  @override
  String get importFromContacts => 'استيراد من جهات الاتصال';

  @override
  String get importContactsDescription =>
      'املأ الاسم والهاتف والبريد الإلكتروني فورًا.';

  @override
  String get loadContacts => 'تحميل جهات الاتصال';

  @override
  String get clientPhone => 'هاتف العميل';

  @override
  String get searchContacts => 'البحث في جهات الاتصال';

  @override
  String get shareClient => 'مشاركة العميل';

  @override
  String get clientProfile => 'ملف العميل';

  @override
  String get chooseSavedService => 'اختر خدمة محفوظة';

  @override
  String get searchSavedServices => 'ابحث عن الخدمات المحفوظة';

  @override
  String get noSavedServicesFound => 'لم يتم العثور على خدمات محفوظة';

  @override
  String get noSavedServicesToUse =>
      'لا توجد خدمات محفوظة بعد. اكتب واحدة بالأعلى ثم احفظها لاحقًا.';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'محفوظ بالفعل: $service';
  }

  @override
  String savedService(Object service) {
    return 'تم حفظ الخدمة: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'تعذر حفظ الخدمة: $error';
  }

  @override
  String get saveServiceForLater => 'حفظ الخدمة لاحقًا';

  @override
  String get removeClient => 'إزالة العميل';

  @override
  String get service => 'خدمة';

  @override
  String get taxAndTip => 'الضريبة والإكرامية';

  @override
  String get totals => 'الإجماليات';

  @override
  String dueDate(Object date) {
    return 'تاريخ الاستحقاق: $date';
  }

  @override
  String paidDate(Object date) {
    return 'تاريخ الدفع: $date';
  }

  @override
  String get notPaidYet => 'لم يتم الدفع بعد';

  @override
  String paymentMethodWithValue(Object method) {
    return 'الطريقة: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'ملاحظة: $note';
  }

  @override
  String get markAsPaid => 'وضع علامة مدفوعة';

  @override
  String get markAsUnpaid => 'وضع علامة غير مدفوعة';

  @override
  String get editTax => 'تعديل';

  @override
  String get addClient => 'إضافة عميل';

  @override
  String get firstClientHint =>
      'أنشئ أول عميل لإعادة استخدامه في الفواتير القادمة.';

  @override
  String get searchSavedClients => 'ابحث عن العملاء المحفوظين';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get cash => 'نقدًا';

  @override
  String get card => 'بطاقة';

  @override
  String get check => 'شيك';

  @override
  String get other => 'أخرى';

  @override
  String get noteOptional => 'ملاحظة (اختياري)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'تعذر وضع علامة على الفاتورة كمدفوعة: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'تعذر وضع علامة على الفاتورة كغير مدفوعة: $error';
  }

  @override
  String deleteError(Object error) {
    return 'تعذر حذف الفاتورة: $error';
  }

  @override
  String get invoiceDeleted => 'تم حذف الفاتورة';

  @override
  String get invoiceMarkedSent => 'تم وضع علامة مرسلة ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'تعذر وضع علامة مرسلة: $error';
  }

  @override
  String get invoiceMarkedUnsent => 'تم وضع علامة غير مرسلة ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'تعذر وضع علامة غير مرسلة: $error';
  }

  @override
  String get invoiceMarkedPaid => 'تم وضع علامة مدفوعة ✅';

  @override
  String get invoiceMarkedUnpaid => 'تم وضع علامة غير مدفوعة ✅';

  @override
  String get invoiceLoadingError => 'تعذر تحميل الفواتير';

  @override
  String get tipType => 'نوع الإكرامية';

  @override
  String get amountOption => 'المبلغ (\$)';

  @override
  String get percentageOption => 'النسبة المئوية (%)';

  @override
  String get pdfPreview => 'معاينة PDF';

  @override
  String get openPdf => 'فتح PDF';

  @override
  String get sharePdf => 'مشاركة PDF';

  @override
  String get selectReportMonth => 'اختر شهر التقرير';

  @override
  String reportForBusiness(Object business) {
    return 'التقارير • $business';
  }

  @override
  String get tapToChangeMonth => 'اضغط لتغيير الشهر';

  @override
  String csvSaved(Object path) {
    return 'تم حفظ CSV: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'تعذر تصدير CSV: $error';
  }

  @override
  String get aboutTitle => 'حول';

  @override
  String get aboutTagline => 'فواتير واضحة للأعمال المتحركة';

  @override
  String get aboutAppTitle => 'التطبيق';

  @override
  String get aboutAppBody =>
      'يجمع EzInvoice الفواتير والعملاء والمدفوعات والتقارير في سير عمل بسيط لتعرف ما يهمك وتحصل على مستحقاتك بثقة.';

  @override
  String get aboutCompanyTitle => 'الشركة';

  @override
  String get aboutCompanyBody =>
      'تنشئ Liisgo LLC أدوات عملية تساعد الشركات الصغيرة على العمل بتنظيم ووضوح وثقة أكبر.';

  @override
  String get aboutPromiseTitle => 'مصمم ليومك اليومي';

  @override
  String get aboutPromiseBody =>
      'يهدف كل قرار في EzInvoice إلى تقليل الخطوات وإبقاء التفاصيل ظاهرة وجعل إدارة عملك أسهل.';

  @override
  String get visitLiisgo => 'زيارة Liisgo';

  @override
  String get contactSupport => 'اتصل بالدعم';

  @override
  String get shareEzInvoice => 'مشاركة EzInvoice';

  @override
  String get sendIdeaOrBug => 'إرسال فكرة أو مشكلة';

  @override
  String get feedbackTitle => 'رأيك مهم';

  @override
  String get feedbackSubtitle => 'أخبرنا بما تريد تحسينه أو بما لم يعمل جيدًا.';

  @override
  String get feedbackIdea => 'فكرة';

  @override
  String get feedbackBug => 'مشكلة';

  @override
  String get feedbackHint => 'اكتب فكرتك أو اشرح ما حدث…';

  @override
  String get feedbackRequired => 'اكتب رسالة قبل الإرسال.';

  @override
  String get continueToEmail => 'المتابعة إلى البريد الإلكتروني';

  @override
  String get couldNotOpenLink => 'تعذر فتح هذا الرابط.';

  @override
  String shareAppText(Object storeUrl) {
    return 'تعرّف على EzInvoice Pro: الفواتير والعملاء والتقارير في مكان واحد.\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return '$kind لـ EzInvoice';
  }

  @override
  String get supportEmailSubject => 'دعم EzInvoice';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changePasswordSubtitle => 'حدّث كلمة مرور حسابك.';

  @override
  String get confirmCurrentPasswordHint =>
      'لأمانك، أكد كلمة المرور الحالية أولًا.';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get updatePassword => 'تحديث كلمة المرور';

  @override
  String get passwordAtLeastSix => 'يجب أن تحتوي على 6 أحرف على الأقل.';

  @override
  String get noActiveSession => 'لا توجد جلسة نشطة.';

  @override
  String get passwordsDoNotMatch => 'كلمة المرور الجديدة غير متطابقة.';

  @override
  String get passwordMustDiffer => 'يجب أن تكون كلمة المرور الجديدة مختلفة.';

  @override
  String get passwordUpdated => 'تم تحديث كلمة المرور بنجاح.';

  @override
  String get incorrectPassword => 'كلمة المرور الحالية غير صحيحة.';

  @override
  String get weakPassword => 'كلمة المرور الجديدة ضعيفة جدًا.';

  @override
  String get reauthenticationNeeded =>
      'لأمانك، سجّل الدخول مرة أخرى ثم حاول مجددًا.';

  @override
  String get changePasswordError => 'تعذر تغيير كلمة المرور.';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get reauthCancelled => 'تم إلغاء إعادة التحقق.';

  @override
  String get accountDeleted => 'تم حذف حسابك وبياناتك نهائيًا.';

  @override
  String get deleteAccountIncorrectPassword => 'كلمة المرور غير صحيحة.';

  @override
  String get deleteAccountError => 'تعذر حذف الحساب.';

  @override
  String get deleteAccountBody =>
      'إذا حذفت حسابك:\n\n• سيتم حذف عملائك وفواتيرك وتقاريرك وملف نشاطك نهائيًا.\n• لا يمكن التراجع عن هذا الإجراء.\n• إذا كان لديك اشتراك نشط، فأدره أو ألغِه من App Store أو Google Play.';

  @override
  String get termsConditions => 'الشروط والأحكام';

  @override
  String get agreeTermsPrivacy =>
      'يرجى الموافقة أولًا على الشروط والأحكام وسياسة الخصوصية.';

  @override
  String get currentPlan => 'الخطة الحالية';

  @override
  String get currentPlanFree => 'الخطة الحالية: مجانية';

  @override
  String get proPlanDescription =>
      'تتضمن الخطة المجانية إعلانات واستخدامًا محدودًا. يزيل Pro الإعلانات ويفتح فواتير غير محدودة وتقارير وقوالب مميزة وتصديرًا ونسخًا احتياطيًا سحابيًا.';

  @override
  String get adsIncluded => 'يتضمن إعلانات';

  @override
  String get limitedInvoicesPerMonth => 'فواتير محدودة كل شهر';

  @override
  String get basicInvoiceStyle => 'نمط فاتورة أساسي';

  @override
  String get basicReports => 'تقارير أساسية';

  @override
  String get pdfIncludesBranding => 'يتضمن PDF علامة EzInvoice';

  @override
  String get unpaidLabel => 'غير مدفوعة';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get store => 'المتجر';

  @override
  String get storeProductLoadingOne =>
      'لا يزال أحد منتجات الاشتراك قيد التحميل. يمكنك المتابعة بالخطة المتاحة أثناء تحميل المنتج الآخر.';

  @override
  String get storeProductsLoading =>
      'جارٍ الاتصال بمنتجات الاشتراك في المتجر. إذا لم يكتمل التحميل، فتأكد من جاهزية الاشتراكات في لوحة المتجر.';

  @override
  String get agreeTo => 'أوافق على ';

  @override
  String get and => ' و';

  @override
  String get currentProPlanDescription =>
      'لديك بالفعل Ez Invoice Pro. يمكنك مراجعة خياري الاشتراك أدناه.';

  @override
  String freeVsPro(Object pro) {
    return 'المجاني مقابل $pro';
  }

  @override
  String get openInvoices => 'افتح الفواتير.';

  @override
  String get allCaughtUp => 'كل شيء محدث';

  @override
  String itemsToReview(Object count) {
    return '$count للمراجعة';
  }

  @override
  String get pdfInvoice => 'فاتورة';

  @override
  String get pdfReceipt => 'إيصال';

  @override
  String get pdfBusiness => 'النشاط التجاري';

  @override
  String get pdfPhone => 'الهاتف';

  @override
  String get pdfEmail => 'البريد الإلكتروني';

  @override
  String get pdfNumber => 'رقم';

  @override
  String get pdfDate => 'التاريخ';

  @override
  String get pdfDue => 'الاستحقاق';

  @override
  String get pdfPaid => 'مدفوعة';

  @override
  String get pdfPaidDate => 'تاريخ الدفع';

  @override
  String get pdfMethod => 'الطريقة';

  @override
  String get pdfBillTo => 'الفاتورة إلى';

  @override
  String get pdfClient => 'العميل';

  @override
  String get pdfDescription => 'الوصف';

  @override
  String get pdfQuantity => 'الكمية';

  @override
  String get pdfPrice => 'السعر';

  @override
  String get pdfSubtotal => 'المجموع الفرعي';

  @override
  String get pdfTax => 'الضريبة';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'الضريبة ($rate%)';
  }

  @override
  String get pdfTip => 'إكرامية';

  @override
  String pdfTipWithRate(Object rate) {
    return 'إكرامية ($rate%)';
  }

  @override
  String get pdfDiscount => 'خصم';

  @override
  String get pdfMessage => 'رسالة';

  @override
  String get pdfPaymentNote => 'ملاحظة الدفع';

  @override
  String get pdfThankYou => 'شكرًا لتعاملكم معنا.';

  @override
  String get pdfPoweredBy => 'مدعوم من EzInvoice';

  @override
  String get pdfFreeVersion => 'الإصدار المجاني';

  @override
  String get pdfTotal => 'الإجمالي';

  @override
  String get styleMinimal => 'بسيط';

  @override
  String get styleProfessional => 'احترافي';

  @override
  String get styleCorporate => 'مؤسسي';

  @override
  String get styleModern => 'حديث';

  @override
  String get styleSlate => 'أردوازي';

  @override
  String get reportDocument => 'تقرير';

  @override
  String get reportPrintDocument => 'طباعة التقرير';

  @override
  String get reportMonth => 'الشهر';

  @override
  String get reportYear => 'السنة';

  @override
  String get reportGeneratedOn => 'تم الإنشاء في';

  @override
  String get reportInvoices => 'الفواتير';

  @override
  String get reportStatus => 'الحالة';

  @override
  String get reportTotals => 'الإجماليات';

  @override
  String get reportSales => 'المبيعات';

  @override
  String get reportTotalTax => 'إجمالي الضريبة';

  @override
  String get reportTotalTip => 'إجمالي الإكراميات';

  @override
  String get reportTotalInvoiced => 'إجمالي المفوتر';

  @override
  String get reportUnsent => 'غير مرسلة';

  @override
  String get reportSent => 'مرسلة';

  @override
  String get reportPaid => 'مدفوعة';

  @override
  String get reportOverdue => 'متأخرة';

  @override
  String get reportInvoiceNumber => 'رقم الفاتورة';

  @override
  String get reportClient => 'العميل';

  @override
  String get reportDueDate => 'تاريخ الاستحقاق';

  @override
  String get reportDescription => 'الوصف';

  @override
  String get reportDate => 'التاريخ';

  @override
  String get reportFreeVersion => 'الإصدار المجاني';

  @override
  String get reportPoweredBy => 'مدعوم من EzInvoice';

  @override
  String reportPdfShareText(Object title) {
    return 'تقرير PDF: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'تقرير CSV: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'طباعة: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'تقرير_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'تقرير_سنة_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'تقرير | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'تقرير | $year';
  }

  @override
  String get reportBreakdown => 'التفاصيل';

  @override
  String get reportInvoicesStatus => 'حالة الفواتير';

  @override
  String get viewReport => 'عرض التقرير';

  @override
  String get reviewBeforeExport => 'راجع ملف PDF أو CSV قبل التصدير.';

  @override
  String get customizeReport => 'تخصيص التقرير';

  @override
  String get reportPreviewUpdates => 'تظهر التغييرات فورًا في المعاينة.';

  @override
  String get yourReportPreview => 'معاينة تقريرك';

  @override
  String get reportStyleLiveHint => 'غيّر التصميم وشاهده مباشرةً.';

  @override
  String get watchAdToExportReport =>
      'شاهد الإعلان كاملًا لتصدير هذا التقرير. رقِّ إلى Pro للتصدير من دون إعلانات.';

  @override
  String reportExportError(Object error) {
    return 'تعذر تصدير التقرير: $error';
  }

  @override
  String get shareCsvFile => 'مشاركة ملف CSV';

  @override
  String get shareCsvFileDescription =>
      'شارك مرفق .csv عبر البريد أو Drive أو تطبيق آخر.';

  @override
  String get shareReportAsText => 'مشاركة كنص (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription => 'أرسل ملخص التقرير كنص.';

  @override
  String get printCsv => 'طباعة CSV';

  @override
  String get printReportDescription => 'اطبع التقرير كجدول PDF.';

  @override
  String get reportPreview => 'معاينة';

  @override
  String get live => 'مباشر';

  @override
  String get proFeatureUnlimitedInvoices => 'فواتير غير محدودة';

  @override
  String get proFeatureRemovePdfBranding => 'إزالة علامة PDF';

  @override
  String get proFeatureExportCsv => 'تصدير CSV';

  @override
  String get proFeaturePremiumTemplates => 'قوالب مميزة';

  @override
  String get proFeatureDetailedTaxReport => 'تقرير ضريبي مفصل';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'تسمح الخطة المجانية بما يصل إلى $limit فاتورة شهريًا.';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'يزيل «مدعوم من EzInvoice» من ملفات PDF.';

  @override
  String get proFeatureExportCsvDescription => 'صدّر فواتيرك إلى CSV.';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'افتح قوالب الفواتير المميزة.';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'اعرض تقارير تفصيلية للضرائب.';

  @override
  String get pdfShareText => 'ملف PDF للفاتورة من EzInvoice';
}
