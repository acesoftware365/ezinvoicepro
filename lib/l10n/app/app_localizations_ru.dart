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
  String get reportCalculatedHint => 'Рассчитано на основе ваших счетов.';

  @override
  String get exportPdfComingSoon => 'Экспорт PDF (скоро)';

  @override
  String get exportCsvComingSoon => 'Экспорт CSV (скоро)';

  @override
  String get unsentLabel => 'Не отправлено';

  @override
  String get servicePresetsTitle => 'Сохраненные услуги';

  @override
  String get servicePresetsScreenTitle => 'Сохраненные услуги';

  @override
  String get servicePresetsAddNew => 'Добавить новую услугу';

  @override
  String get servicePresetsHint => 'например, уборка, ремонт, консультация...';

  @override
  String get servicePresetsAddButton => 'Добавить';

  @override
  String get addServiceLabel => 'Добавить услугу';

  @override
  String get yourPresets => 'Ваши сохраненные услуги';

  @override
  String get noPresetsYet => 'Сохраненных услуг пока нет.';

  @override
  String get notNow => 'Не сейчас';

  @override
  String get openPaywallPlaceholder => 'Открыть подписки';

  @override
  String get invoiceStyleTitle => 'Стиль счета';

  @override
  String get invoiceFreeStyleHint =>
      'Бесплатный план использует одну версию счета (Minimal). Перейдите на Pro, чтобы открыть все макеты и палитры.';

  @override
  String get invoicePaletteLabel => 'Палитра счета';

  @override
  String get invoiceLayoutLabel => 'Макет счета';

  @override
  String get saveInvoicePaletteError => 'Не удалось сохранить палитру счета.';

  @override
  String get saveInvoiceLayoutError => 'Не удалось сохранить макет счета.';

  @override
  String get reportStyleTitle => 'Стиль отчета';

  @override
  String get reportFreeStyleHint =>
      'Бесплатный план использует одну версию отчета (Minimal). Перейдите на Pro, чтобы открыть все макеты и палитры.';

  @override
  String get reportPaletteLabel => 'Палитра отчета';

  @override
  String get reportLayoutLabel => 'Макет отчета';

  @override
  String get saveReportPaletteError => 'Не удалось сохранить палитру отчета.';

  @override
  String get saveReportLayoutError => 'Не удалось сохранить макет отчета.';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return 'Стиль $docType: $style | Палитра: $palette';
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

  @override
  String get profileSaved => 'Сохранено автоматически';

  @override
  String get profileSaveError =>
      'Не удалось сохранить. Изменения остаются здесь.';

  @override
  String get profileRetry => 'Повторить';

  @override
  String get profileAutosaveHint =>
      'Изменения сохраняются автоматически, в том числе при закрытии.';

  @override
  String get profileLogo => 'Логотип компании';

  @override
  String get profileDefaults => 'Настройки счёта';

  @override
  String get profileTaxInvalid => 'Проверьте налог (0–100 %).';

  @override
  String get metricLoadError =>
      'Не удалось загрузить отчёт. Повторите попытку.';

  @override
  String get totalInvoicedTitle => 'Всего выставлено';

  @override
  String versionLabel(Object version) {
    return 'Версия $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get rememberEmail => 'Запомнить мой e-mail';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get passwordResetEnterEmail =>
      'Введите e-mail, чтобы получить ссылку для сброса.';

  @override
  String get passwordResetSent =>
      'Мы отправили письмо для сброса пароля. Проверьте папку «Спам».';

  @override
  String get passwordResetNoAccount => 'Для этого e-mail не найден аккаунт.';

  @override
  String get invalidEmail => 'Недопустимый e-mail.';

  @override
  String get passwordResetError =>
      'Не удалось отправить e-mail. Попробуйте снова.';

  @override
  String get updateRequired => 'Требуется обновление';

  @override
  String get updateRequiredBody =>
      'Доступна новая версия Ez Invoice. Чтобы продолжить, обновите приложение в магазине.';

  @override
  String get updateNow => 'Обновить';

  @override
  String get open => 'Открыть';

  @override
  String get share => 'Поделиться';

  @override
  String get actions => 'Действия';

  @override
  String get message => 'Сообщение';

  @override
  String get done => 'Готово';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get free => 'БЕСПЛАТНО';

  @override
  String get clientInformation => 'Информация о клиенте';

  @override
  String get clientName => 'Имя клиента';

  @override
  String get notesOptional => 'Заметки (необязательно)';

  @override
  String get saveClient => 'Сохранить клиента';

  @override
  String get importFromContacts => 'Импортировать из контактов';

  @override
  String get importContactsDescription =>
      'Мгновенно заполните имя, телефон и e-mail.';

  @override
  String get loadContacts => 'Загрузить контакты';

  @override
  String get clientPhone => 'Телефон клиента';

  @override
  String get searchContacts => 'Поиск контактов';

  @override
  String get shareClient => 'Поделиться клиентом';

  @override
  String get clientProfile => 'Профиль клиента';

  @override
  String get chooseSavedService => 'Выбрать сохраненную услугу';

  @override
  String get searchSavedServices => 'Поиск сохраненных услуг';

  @override
  String get noSavedServicesFound => 'Сохраненные услуги не найдены';

  @override
  String get noSavedServicesToUse =>
      'Сохраненных услуг пока нет. Введите услугу выше и сохраните ее.';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'Уже сохранено: $service';
  }

  @override
  String savedService(Object service) {
    return 'Услуга сохранена: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'Не удалось сохранить услугу: $error';
  }

  @override
  String get saveServiceForLater => 'Сохранить услугу на потом';

  @override
  String get removeClient => 'Удалить клиента';

  @override
  String get service => 'Услуга';

  @override
  String get taxAndTip => 'Налог и чаевые';

  @override
  String get totals => 'Итоги';

  @override
  String dueDate(Object date) {
    return 'Срок оплаты: $date';
  }

  @override
  String paidDate(Object date) {
    return 'Дата оплаты: $date';
  }

  @override
  String get notPaidYet => 'Еще не оплачено';

  @override
  String paymentMethodWithValue(Object method) {
    return 'Способ: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'Примечание: $note';
  }

  @override
  String get markAsPaid => 'Отметить как оплаченную';

  @override
  String get markAsUnpaid => 'Отметить как неоплаченную';

  @override
  String get editTax => 'Изменить';

  @override
  String get addClient => 'Добавить клиента';

  @override
  String get firstClientHint =>
      'Создайте первого клиента, чтобы использовать его в будущих счетах.';

  @override
  String get searchSavedClients => 'Поиск сохраненных клиентов';

  @override
  String get paymentMethod => 'Способ оплаты';

  @override
  String get cash => 'Наличные';

  @override
  String get card => 'Карта';

  @override
  String get check => 'Чек';

  @override
  String get other => 'Другое';

  @override
  String get noteOptional => 'Примечание (необязательно)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'Не удалось отметить счет как оплаченный: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'Не удалось отметить счет как неоплаченный: $error';
  }

  @override
  String deleteError(Object error) {
    return 'Не удалось удалить счет: $error';
  }

  @override
  String get invoiceDeleted => 'Счет удален';

  @override
  String get invoiceMarkedSent => 'Отмечено как отправленное ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'Не удалось отметить как отправленный: $error';
  }

  @override
  String get invoiceMarkedUnsent => 'Отмечено как неотправленное ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'Не удалось отметить как неотправленный: $error';
  }

  @override
  String get invoiceMarkedPaid => 'Отмечено как оплаченное ✅';

  @override
  String get invoiceMarkedUnpaid => 'Отмечено как неоплаченное ✅';

  @override
  String get invoiceLoadingError => 'Не удалось загрузить счета';

  @override
  String get tipType => 'Тип чаевых';

  @override
  String get amountOption => 'Сумма (\$)';

  @override
  String get percentageOption => 'Процент (%)';

  @override
  String get pdfPreview => 'Предпросмотр PDF';

  @override
  String get openPdf => 'Открыть PDF';

  @override
  String get sharePdf => 'Поделиться PDF';

  @override
  String get selectReportMonth => 'Выберите месяц отчета';

  @override
  String reportForBusiness(Object business) {
    return 'Отчеты • $business';
  }

  @override
  String get tapToChangeMonth => 'Нажмите, чтобы изменить месяц';

  @override
  String csvSaved(Object path) {
    return 'CSV сохранен: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'Не удалось экспортировать CSV: $error';
  }

  @override
  String get aboutTitle => 'О приложении';

  @override
  String get aboutTagline => 'Понятные счета для динамичного бизнеса';

  @override
  String get aboutAppTitle => 'Приложение';

  @override
  String get aboutAppBody =>
      'EzInvoice объединяет счета, клиентов, платежи и отчеты в одном простом процессе, чтобы вы видели главное и уверенно получали оплату.';

  @override
  String get aboutCompanyTitle => 'Компания';

  @override
  String get aboutCompanyBody =>
      'Liisgo LLC создает практичные инструменты, которые помогают малому бизнесу работать организованнее, яснее и увереннее.';

  @override
  String get aboutPromiseTitle => 'Создано для вашего дня';

  @override
  String get aboutPromiseBody =>
      'Каждое решение в EzInvoice помогает сократить шаги, держать детали на виду и упростить управление бизнесом.';

  @override
  String get visitLiisgo => 'Посетить Liisgo';

  @override
  String get contactSupport => 'Связаться с поддержкой';

  @override
  String get shareEzInvoice => 'Поделиться EzInvoice';

  @override
  String get sendIdeaOrBug => 'Отправить идею или сообщение об ошибке';

  @override
  String get feedbackTitle => 'Ваше мнение важно';

  @override
  String get feedbackSubtitle =>
      'Расскажите, что вы хотели бы улучшить или что работало не так.';

  @override
  String get feedbackIdea => 'Идея';

  @override
  String get feedbackBug => 'Ошибка';

  @override
  String get feedbackHint => 'Опишите идею или расскажите, что произошло…';

  @override
  String get feedbackRequired => 'Напишите сообщение перед отправкой.';

  @override
  String get continueToEmail => 'Перейти к e-mail';

  @override
  String get couldNotOpenLink => 'Не удалось открыть эту ссылку.';

  @override
  String shareAppText(Object storeUrl) {
    return 'Познакомьтесь с EzInvoice Pro: счета, клиенты и отчеты в одном месте.\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return '$kind для EzInvoice';
  }

  @override
  String get supportEmailSubject => 'Поддержка EzInvoice';

  @override
  String get changePassword => 'Изменить пароль';

  @override
  String get changePasswordSubtitle => 'Обновите пароль вашего аккаунта.';

  @override
  String get confirmCurrentPasswordHint =>
      'Для безопасности сначала подтвердите текущий пароль.';

  @override
  String get currentPassword => 'Текущий пароль';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get confirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get updatePassword => 'Обновить пароль';

  @override
  String get passwordAtLeastSix => 'Должно быть не менее 6 символов.';

  @override
  String get noActiveSession => 'Нет активного сеанса.';

  @override
  String get passwordsDoNotMatch => 'Новый пароль не совпадает.';

  @override
  String get passwordMustDiffer => 'Новый пароль должен отличаться.';

  @override
  String get passwordUpdated => 'Пароль успешно обновлен.';

  @override
  String get incorrectPassword => 'Текущий пароль неверный.';

  @override
  String get weakPassword => 'Новый пароль слишком слабый.';

  @override
  String get reauthenticationNeeded =>
      'Для безопасности войдите снова и повторите попытку.';

  @override
  String get changePasswordError => 'Не удалось изменить пароль.';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get reauthCancelled => 'Повторная аутентификация отменена.';

  @override
  String get accountDeleted => 'Ваш аккаунт и данные удалены навсегда.';

  @override
  String get deleteAccountIncorrectPassword => 'Неверный пароль.';

  @override
  String get deleteAccountError => 'Не удалось удалить аккаунт.';

  @override
  String get deleteAccountBody =>
      'Если удалить аккаунт:\n\n• Ваши клиенты, счета, отчеты и профиль компании будут удалены навсегда.\n• Это действие нельзя отменить.\n• Если у вас есть активная подписка, управляйте или отмените ее в App Store/Google Play.';

  @override
  String get termsConditions => 'Условия использования';

  @override
  String get agreeTermsPrivacy =>
      'Сначала примите Условия использования и Политику конфиденциальности.';

  @override
  String get currentPlan => 'Текущий план';

  @override
  String get currentPlanFree => 'Текущий план: Бесплатный';

  @override
  String get proPlanDescription =>
      'Бесплатный тариф включает рекламу и ограничения. Pro убирает рекламу и открывает безлимитные счета, отчеты, премиум-шаблоны, экспорт и облачное резервное копирование.';

  @override
  String get adsIncluded => 'С рекламой';

  @override
  String get limitedInvoicesPerMonth => 'Ограниченное число счетов в месяц';

  @override
  String get basicInvoiceStyle => 'Базовый стиль счета';

  @override
  String get basicReports => 'Базовые отчеты';

  @override
  String get pdfIncludesBranding => 'PDF содержит брендинг EzInvoice';

  @override
  String get unpaidLabel => 'Не оплачено';

  @override
  String get loading => 'Загрузка...';

  @override
  String get store => 'Магазин';

  @override
  String get storeProductLoadingOne =>
      'Один продукт подписки еще загружается. Вы можете продолжить с доступным тарифом, пока загружается другой продукт.';

  @override
  String get storeProductsLoading =>
      'Подключение к продуктам подписки в магазине. Если загрузка не завершится, проверьте готовность подписок в консоли магазина.';

  @override
  String get agreeTo => 'Я принимаю ';

  @override
  String get and => ' и ';

  @override
  String get currentProPlanDescription =>
      'У вас уже есть Ez Invoice Pro. Ниже можно ознакомиться с обоими вариантами подписки.';

  @override
  String freeVsPro(Object pro) {
    return 'Бесплатный и $pro';
  }

  @override
  String get openInvoices => 'Откройте счета.';

  @override
  String get allCaughtUp => 'Все готово';

  @override
  String itemsToReview(Object count) {
    return '$count к проверке';
  }

  @override
  String get pdfInvoice => 'Счет';

  @override
  String get pdfReceipt => 'Квитанция';

  @override
  String get pdfBusiness => 'Компания';

  @override
  String get pdfPhone => 'Телефон';

  @override
  String get pdfEmail => 'E-mail';

  @override
  String get pdfNumber => '№';

  @override
  String get pdfDate => 'Дата';

  @override
  String get pdfDue => 'Срок';

  @override
  String get pdfPaid => 'Оплачено';

  @override
  String get pdfPaidDate => 'Дата оплаты';

  @override
  String get pdfMethod => 'Способ';

  @override
  String get pdfBillTo => 'Выставить счет';

  @override
  String get pdfClient => 'Клиент';

  @override
  String get pdfDescription => 'Описание';

  @override
  String get pdfQuantity => 'Кол-во';

  @override
  String get pdfPrice => 'Цена';

  @override
  String get pdfSubtotal => 'Промежуточный итог';

  @override
  String get pdfTax => 'Налог';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'Налог ($rate%)';
  }

  @override
  String get pdfTip => 'Чаевые';

  @override
  String pdfTipWithRate(Object rate) {
    return 'Чаевые ($rate%)';
  }

  @override
  String get pdfDiscount => 'Скидка';

  @override
  String get pdfMessage => 'Сообщение';

  @override
  String get pdfPaymentNote => 'Примечание к оплате';

  @override
  String get pdfThankYou => 'Спасибо за ваш заказ.';

  @override
  String get pdfPoweredBy => 'Работает на EzInvoice';

  @override
  String get pdfFreeVersion => 'БЕСПЛАТНАЯ ВЕРСИЯ';

  @override
  String get pdfTotal => 'Итого';

  @override
  String get styleMinimal => 'Минималистичный';

  @override
  String get styleProfessional => 'Профессиональный';

  @override
  String get styleCorporate => 'Корпоративный';

  @override
  String get styleModern => 'Современный';

  @override
  String get styleSlate => 'Сланцевый';

  @override
  String get reportDocument => 'Отчет';

  @override
  String get reportPrintDocument => 'Печать отчета';

  @override
  String get reportMonth => 'Месяц';

  @override
  String get reportYear => 'Год';

  @override
  String get reportGeneratedOn => 'Создан';

  @override
  String get reportInvoices => 'Счета';

  @override
  String get reportStatus => 'Статус';

  @override
  String get reportTotals => 'Итоги';

  @override
  String get reportSales => 'Продажи';

  @override
  String get reportTotalTax => 'Всего налога';

  @override
  String get reportTotalTip => 'Всего чаевых';

  @override
  String get reportTotalInvoiced => 'Всего выставлено';

  @override
  String get reportUnsent => 'Не отправлено';

  @override
  String get reportSent => 'Отправлено';

  @override
  String get reportPaid => 'Оплачено';

  @override
  String get reportOverdue => 'Просрочено';

  @override
  String get reportInvoiceNumber => '№ счета';

  @override
  String get reportClient => 'Клиент';

  @override
  String get reportDueDate => 'Срок оплаты';

  @override
  String get reportDescription => 'Описание';

  @override
  String get reportDate => 'Дата';

  @override
  String get reportFreeVersion => 'БЕСПЛАТНАЯ ВЕРСИЯ';

  @override
  String get reportPoweredBy => 'Создано в EzInvoice';

  @override
  String reportPdfShareText(Object title) {
    return 'PDF-отчет: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'CSV-отчет: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'Печать: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'Отчет_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'Отчет_Год_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'Отчет | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'Отчет | $year';
  }

  @override
  String get reportBreakdown => 'Разбивка';

  @override
  String get reportInvoicesStatus => 'Статус счетов';

  @override
  String get viewReport => 'Открыть отчет';

  @override
  String get reviewBeforeExport => 'Проверьте PDF или CSV перед экспортом.';

  @override
  String get customizeReport => 'Настроить отчет';

  @override
  String get reportPreviewUpdates =>
      'Изменения сразу появятся в предварительном просмотре.';

  @override
  String get yourReportPreview => 'Предварительный просмотр отчета';

  @override
  String get reportStyleLiveHint =>
      'Измените дизайн и сразу посмотрите результат.';

  @override
  String get watchAdToExportReport =>
      'Посмотрите рекламу полностью, чтобы экспортировать этот отчет. Перейдите на Pro для экспорта без рекламы.';

  @override
  String reportExportError(Object error) {
    return 'Не удалось экспортировать отчет: $error';
  }

  @override
  String get shareCsvFile => 'Поделиться CSV-файлом';

  @override
  String get shareCsvFileDescription =>
      'Поделитесь вложением .csv по электронной почте, через Drive или другое приложение.';

  @override
  String get shareReportAsText => 'Поделиться как текстом (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription => 'Отправьте сводку отчета текстом.';

  @override
  String get printCsv => 'Печать CSV';

  @override
  String get printReportDescription => 'Распечатайте отчет в виде таблицы PDF.';

  @override
  String get reportPreview => 'Предварительный просмотр';

  @override
  String get live => 'Онлайн';

  @override
  String get proFeatureUnlimitedInvoices => 'Неограниченные счета';

  @override
  String get proFeatureRemovePdfBranding => 'Убрать брендирование PDF';

  @override
  String get proFeatureExportCsv => 'Экспорт CSV';

  @override
  String get proFeaturePremiumTemplates => 'Премиум-шаблоны';

  @override
  String get proFeatureDetailedTaxReport => 'Подробный налоговый отчет';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'Бесплатный план позволяет до $limit счетов в месяц.';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'Удаляет «Создано в EzInvoice» из PDF.';

  @override
  String get proFeatureExportCsvDescription => 'Экспортируйте счета в CSV.';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'Откройте премиум-шаблоны счетов.';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'Просматривайте подробные налоговые отчеты.';

  @override
  String get pdfShareText => 'PDF-счет от EzInvoice';

  @override
  String get rewardedExportTitle => 'Экспортировать этот отчёт';

  @override
  String get watchAd => 'Посмотреть рекламу';

  @override
  String get rewardedAdCouldNotComplete =>
      'Не удалось завершить просмотр рекламы. Повторите попытку через некоторое время.';
}
