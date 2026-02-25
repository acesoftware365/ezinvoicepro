// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'Создайте аккаунт';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get login => 'Войти';

  @override
  String get register => 'Создать аккаунт';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get signIn => 'Войти';

  @override
  String get dontHaveAccount => 'Нет аккаунта?';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get processing => 'Обработка...';

  @override
  String get invalidCredentials =>
      'Введите корректный email и пароль (6+ символов)';

  @override
  String get authError => 'Ошибка аутентификации';

  @override
  String get home => 'Главная';

  @override
  String get clients => 'Клиенты';

  @override
  String get invoices => 'Счета';

  @override
  String get reports => 'Отчёты';

  @override
  String get settings => 'Настройки';

  @override
  String get logout => 'Выйти';

  @override
  String get business => 'Бизнес';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageDescription => 'Выберите язык приложения.';

  @override
  String get systemDefault => 'Язык системы';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'Привет, $name!\nОтправляю ваш счёт из EzInvoice. ✅';
  }

  @override
  String get invoiceEmailSubject => 'Счёт - EzInvoice';

  @override
  String get dashboardTitle => 'Панель';

  @override
  String get monthWord => 'Месяц';

  @override
  String get planLabel => 'Тариф';

  @override
  String get invoicesRemaining => 'Осталось счетов';

  @override
  String get proUnlimitedLabel => 'PRO · Безлимит';

  @override
  String get createNewInvoice => 'Создать новый счёт';

  @override
  String get limitReachedSubtitle => 'Лимит достигнут • Перейдите на Pro';

  @override
  String get createInvoiceFastSubtitle => 'Создайте счёт + PDF за секунды';

  @override
  String get limitReachedTitle => 'Лимит достигнут';

  @override
  String get limitReachedBody =>
      'Перейдите на Pro для безлимитных счетов и удаления рекламы.';

  @override
  String get upgrade => 'Перейти на Pro';

  @override
  String get monthSummaryTitle => 'Итоги месяца';

  @override
  String get salesTitle => 'Продажи';

  @override
  String get tipTitle => 'Чаевые';

  @override
  String get subtotalTitle => 'Подытог';

  @override
  String get taxTitle => 'Налог';

  @override
  String get beforeTaxTip => 'До налога/чаевых';

  @override
  String get collectedThisMonth => 'Собрано в этом месяце';

  @override
  String get quickAccessTitle => 'Быстрый доступ';

  @override
  String get clientsManageSubtitle => 'Создать / редактировать клиентов';

  @override
  String get invoicesViewSendSubtitle => 'Просмотр и отправка PDF';

  @override
  String get monthlyYearlySubtitle => 'Месячный / годовой';

  @override
  String get businessProfileSubtitle => 'Профиль / логотип / налог';

  @override
  String invoiceCount(Object count) {
    return '$count счёт(ов)';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'Закрыть';

  @override
  String get paywallHeaderTitle => 'Откройте всё для вашего бизнеса';

  @override
  String get paywallHeaderSubtitle =>
      'Без рекламы • Безлимитные счета • Налоговые отчёты • Премиум-шаблоны';

  @override
  String get bestValue => 'Лучшее предложение';

  @override
  String get proYearly => 'Pro на год';

  @override
  String get saveMoreYearly => 'Экономьте, оплачивая раз в год';

  @override
  String get proMonthly => 'Pro на месяц';

  @override
  String get flexible => 'Гибко';

  @override
  String get cancelAnytime => 'Отмена в любое время';

  @override
  String get processingPurchase => 'Обрабатываем покупку…';

  @override
  String get restoringPurchases => 'Восстанавливаем покупки…';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get continueFreeWithAds => 'Продолжить бесплатно с рекламой';

  @override
  String get alreadyProTitle => 'У вас Pro ✅';

  @override
  String get alreadyProBody =>
      'Наслаждайтесь безлимитными счетами, отчётами и без рекламы.';

  @override
  String get continueText => 'Продолжить';

  @override
  String get includesInPro => 'В Pro включено';

  @override
  String get benefitNoAds => 'Без рекламы (баннер/интерстициал/вознаграждение)';

  @override
  String get benefitUnlimitedInvoices =>
      'Безлимитные счета + статусы (черновик/отправлен/оплачен)';

  @override
  String get benefitPremiumTemplates =>
      'Премиум-шаблоны + цвета + логотип бизнеса';

  @override
  String get benefitNoWatermarkPdf => 'Профессиональный PDF без водяного знака';

  @override
  String get benefitTaxReports =>
      'Налоговые отчёты: месячные и годовые (налоги/чаевые/итого)';

  @override
  String get benefitExport => 'Экспорт PDF/CSV/Excel (для бухгалтерии)';

  @override
  String get benefitCloudBackup =>
      'Облачный бэкап + восстановление (несколько устройств)';

  @override
  String continueWithPlan(Object plan) {
    return 'Продолжить с $plan';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'При подписке оплата будет списана с вашего аккаунта $store. Подписка автоматически продлевается, если вы не отмените её минимум за 24 часа до окончания текущего периода. Управлять подпиской или отменить её можно в настройках магазина.';
  }

  @override
  String get reportsTitle => 'Отчёты';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'По месяцам';

  @override
  String get byYear => 'По годам';

  @override
  String get monthLabel => 'Месяц';

  @override
  String get yearLabel => 'Год';

  @override
  String get businessProfileTitle => 'Профиль бизнеса';

  @override
  String get save => 'Сохранить';

  @override
  String get uploadLogo => 'Загрузить логотип';

  @override
  String get remove => 'Удалить';

  @override
  String get businessNameLabel => 'Название бизнеса';

  @override
  String get ownerNameLabel => 'Владелец / контактное лицо';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get addressLabel => 'Адрес';

  @override
  String get currencyLabel => 'Валюта';

  @override
  String get taxDefaultLabel => 'Налог по умолчанию (%)';

  @override
  String get invalidNumber => 'Неверное число';

  @override
  String get range0to100 => 'Должно быть от 0 до 100';

  @override
  String get requiredField => 'Обязательно';

  @override
  String get footerNoteLabel => 'Примечание внизу (PDF)';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get businessFooterDefault => 'Спасибо за ваш бизнес.';

  @override
  String get businessSavedSuccess => 'Профиль бизнеса успешно сохранён';

  @override
  String get businessInfoSection => 'Информация о бизнесе';

  @override
  String get settingsSection => 'Настройки';

  @override
  String get footerSection => 'Примечание внизу (PDF)';

  @override
  String get upgradeToPro => 'Перейти на Pro';

  @override
  String get bestValueStar => '⭐ Лучшее предложение';

  @override
  String get invoicesTitle => 'Счета';

  @override
  String get noInvoicesYet => 'Пока нет счетов.';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'Бесплатный план: месячный лимит $limit счетов • Перейдите на безлимит';
  }

  @override
  String get filtersTitle => 'Фильтры';

  @override
  String get clientLabel => 'Клиент';

  @override
  String get allMonths => 'Все месяцы';

  @override
  String get allClients => 'Все клиенты';

  @override
  String get clear => 'Очистить';

  @override
  String get invoicesSummaryLabel => 'Счета';

  @override
  String get totalTitle => 'Итого';

  @override
  String get dateLabel => 'Дата';

  @override
  String get noResultsForFilters => 'Нет результатов для выбранных фильтров.';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'Бесплатный план: $current / $limit счетов в этом месяце.\n\nПерейдите на Pro для безлимита.';
  }

  @override
  String get deleteInvoiceTitle => 'Удалить счёт?';

  @override
  String deleteInvoiceBody(Object invNo) {
    return 'Вы уверены, что хотите удалить $invNo?';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Редактировать';

  @override
  String get sendPdf => 'Отправить PDF';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'Счёт $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'Ошибка создания/отправки PDF: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'Отчёт • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'Отчёт • Год $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'Счета: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'Общие продажи: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'Общий налог: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'Общие чаевые: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'Итого (net): \$$amount';
  }

  @override
  String get calculatedFromInvoices =>
      'Рассчитано на основе ваших счетов в Firestore.';

  @override
  String get noInvoicesInPeriod => 'В этом периоде нет счетов.';

  @override
  String get exportPdf => 'Экспорт PDF';

  @override
  String get exportCsv => 'Экспорт CSV';

  @override
  String get yearlyProReason =>
      'Годовой отчёт — PRO. Перейдите на Pro, чтобы открыть.';

  @override
  String get exportPdfProReason => 'Экспорт PDF отчёта — PRO.';

  @override
  String get exportCsvProReason => 'Экспорт CSV — PRO.';

  @override
  String get noDataToExport => 'Нет данных для экспорта.';

  @override
  String get freePlanReportsNote =>
      'Бесплатный план: только месячные отчёты. Перейдите на Pro для годовых отчётов и экспорта.';

  @override
  String get genericError => 'Что-то пошло не так. Попробуйте ещё раз.';

  @override
  String get newInvoiceTitle => 'Новый счёт';

  @override
  String get editInvoiceTitle => 'Редактировать счёт';

  @override
  String get pickClient => 'Выбрать клиента';

  @override
  String get invoiceAutoNumberLabel => 'Счёт # (авто)';

  @override
  String invoiceDateLabel(Object date) {
    return 'Дата счёта: $date';
  }

  @override
  String get clientNameLabel => 'Имя клиента';

  @override
  String get clientNameRequired => 'Имя клиента обязательно';

  @override
  String get clientEmailOptionalLabel => 'Email клиента (необязательно)';

  @override
  String get clientPhoneOptionalLabel => 'Телефон клиента (необязательно)';

  @override
  String get invalidEmailFormat => 'Неверный формат email';

  @override
  String get itemsTitle => 'Позиции';

  @override
  String get descriptionLabel => 'Описание';

  @override
  String itemDateLabel(Object date) {
    return 'Дата позиции: $date';
  }

  @override
  String get qtyLabel => 'Кол-во';

  @override
  String get priceLabel => 'Цена';

  @override
  String lineTotalLabel(Object amount) {
    return 'Итого по строке: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'Налог % (по умолчанию)';

  @override
  String get tipPercentChip => 'Чаевые %';

  @override
  String get tipAmountChip => 'Чаевые \$';

  @override
  String get tipPercentLabel => 'Процент чаевых (%)';

  @override
  String get tipAmountLabel => 'Сумма чаевых (\$)';

  @override
  String get messageOptionalLabel => 'Сообщение (необязательно)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'Подытог: \$$sub\nНалог: \$$tax\nЧаевые: \$$tip\nИтого: \$$total';
  }

  @override
  String get saving => 'Сохранение…';

  @override
  String get saveInvoice => 'Сохранить счёт';

  @override
  String get updateInvoice => 'Обновить счёт';

  @override
  String get addAtLeastOneItem => 'Добавьте минимум 1 позицию';

  @override
  String errorSavingInvoice(Object error) {
    return 'Ошибка сохранения счёта: $error';
  }

  @override
  String get savedTab => 'Сохранённые';

  @override
  String get contactsTab => 'Контакты';

  @override
  String get noSavedClients => 'Нет сохранённых клиентов';

  @override
  String get permissionDeniedContacts => 'Доступ к контактам запрещён';

  @override
  String get noContactsFound =>
      'Контакты не найдены на этом устройстве/эмуляторе';

  @override
  String contactsError(Object error) {
    return 'Ошибка контактов: $error';
  }

  @override
  String get noName => '(Без имени)';

  @override
  String get newClientTitle => 'Новый клиент';

  @override
  String get editClientTitle => 'Редактировать клиента';

  @override
  String get clientInfoSection => 'Информация о клиенте';

  @override
  String get notesLabel => 'Заметки';

  @override
  String get notesHint => 'Добавьте заметки (необязательно)';

  @override
  String get clientCreateHint =>
      'Совет: добавьте email/телефон, чтобы быстрее отправлять счета.';

  @override
  String get clientEditHint =>
      'Вы можете обновлять данные клиента в любое время.';

  @override
  String errorSavingClient(Object error) {
    return 'Ошибка сохранения клиента: $error';
  }

  @override
  String get clientsTitle => 'Клиенты';

  @override
  String get searchClientsLabel => 'Поиск клиентов';

  @override
  String clientsCount(Object count) {
    return '$count клиент(ов)';
  }

  @override
  String get noClientsYet => 'Пока нет клиентов.';

  @override
  String get noClientsForSearch => 'Нет клиентов, подходящих под поиск.';

  @override
  String get cannotOpenDialer => 'Не удалось открыть набор номера';

  @override
  String get cannotOpenSms => 'Не удалось открыть SMS';

  @override
  String get whatsAppNotAvailable => 'WhatsApp недоступен';

  @override
  String get cannotOpenEmail => 'Не удалось открыть email';

  @override
  String get deleteClientTitle => 'Удалить клиента?';

  @override
  String deleteClientBody(Object name) {
    return 'Удалить $name?';
  }

  @override
  String get call => 'Позвонить';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'Email';

  @override
  String get shareAppTitle => 'Попробуйте EzInvoice 👇';

  @override
  String get shareAppBody =>
      'Создавайте счета, отправляйте PDF и легко отслеживайте отчёты.';

  @override
  String get shareAppTooltip => 'Поделиться приложением';

  @override
  String get openGooglePlayTooltip => 'Открыть Google Play';

  @override
  String get openAppStoreTooltip => 'Открыть App Store';

  @override
  String get openWebsiteTooltip => 'Открыть сайт';

  @override
  String get availableLanguages => 'Доступные языки';

  @override
  String get usePhoneLanguage => 'Использовать язык телефона';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'Квитанция $invoiceNumber для $clientName';
  }

  @override
  String get report => 'Отчёт';

  @override
  String get invoicesLabel => 'Счета';

  @override
  String get totalSalesLabel => 'Общие продажи';

  @override
  String get totalTaxLabel => 'Общий налог';

  @override
  String get totalTipLabel => 'Общие чаевые';

  @override
  String get netLabel => 'Net';

  @override
  String get sentLabel => 'Отправлено';

  @override
  String get paidLabel => 'Оплачено';

  @override
  String get overdueLabel => 'Просрочено';

  @override
  String get reportCalculatedHint =>
      'Рассчитано на основе ваших счетов в Firestore.';

  @override
  String get exportPdfComingSoon => 'Экспорт PDF (скоро)';

  @override
  String get exportCsvComingSoon => 'Экспорт CSV (скоро)';

  @override
  String get unsentLabel => 'Не отправлено';

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
  String get deleteAccountTitle => 'Удалить аккаунт';

  @override
  String get deleteAccountWarning =>
      'Это действие навсегда удалит ваш аккаунт и все связанные данные.';

  @override
  String get deleteAccountButton => 'Удалить аккаунт';

  @override
  String get deleteAccountConfirmTitle => 'Подтвердить удаление';

  @override
  String get deleteAccountConfirmMessage =>
      'Вы уверены? Это действие нельзя отменить.';
}
