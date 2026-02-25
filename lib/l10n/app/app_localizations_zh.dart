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
  String get reportCalculatedHint => '根据 Firestore 中的发票计算。';

  @override
  String get exportPdfComingSoon => '导出 PDF（即将推出）';

  @override
  String get exportCsvComingSoon => '导出 CSV（即将推出）';

  @override
  String get unsentLabel => '未发送';

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
  String get deleteAccountTitle => '删除账户';

  @override
  String get deleteAccountWarning => '此操作将永久删除您的账户及所有相关数据。';

  @override
  String get deleteAccountButton => '删除账户';

  @override
  String get deleteAccountConfirmTitle => '确认删除';

  @override
  String get deleteAccountConfirmMessage => '您确定吗？此操作无法撤销。';
}
