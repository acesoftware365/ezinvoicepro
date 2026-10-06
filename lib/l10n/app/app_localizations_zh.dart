// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => '创建你的账户';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get login => '登录';

  @override
  String get register => '创建账户';

  @override
  String get alreadyHaveAccount => '已经有账户了吗？';

  @override
  String get signIn => '登录';

  @override
  String get dontHaveAccount => '还没有账户？';

  @override
  String get signUp => '注册';

  @override
  String get processing => '处理中...';

  @override
  String get invalidCredentials => '请输入有效邮箱和密码（至少6位）';

  @override
  String get authError => '认证错误';

  @override
  String get home => '首页';

  @override
  String get clients => '客户';

  @override
  String get invoices => '发票';

  @override
  String get reports => '报表';

  @override
  String get settings => '设置';

  @override
  String get logout => '退出登录';

  @override
  String get business => '商家';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageDescription => '选择应用语言。';

  @override
  String get systemDefault => '系统默认';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return '你好 $name，\n我正在通过 EzInvoice 发送你的发票。✅';
  }

  @override
  String get invoiceEmailSubject => '发票 - EzInvoice';

  @override
  String get dashboardTitle => '仪表盘';

  @override
  String get monthWord => '月';

  @override
  String get planLabel => '方案';

  @override
  String get invoicesRemaining => '剩余发票数量';

  @override
  String get proUnlimitedLabel => 'PRO · 无限';

  @override
  String get createNewInvoice => '创建新发票';

  @override
  String get limitReachedSubtitle => '已达上限 • 升级到 Pro';

  @override
  String get createInvoiceFastSubtitle => '几秒内生成发票 + PDF';

  @override
  String get limitReachedTitle => '已达上限';

  @override
  String get limitReachedBody => '升级到 Pro 以获得无限发票并移除广告。';

  @override
  String get upgrade => '升级';

  @override
  String get monthSummaryTitle => '本月概览';

  @override
  String get salesTitle => '销售额';

  @override
  String get tipTitle => '小费';

  @override
  String get subtotalTitle => '小计';

  @override
  String get taxTitle => '税';

  @override
  String get beforeTaxTip => '税/小费前';

  @override
  String get collectedThisMonth => '本月已收';

  @override
  String get quickAccessTitle => '快捷入口';

  @override
  String get clientsManageSubtitle => '创建 / 编辑客户';

  @override
  String get invoicesViewSendSubtitle => '查看并发送 PDF';

  @override
  String get monthlyYearlySubtitle => '月度 / 年度';

  @override
  String get businessProfileSubtitle => '资料 / 标志 / 税率';

  @override
  String invoiceCount(Object count) {
    return '$count 张发票';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => '关闭';

  @override
  String get paywallHeaderTitle => '解锁你生意所需的一切';

  @override
  String get paywallHeaderSubtitle => '无广告 • 无限发票 • 税务报表 • 高级模板';

  @override
  String get bestValue => '最超值';

  @override
  String get proYearly => 'Pro 年付';

  @override
  String get saveMoreYearly => '年付更省';

  @override
  String get proMonthly => 'Pro 月付';

  @override
  String get flexible => '灵活';

  @override
  String get cancelAnytime => '随时取消';

  @override
  String get processingPurchase => '正在处理购买…';

  @override
  String get restoringPurchases => '正在恢复购买…';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get continueFreeWithAds => '继续使用带广告的免费版';

  @override
  String get alreadyProTitle => '你已是 Pro ✅';

  @override
  String get alreadyProBody => '享受无限发票、报表与无广告体验。';

  @override
  String get continueText => '继续';

  @override
  String get includesInPro => 'Pro 包含';

  @override
  String get benefitNoAds => '无广告（横幅/插屏/激励）';

  @override
  String get benefitUnlimitedInvoices => '无限发票 + 状态（草稿/已发送/已付款）';

  @override
  String get benefitPremiumTemplates => '高级模板 + 颜色 + 商家标志';

  @override
  String get benefitNoWatermarkPdf => '无水印专业 PDF';

  @override
  String get benefitTaxReports => '税务报表：月度与年度（税/小费/净额）';

  @override
  String get benefitExport => '导出 PDF/CSV/Excel（用于会计）';

  @override
  String get benefitCloudBackup => '云备份 + 恢复（多设备）';

  @override
  String continueWithPlan(Object plan) {
    return '使用 $plan 继续';
  }

  @override
  String paywallFinePrint(Object store) {
    return '订阅后，费用将从你的 $store 账户扣款。订阅会自动续订，除非你在当前周期结束前至少24小时取消。你可以在商店设置中管理或取消订阅。';
  }

  @override
  String get reportsTitle => '报表';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => '按月';

  @override
  String get byYear => '按年';

  @override
  String get monthLabel => '月份';

  @override
  String get yearLabel => '年份';

  @override
  String get businessProfileTitle => '商家资料';

  @override
  String get save => '保存';

  @override
  String get uploadLogo => '上传标志';

  @override
  String get remove => '移除';

  @override
  String get businessNameLabel => '商家名称';

  @override
  String get ownerNameLabel => '负责人 / 联系人';

  @override
  String get phoneLabel => '电话';

  @override
  String get addressLabel => '地址';

  @override
  String get currencyLabel => '货币';

  @override
  String get taxDefaultLabel => '默认税率（%）';

  @override
  String get invalidNumber => '无效数字';

  @override
  String get range0to100 => '必须在 0 到 100 之间';

  @override
  String get requiredField => '必填';

  @override
  String get footerNoteLabel => '页脚备注（PDF）';

  @override
  String get saveChanges => '保存更改';

  @override
  String get businessFooterDefault => '感谢你的惠顾。';

  @override
  String get businessSavedSuccess => '商家资料保存成功';

  @override
  String get businessInfoSection => '商家信息';

  @override
  String get settingsSection => '设置';

  @override
  String get footerSection => '页脚备注（PDF）';

  @override
  String get upgradeToPro => '升级到 Pro';

  @override
  String get bestValueStar => '⭐ 最超值';

  @override
  String get invoicesTitle => '发票';

  @override
  String get noInvoicesYet => '还没有发票。';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return '免费版：每月上限 $limit 张发票 • 升级解锁无限';
  }

  @override
  String get filtersTitle => '筛选';

  @override
  String get clientLabel => '客户';

  @override
  String get allMonths => '所有月份';

  @override
  String get allClients => '所有客户';

  @override
  String get clear => '清除';

  @override
  String get invoicesSummaryLabel => '发票';

  @override
  String get totalTitle => '总计';

  @override
  String get dateLabel => '日期';

  @override
  String get noResultsForFilters => '所选筛选条件下没有结果。';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return '免费版：本月 $current / $limit 张发票。\n\n升级到 Pro 解锁无限。';
  }

  @override
  String get deleteInvoiceTitle => '删除发票？';

  @override
  String deleteInvoiceBody(Object invNo) {
    return '确定要删除 $invNo 吗？';
  }

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get sendPdf => '发送 PDF';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return '发票 $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return '生成/发送 PDF 出错：$error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return '报表 • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return '报表 • 年 $year';
  }

  @override
  String invoicesLine(Object count) {
    return '发票：$count';
  }

  @override
  String totalSalesLine(Object amount) {
    return '总销售额：\$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return '总税额：\$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return '总小费：\$$amount';
  }

  @override
  String netLine(Object amount) {
    return '净额：\$$amount';
  }

  @override
  String get calculatedFromInvoices => '根据 Firestore 中的发票计算。';

  @override
  String get noInvoicesInPeriod => '该期间没有发票。';

  @override
  String get exportPdf => '导出 PDF';

  @override
  String get exportCsv => '导出 CSV';

  @override
  String get yearlyProReason => '年度报表为 PRO 功能。升级解锁。';

  @override
  String get exportPdfProReason => '导出报表 PDF 为 PRO 功能。';

  @override
  String get exportCsvProReason => '导出 CSV 为 PRO 功能。';

  @override
  String get noDataToExport => '没有可导出的数据。';

  @override
  String get freePlanReportsNote => '免费版：仅支持月度报表。升级解锁年度报表与导出。';

  @override
  String get genericError => '出错了，请重试。';

  @override
  String get newInvoiceTitle => '新建发票';

  @override
  String get editInvoiceTitle => '编辑发票';

  @override
  String get pickClient => '选择客户';

  @override
  String get invoiceAutoNumberLabel => '发票号（自动）';

  @override
  String invoiceDateLabel(Object date) {
    return '发票日期：$date';
  }

  @override
  String get clientNameLabel => '客户名称';

  @override
  String get clientNameRequired => '客户名称必填';

  @override
  String get clientEmailOptionalLabel => '客户邮箱（可选）';

  @override
  String get clientPhoneOptionalLabel => '客户电话（可选）';

  @override
  String get invalidEmailFormat => '邮箱格式无效';

  @override
  String get itemsTitle => '项目';

  @override
  String get descriptionLabel => '描述';

  @override
  String itemDateLabel(Object date) {
    return '项目日期：$date';
  }

  @override
  String get qtyLabel => '数量';

  @override
  String get priceLabel => '价格';

  @override
  String lineTotalLabel(Object amount) {
    return '行合计：\$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => '税率 %（默认）';

  @override
  String get tipPercentChip => '小费 %';

  @override
  String get tipAmountChip => '小费 \$';

  @override
  String get tipPercentLabel => '小费比例（%）';

  @override
  String get tipAmountLabel => '小费金额（\$）';

  @override
  String get messageOptionalLabel => '留言（可选）';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return '小计：\$$sub\n税：\$$tax\n小费：\$$tip\n总计：\$$total';
  }

  @override
  String get saving => '保存中…';

  @override
  String get saveInvoice => '保存发票';

  @override
  String get updateInvoice => '更新发票';

  @override
  String get addAtLeastOneItem => '至少添加 1 个项目';

  @override
  String errorSavingInvoice(Object error) {
    return '保存发票出错：$error';
  }

  @override
  String get savedTab => '已保存';

  @override
  String get contactsTab => '联系人';

  @override
  String get noSavedClients => '没有已保存的客户';

  @override
  String get permissionDeniedContacts => '联系人权限被拒绝';

  @override
  String get noContactsFound => '此设备/模拟器未找到联系人';

  @override
  String contactsError(Object error) {
    return '联系人错误：$error';
  }

  @override
  String get noName => '(无名称)';

  @override
  String get newClientTitle => '新建客户';

  @override
  String get editClientTitle => '编辑客户';

  @override
  String get clientInfoSection => '客户信息';

  @override
  String get notesLabel => '备注';

  @override
  String get notesHint => '添加备注（可选）';

  @override
  String get clientCreateHint => '提示：添加邮箱/电话可更快发送发票。';

  @override
  String get clientEditHint => '你可以随时更新客户信息。';

  @override
  String errorSavingClient(Object error) {
    return '保存客户出错：$error';
  }

  @override
  String get clientsTitle => '客户';

  @override
  String get searchClientsLabel => '搜索客户';

  @override
  String clientsCount(Object count) {
    return '$count 位客户';
  }

  @override
  String get noClientsYet => '还没有客户。';

  @override
  String get noClientsForSearch => '没有匹配的客户。';

  @override
  String get cannotOpenDialer => '无法打开拨号器';

  @override
  String get cannotOpenSms => '无法打开短信';

  @override
  String get whatsAppNotAvailable => 'WhatsApp 不可用';

  @override
  String get cannotOpenEmail => '无法打开邮箱';

  @override
  String get deleteClientTitle => '删除客户？';

  @override
  String deleteClientBody(Object name) {
    return '移除 $name？';
  }

  @override
  String get call => '拨打';

  @override
  String get sms => '短信';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => '邮箱';

  @override
  String get shareAppTitle => '试试 EzInvoice 👇';

  @override
  String get shareAppBody => '轻松创建发票、发送 PDF，并跟踪报表。';

  @override
  String get shareAppTooltip => '分享应用';

  @override
  String get openGooglePlayTooltip => '打开 Google Play';

  @override
  String get openAppStoreTooltip => '打开 App Store';

  @override
  String get openWebsiteTooltip => '打开网站';

  @override
  String get availableLanguages => '可用语言';

  @override
  String get usePhoneLanguage => '使用手机语言';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return '收据 $invoiceNumber - $clientName';
  }

  @override
  String get report => '报表';

  @override
  String get invoicesLabel => '发票';

  @override
  String get totalSalesLabel => '总销售额';

  @override
  String get totalTaxLabel => '总税额';

  @override
  String get totalTipLabel => '总小费';

  @override
  String get netLabel => '净额';

  @override
  String get sentLabel => '已发送';

  @override
  String get paidLabel => '已付款';

  @override
  String get overdueLabel => '已逾期';

  @override
  String get reportCalculatedHint => '根据您的发票计算。';

  @override
  String get exportPdfComingSoon => '导出 PDF（即将推出）';

  @override
  String get exportCsvComingSoon => '导出 CSV（即将推出）';

  @override
  String get unsentLabel => '未发送';

  @override
  String get servicePresetsTitle => '已保存的服务';

  @override
  String get servicePresetsScreenTitle => '已保存的服务';

  @override
  String get servicePresetsAddNew => '添加新服务';

  @override
  String get servicePresetsHint => '例如：清洁、维修、咨询...';

  @override
  String get servicePresetsAddButton => '添加';

  @override
  String get addServiceLabel => '添加服务';

  @override
  String get yourPresets => '您保存的服务';

  @override
  String get noPresetsYet => '尚无已保存的服务。';

  @override
  String get notNow => '暂不';

  @override
  String get openPaywallPlaceholder => '打开订阅';

  @override
  String get invoiceStyleTitle => '发票样式';

  @override
  String get invoiceFreeStyleHint =>
      '免费方案使用一个发票版本（Minimal）。升级到 Pro 可解锁所有布局和配色方案。';

  @override
  String get invoicePaletteLabel => '发票配色方案';

  @override
  String get invoiceLayoutLabel => '发票布局';

  @override
  String get saveInvoicePaletteError => '无法保存发票配色方案。';

  @override
  String get saveInvoiceLayoutError => '无法保存发票布局。';

  @override
  String get reportStyleTitle => '报告样式';

  @override
  String get reportFreeStyleHint =>
      '免费方案使用一个报告版本（Minimal）。升级到 Pro 可解锁所有布局和配色方案。';

  @override
  String get reportPaletteLabel => '报告配色方案';

  @override
  String get reportLayoutLabel => '报告布局';

  @override
  String get saveReportPaletteError => '无法保存报告配色方案。';

  @override
  String get saveReportLayoutError => '无法保存报告布局。';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return '$docType 样式：$style | 配色：$palette';
  }

  @override
  String get deleteAccountTitle => '删除账户';

  @override
  String get deleteAccountWarning => '此操作将永久删除您的账户及所有相关数据。';

  @override
  String get deleteAccountButton => '删除账户';

  @override
  String get deleteAccountConfirmTitle => '确认删除';

  @override
  String get deleteAccountConfirmMessage => '您确定吗？此操作无法撤销。';

  @override
  String get profileSaved => '已自动保存';

  @override
  String get profileSaveError => '无法保存。您的更改仍保留在此处。';

  @override
  String get profileRetry => '重试';

  @override
  String get profileAutosaveHint => '更改会自动保存，关闭后仍会保留。';

  @override
  String get profileLogo => '公司标志';

  @override
  String get profileDefaults => '发票默认设置';

  @override
  String get profileTaxInvalid => '请检查税率（0–100%）。';

  @override
  String get metricLoadError => '无法加载报告，请重试。';

  @override
  String get totalInvoicedTitle => '开票总额';

  @override
  String versionLabel(Object version) {
    return '版本 $version';
  }

  @override
  String errorWithDetails(Object error) {
    return '错误：$error';
  }

  @override
  String get rememberEmail => '记住我的电子邮件';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get passwordResetEnterEmail => '请输入您的电子邮件以发送重置链接。';

  @override
  String get passwordResetSent => '我们已发送密码重置邮件。请查看垃圾邮件箱。';

  @override
  String get passwordResetNoAccount => '未找到使用该电子邮件的账户。';

  @override
  String get invalidEmail => '电子邮件无效。';

  @override
  String get passwordResetError => '无法发送电子邮件。请重试。';

  @override
  String get updateRequired => '需要更新';

  @override
  String get updateRequiredBody => 'Ez Invoice 有新版本可用。请在商店更新应用后继续。';

  @override
  String get updateNow => '立即更新';

  @override
  String get open => '打开';

  @override
  String get share => '分享';

  @override
  String get actions => '操作';

  @override
  String get message => '消息';

  @override
  String get done => '完成';

  @override
  String get confirm => '确认';

  @override
  String get free => '免费';

  @override
  String get clientInformation => '客户信息';

  @override
  String get clientName => '客户名称';

  @override
  String get notesOptional => '备注（可选）';

  @override
  String get saveClient => '保存客户';

  @override
  String get importFromContacts => '从通讯录导入';

  @override
  String get importContactsDescription => '即时填写姓名、电话和电子邮件。';

  @override
  String get loadContacts => '加载通讯录';

  @override
  String get clientPhone => '客户电话';

  @override
  String get searchContacts => '搜索通讯录';

  @override
  String get shareClient => '分享客户';

  @override
  String get clientProfile => '客户资料';

  @override
  String get chooseSavedService => '选择已保存的服务';

  @override
  String get searchSavedServices => '搜索已保存的服务';

  @override
  String get noSavedServicesFound => '未找到已保存的服务';

  @override
  String get noSavedServicesToUse => '尚无已保存的服务。请在上方输入一项并保存以便以后使用。';

  @override
  String savedServiceAlreadyExists(Object service) {
    return '已保存：$service';
  }

  @override
  String savedService(Object service) {
    return '已保存服务：$service';
  }

  @override
  String savePresetError(Object error) {
    return '无法保存服务：$error';
  }

  @override
  String get saveServiceForLater => '保存服务以便以后使用';

  @override
  String get removeClient => '移除客户';

  @override
  String get service => '服务';

  @override
  String get taxAndTip => '税费和小费';

  @override
  String get totals => '合计';

  @override
  String dueDate(Object date) {
    return '到期日：$date';
  }

  @override
  String paidDate(Object date) {
    return '付款日期：$date';
  }

  @override
  String get notPaidYet => '尚未付款';

  @override
  String paymentMethodWithValue(Object method) {
    return '方式：$method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return '备注：$note';
  }

  @override
  String get markAsPaid => '标记为已付款';

  @override
  String get markAsUnpaid => '标记为未付款';

  @override
  String get editTax => '编辑';

  @override
  String get addClient => '添加客户';

  @override
  String get firstClientHint => '创建您的第一个客户，以便在今后的发票中重复使用。';

  @override
  String get searchSavedClients => '搜索已保存的客户';

  @override
  String get paymentMethod => '付款方式';

  @override
  String get cash => '现金';

  @override
  String get card => '银行卡';

  @override
  String get check => '支票';

  @override
  String get other => '其他';

  @override
  String get noteOptional => '备注（可选）';

  @override
  String invoiceMarkPaidError(Object error) {
    return '无法将发票标记为已付款：$error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return '无法将发票标记为未付款：$error';
  }

  @override
  String deleteError(Object error) {
    return '无法删除发票：$error';
  }

  @override
  String get invoiceDeleted => '发票已删除';

  @override
  String get invoiceMarkedSent => '已标记为已发送 ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return '无法标记为已发送：$error';
  }

  @override
  String get invoiceMarkedUnsent => '已标记为未发送 ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return '无法标记为未发送：$error';
  }

  @override
  String get invoiceMarkedPaid => '已标记为已付款 ✅';

  @override
  String get invoiceMarkedUnpaid => '已标记为未付款 ✅';

  @override
  String get invoiceLoadingError => '无法加载发票';

  @override
  String get tipType => '小费类型';

  @override
  String get amountOption => '金额 (\$)';

  @override
  String get percentageOption => '百分比 (%)';

  @override
  String get pdfPreview => 'PDF 预览';

  @override
  String get openPdf => '打开 PDF';

  @override
  String get sharePdf => '分享 PDF';

  @override
  String get selectReportMonth => '选择报告月份';

  @override
  String reportForBusiness(Object business) {
    return '报告 • $business';
  }

  @override
  String get tapToChangeMonth => '轻点以更改月份';

  @override
  String csvSaved(Object path) {
    return 'CSV 已保存：$path';
  }

  @override
  String csvExportError(Object error) {
    return '无法导出 CSV：$error';
  }

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutTagline => '为不断发展的企业提供清晰的发票';

  @override
  String get aboutAppTitle => '应用';

  @override
  String get aboutAppBody => 'EzInvoice 将发票、客户、付款和报告整合为简单流程，让您掌握重点并安心收款。';

  @override
  String get aboutCompanyTitle => '公司';

  @override
  String get aboutCompanyBody => 'Liisgo LLC 为小型企业打造实用工具，帮助其更有条理、更清晰、更自信地工作。';

  @override
  String get aboutPromiseTitle => '为您的日常而设计';

  @override
  String get aboutPromiseBody => 'EzInvoice 的每项设计都旨在减少步骤、清晰呈现细节，让业务管理更简单。';

  @override
  String get visitLiisgo => '访问 Liisgo';

  @override
  String get contactSupport => '联系支持团队';

  @override
  String get shareEzInvoice => '分享 EzInvoice';

  @override
  String get sendIdeaOrBug => '提交建议或问题';

  @override
  String get feedbackTitle => '您的反馈很重要';

  @override
  String get feedbackSubtitle => '告诉我们您希望改进什么，或哪些地方运行不佳。';

  @override
  String get feedbackIdea => '建议';

  @override
  String get feedbackBug => '问题';

  @override
  String get feedbackHint => '写下您的建议或说明发生了什么…';

  @override
  String get feedbackRequired => '发送前请填写消息。';

  @override
  String get continueToEmail => '继续发送邮件';

  @override
  String get couldNotOpenLink => '无法打开此链接。';

  @override
  String shareAppText(Object storeUrl) {
    return '了解 EzInvoice Pro：在一处管理发票、客户和报告。\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return 'EzInvoice $kind';
  }

  @override
  String get supportEmailSubject => 'EzInvoice 支持';

  @override
  String get changePassword => '更改密码';

  @override
  String get changePasswordSubtitle => '更新您的账户密码。';

  @override
  String get confirmCurrentPasswordHint => '为保障安全，请先确认您当前的密码。';

  @override
  String get currentPassword => '当前密码';

  @override
  String get newPassword => '新密码';

  @override
  String get confirmNewPassword => '确认新密码';

  @override
  String get updatePassword => '更新密码';

  @override
  String get passwordAtLeastSix => '至少需要 6 个字符。';

  @override
  String get noActiveSession => '没有活动会话。';

  @override
  String get passwordsDoNotMatch => '新密码不匹配。';

  @override
  String get passwordMustDiffer => '新密码必须不同。';

  @override
  String get passwordUpdated => '密码已成功更新。';

  @override
  String get incorrectPassword => '当前密码不正确。';

  @override
  String get weakPassword => '新密码过于简单。';

  @override
  String get reauthenticationNeeded => '为保障安全，请重新登录后再试。';

  @override
  String get changePasswordError => '无法更改密码。';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get reauthCancelled => '已取消重新验证。';

  @override
  String get accountDeleted => '您的账户和数据已被永久删除。';

  @override
  String get deleteAccountIncorrectPassword => '密码不正确。';

  @override
  String get deleteAccountError => '无法删除账户。';

  @override
  String get deleteAccountBody =>
      '如果您删除账户：\n\n• 您的客户、发票、报告和企业资料将被永久删除。\n• 此操作无法撤销。\n• 如果您有有效订阅，请在 App Store/Google Play 中管理或取消订阅。';

  @override
  String get termsConditions => '条款和条件';

  @override
  String get agreeTermsPrivacy => '请先同意条款和条件以及隐私政策。';

  @override
  String get currentPlan => '当前套餐';

  @override
  String get currentPlanFree => '当前套餐：免费';

  @override
  String get proPlanDescription =>
      '免费版包含广告和使用限制。Pro 可移除广告，并解锁无限发票、报告、高级模板、导出和云备份。';

  @override
  String get adsIncluded => '包含广告';

  @override
  String get limitedInvoicesPerMonth => '每月发票数量有限';

  @override
  String get basicInvoiceStyle => '基础发票样式';

  @override
  String get basicReports => '基础报告';

  @override
  String get pdfIncludesBranding => 'PDF 包含 EzInvoice 品牌标识';

  @override
  String get unpaidLabel => '未付款';

  @override
  String get loading => '加载中...';

  @override
  String get store => '商店';

  @override
  String get storeProductLoadingOne => '一个订阅产品仍在加载。您可以先使用可用套餐，等待另一个产品加载完成。';

  @override
  String get storeProductsLoading => '正在连接商店订阅产品。如果加载未完成，请在商店控制台确认订阅已准备就绪。';

  @override
  String get agreeTo => '我同意';

  @override
  String get and => '和';

  @override
  String get currentProPlanDescription =>
      '您已经拥有 Ez Invoice Pro。您可以在下方查看两种订阅选项。';

  @override
  String freeVsPro(Object pro) {
    return '免费版与 $pro';
  }

  @override
  String get openInvoices => '打开发票。';

  @override
  String get allCaughtUp => '全部处理完毕';

  @override
  String itemsToReview(Object count) {
    return '$count 项待查看';
  }

  @override
  String get pdfInvoice => '发票';

  @override
  String get pdfReceipt => '收据';

  @override
  String get pdfBusiness => '企业';

  @override
  String get pdfPhone => '电话';

  @override
  String get pdfEmail => '电子邮件';

  @override
  String get pdfNumber => '编号';

  @override
  String get pdfDate => '日期';

  @override
  String get pdfDue => '到期';

  @override
  String get pdfPaid => '已付款';

  @override
  String get pdfPaidDate => '付款日期';

  @override
  String get pdfMethod => '方式';

  @override
  String get pdfBillTo => '账单发送至';

  @override
  String get pdfClient => '客户';

  @override
  String get pdfDescription => '描述';

  @override
  String get pdfQuantity => '数量';

  @override
  String get pdfPrice => '价格';

  @override
  String get pdfSubtotal => '小计';

  @override
  String get pdfTax => '税费';

  @override
  String pdfTaxWithRate(Object rate) {
    return '税费 ($rate%)';
  }

  @override
  String get pdfTip => '小费';

  @override
  String pdfTipWithRate(Object rate) {
    return '小费 ($rate%)';
  }

  @override
  String get pdfDiscount => '折扣';

  @override
  String get pdfMessage => '消息';

  @override
  String get pdfPaymentNote => '付款备注';

  @override
  String get pdfThankYou => '感谢您的惠顾。';

  @override
  String get pdfPoweredBy => '由 EzInvoice 提供支持';

  @override
  String get pdfFreeVersion => '免费版本';

  @override
  String get pdfTotal => '总计';

  @override
  String get styleMinimal => '极简';

  @override
  String get styleProfessional => '专业';

  @override
  String get styleCorporate => '企业';

  @override
  String get styleModern => '现代';

  @override
  String get styleSlate => '石板';

  @override
  String get reportDocument => '报告';

  @override
  String get reportPrintDocument => '打印报告';

  @override
  String get reportMonth => '月份';

  @override
  String get reportYear => '年份';

  @override
  String get reportGeneratedOn => '生成于';

  @override
  String get reportInvoices => '发票';

  @override
  String get reportStatus => '状态';

  @override
  String get reportTotals => '合计';

  @override
  String get reportSales => '销售额';

  @override
  String get reportTotalTax => '税额合计';

  @override
  String get reportTotalTip => '小费合计';

  @override
  String get reportTotalInvoiced => '开票总额';

  @override
  String get reportUnsent => '未发送';

  @override
  String get reportSent => '已发送';

  @override
  String get reportPaid => '已付款';

  @override
  String get reportOverdue => '逾期';

  @override
  String get reportInvoiceNumber => '发票编号';

  @override
  String get reportClient => '客户';

  @override
  String get reportDueDate => '到期日';

  @override
  String get reportDescription => '描述';

  @override
  String get reportDate => '日期';

  @override
  String get reportFreeVersion => '免费版';

  @override
  String get reportPoweredBy => '由 EzInvoice 提供支持';

  @override
  String reportPdfShareText(Object title) {
    return 'PDF 报告：$title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'CSV 报告：$title';
  }

  @override
  String reportPrintShareText(Object title) {
    return '打印：$title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return '报告_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return '报告_年份_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return '报告 | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return '报告 | $year';
  }

  @override
  String get reportBreakdown => '明细';

  @override
  String get reportInvoicesStatus => '发票状态';

  @override
  String get viewReport => '查看报告';

  @override
  String get reviewBeforeExport => '导出前查看 PDF 或 CSV。';

  @override
  String get customizeReport => '自定义报告';

  @override
  String get reportPreviewUpdates => '更改会立即显示在预览中。';

  @override
  String get yourReportPreview => '报告预览';

  @override
  String get reportStyleLiveHint => '更改设计并实时查看。';

  @override
  String get watchAdToExportReport => '观看完整广告以导出此报告。升级到 Pro 可无广告导出。';

  @override
  String reportExportError(Object error) {
    return '无法导出报告: $error';
  }

  @override
  String get shareCsvFile => '分享 CSV 文件';

  @override
  String get shareCsvFileDescription => '通过电子邮件、Drive 或其他应用分享 .csv 附件。';

  @override
  String get shareReportAsText => '以文本分享 (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription => '以文本发送报告摘要。';

  @override
  String get printCsv => '打印 CSV';

  @override
  String get printReportDescription => '将报告打印为 PDF 表格。';

  @override
  String get reportPreview => '预览';

  @override
  String get live => '实时';

  @override
  String get proFeatureUnlimitedInvoices => '无限发票';

  @override
  String get proFeatureRemovePdfBranding => '移除 PDF 品牌标记';

  @override
  String get proFeatureExportCsv => '导出 CSV';

  @override
  String get proFeaturePremiumTemplates => '高级模板';

  @override
  String get proFeatureDetailedTaxReport => '详细税务报告';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return '免费方案每月最多可创建 $limit 张发票。';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      '从 PDF 中移除“由 EzInvoice 提供支持”。';

  @override
  String get proFeatureExportCsvDescription => '将您的发票导出为 CSV。';

  @override
  String get proFeaturePremiumTemplatesDescription => '解锁高级发票模板。';

  @override
  String get proFeatureDetailedTaxReportDescription => '查看详细税务明细报告。';

  @override
  String get pdfShareText => '来自 EzInvoice 的发票 PDF';

  @override
  String get rewardedExportTitle => '导出此报告';

  @override
  String get watchAd => '观看广告';

  @override
  String get rewardedAdCouldNotComplete => '无法完成广告。请稍后重试。';
}
