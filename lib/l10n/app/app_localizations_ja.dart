// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'アカウントを作成';

  @override
  String get email => 'メール';

  @override
  String get password => 'パスワード';

  @override
  String get login => 'ログイン';

  @override
  String get register => 'アカウント作成';

  @override
  String get alreadyHaveAccount => 'すでにアカウントをお持ちですか？';

  @override
  String get signIn => 'サインイン';

  @override
  String get dontHaveAccount => 'アカウントをお持ちではありませんか？';

  @override
  String get signUp => 'サインアップ';

  @override
  String get processing => '処理中...';

  @override
  String get invalidCredentials => '有効なメールアドレスとパスワード（6文字以上）を入力してください';

  @override
  String get authError => '認証エラー';

  @override
  String get home => 'ホーム';

  @override
  String get clients => '顧客';

  @override
  String get invoices => '請求書';

  @override
  String get reports => 'レポート';

  @override
  String get settings => '設定';

  @override
  String get logout => 'ログアウト';

  @override
  String get business => '事業';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageDescription => 'アプリの言語を選択してください。';

  @override
  String get systemDefault => 'システム既定';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'こんにちは $name さん、\nEzInvoice から請求書をお送りします。✅';
  }

  @override
  String get invoiceEmailSubject => '請求書 - EzInvoice';

  @override
  String get dashboardTitle => 'ダッシュボード';

  @override
  String get monthWord => '月';

  @override
  String get planLabel => 'プラン';

  @override
  String get invoicesRemaining => '残りの請求書数';

  @override
  String get proUnlimitedLabel => 'PRO · 無制限';

  @override
  String get createNewInvoice => '新しい請求書を作成';

  @override
  String get limitReachedSubtitle => '上限に達しました • Pro にアップグレード';

  @override
  String get createInvoiceFastSubtitle => '数秒で請求書 + PDF を作成';

  @override
  String get limitReachedTitle => '上限に達しました';

  @override
  String get limitReachedBody => '無制限の請求書と広告削除のために Pro にアップグレードしてください。';

  @override
  String get upgrade => 'アップグレード';

  @override
  String get monthSummaryTitle => '月次サマリー';

  @override
  String get salesTitle => '売上';

  @override
  String get tipTitle => 'チップ';

  @override
  String get subtotalTitle => '小計';

  @override
  String get taxTitle => '税';

  @override
  String get beforeTaxTip => '税/チップ前';

  @override
  String get collectedThisMonth => '今月の回収額';

  @override
  String get quickAccessTitle => 'クイックアクセス';

  @override
  String get clientsManageSubtitle => '顧客の作成 / 編集';

  @override
  String get invoicesViewSendSubtitle => 'PDF を表示して送信';

  @override
  String get monthlyYearlySubtitle => '月次 / 年次';

  @override
  String get businessProfileSubtitle => 'プロフィール / ロゴ / 税';

  @override
  String invoiceCount(Object count) {
    return '$count 件の請求書';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => '閉じる';

  @override
  String get paywallHeaderTitle => 'ビジネスのためにすべてを解放';

  @override
  String get paywallHeaderSubtitle => '広告なし • 請求書無制限 • 税レポート • プレミアムテンプレート';

  @override
  String get bestValue => 'お得';

  @override
  String get proYearly => 'Pro 年額';

  @override
  String get saveMoreYearly => '年額払いでさらにお得';

  @override
  String get proMonthly => 'Pro 月額';

  @override
  String get flexible => '柔軟';

  @override
  String get cancelAnytime => 'いつでも解約可能';

  @override
  String get processingPurchase => '購入を処理中…';

  @override
  String get restoringPurchases => '購入を復元中…';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get continueFreeWithAds => '広告付きの無料版を続ける';

  @override
  String get alreadyProTitle => 'Pro です ✅';

  @override
  String get alreadyProBody => '無制限の請求書、レポート、広告なしをお楽しみください。';

  @override
  String get continueText => '続ける';

  @override
  String get includesInPro => 'Pro に含まれるもの';

  @override
  String get benefitNoAds => '広告なし（バナー/インタースティシャル/リワード）';

  @override
  String get benefitUnlimitedInvoices => '請求書無制限 + ステータス（下書き/送信済み/支払い済み）';

  @override
  String get benefitPremiumTemplates => 'プレミアムテンプレート + カラー + 事業ロゴ';

  @override
  String get benefitNoWatermarkPdf => '透かしなしのプロ仕様 PDF';

  @override
  String get benefitTaxReports => '税レポート：月次・年次（税/チップ/純利益）';

  @override
  String get benefitExport => 'PDF/CSV/Excel へエクスポート（会計用）';

  @override
  String get benefitCloudBackup => 'クラウドバックアップ + 復元（複数端末）';

  @override
  String continueWithPlan(Object plan) {
    return '$plan で続ける';
  }

  @override
  String paywallFinePrint(Object store) {
    return '購読すると、お支払いは $store アカウントに請求されます。キャンセルしない限り自動更新されます（現在の期間終了の24時間前までにキャンセルが必要）。購読の管理・キャンセルはストア設定から行えます。';
  }

  @override
  String get reportsTitle => 'レポート';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => '月別';

  @override
  String get byYear => '年別';

  @override
  String get monthLabel => '月';

  @override
  String get yearLabel => '年';

  @override
  String get businessProfileTitle => '事業プロフィール';

  @override
  String get save => '保存';

  @override
  String get uploadLogo => 'ロゴをアップロード';

  @override
  String get remove => '削除';

  @override
  String get businessNameLabel => '事業名';

  @override
  String get ownerNameLabel => 'オーナー / 連絡先名';

  @override
  String get phoneLabel => '電話';

  @override
  String get addressLabel => '住所';

  @override
  String get currencyLabel => '通貨';

  @override
  String get taxDefaultLabel => '既定の税率（%）';

  @override
  String get invalidNumber => '無効な数値';

  @override
  String get range0to100 => '0〜100 の範囲で入力してください';

  @override
  String get requiredField => '必須';

  @override
  String get footerNoteLabel => 'フッターノート（PDF）';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get businessFooterDefault => 'ご利用ありがとうございます。';

  @override
  String get businessSavedSuccess => '事業プロフィールを保存しました';

  @override
  String get businessInfoSection => '事業情報';

  @override
  String get settingsSection => '設定';

  @override
  String get footerSection => 'フッターノート（PDF）';

  @override
  String get upgradeToPro => 'Pro にアップグレード';

  @override
  String get bestValueStar => '⭐ お得';

  @override
  String get invoicesTitle => '請求書';

  @override
  String get noInvoicesYet => 'まだ請求書がありません。';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return '無料プラン：月間上限 $limit 件 • 無制限にするにはアップグレード';
  }

  @override
  String get filtersTitle => 'フィルター';

  @override
  String get clientLabel => '顧客';

  @override
  String get allMonths => 'すべての月';

  @override
  String get allClients => 'すべての顧客';

  @override
  String get clear => 'クリア';

  @override
  String get invoicesSummaryLabel => '請求書';

  @override
  String get totalTitle => '合計';

  @override
  String get dateLabel => '日付';

  @override
  String get noResultsForFilters => '選択したフィルターの結果がありません。';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return '無料プラン：今月 $current / $limit 件。\n\n無制限にするには Pro にアップグレードしてください。';
  }

  @override
  String get deleteInvoiceTitle => '請求書を削除しますか？';

  @override
  String deleteInvoiceBody(Object invNo) {
    return '$invNo を削除してもよろしいですか？';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get edit => '編集';

  @override
  String get sendPdf => 'PDF を送信';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return '請求書 $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'PDF の作成/送信エラー: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'レポート • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'レポート • 年 $year';
  }

  @override
  String invoicesLine(Object count) {
    return '請求書: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return '総売上: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return '総税額: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return '総チップ: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return '純利益: \$$amount';
  }

  @override
  String get calculatedFromInvoices => 'Firestore の請求書から計算されました。';

  @override
  String get noInvoicesInPeriod => 'その期間の請求書はありません。';

  @override
  String get exportPdf => 'PDF を出力';

  @override
  String get exportCsv => 'CSV を出力';

  @override
  String get yearlyProReason => '年次レポートは PRO です。アップグレードで解放できます。';

  @override
  String get exportPdfProReason => 'レポートの PDF 出力は PRO です。';

  @override
  String get exportCsvProReason => 'CSV 出力は PRO です。';

  @override
  String get noDataToExport => '出力するデータがありません。';

  @override
  String get freePlanReportsNote => '無料プラン：月次レポートのみ。年次レポートと出力はアップグレードで利用できます。';

  @override
  String get genericError => '問題が発生しました。もう一度お試しください。';

  @override
  String get newInvoiceTitle => '新しい請求書';

  @override
  String get editInvoiceTitle => '請求書を編集';

  @override
  String get pickClient => '顧客を選択';

  @override
  String get invoiceAutoNumberLabel => '請求書 #（自動）';

  @override
  String invoiceDateLabel(Object date) {
    return '請求日: $date';
  }

  @override
  String get clientNameLabel => '顧客名';

  @override
  String get clientNameRequired => '顧客名は必須です';

  @override
  String get clientEmailOptionalLabel => '顧客メール（任意）';

  @override
  String get clientPhoneOptionalLabel => '顧客電話（任意）';

  @override
  String get invalidEmailFormat => 'メール形式が正しくありません';

  @override
  String get itemsTitle => '項目';

  @override
  String get descriptionLabel => '説明';

  @override
  String itemDateLabel(Object date) {
    return '項目日付: $date';
  }

  @override
  String get qtyLabel => '数量';

  @override
  String get priceLabel => '単価';

  @override
  String lineTotalLabel(Object amount) {
    return '明細合計: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => '税率 %（既定）';

  @override
  String get tipPercentChip => 'チップ %';

  @override
  String get tipAmountChip => 'チップ \$';

  @override
  String get tipPercentLabel => 'チップ率（%）';

  @override
  String get tipAmountLabel => 'チップ額（\$）';

  @override
  String get messageOptionalLabel => 'メッセージ（任意）';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return '小計: \$$sub\n税: \$$tax\nチップ: \$$tip\n合計: \$$total';
  }

  @override
  String get saving => '保存中…';

  @override
  String get saveInvoice => '請求書を保存';

  @override
  String get updateInvoice => '請求書を更新';

  @override
  String get addAtLeastOneItem => '少なくとも 1 件の項目を追加してください';

  @override
  String errorSavingInvoice(Object error) {
    return '請求書の保存エラー: $error';
  }

  @override
  String get savedTab => '保存済み';

  @override
  String get contactsTab => '連絡先';

  @override
  String get noSavedClients => '保存済みの顧客がありません';

  @override
  String get permissionDeniedContacts => '連絡先の権限が拒否されました';

  @override
  String get noContactsFound => 'この端末/エミュレーターに連絡先が見つかりません';

  @override
  String contactsError(Object error) {
    return '連絡先エラー: $error';
  }

  @override
  String get noName => '(名前なし)';

  @override
  String get newClientTitle => '新しい顧客';

  @override
  String get editClientTitle => '顧客を編集';

  @override
  String get clientInfoSection => '顧客情報';

  @override
  String get notesLabel => 'メモ';

  @override
  String get notesHint => 'メモを追加（任意）';

  @override
  String get clientCreateHint => 'ヒント：メール/電話を追加すると請求書を早く送れます。';

  @override
  String get clientEditHint => '顧客情報はいつでも更新できます。';

  @override
  String errorSavingClient(Object error) {
    return '顧客の保存エラー: $error';
  }

  @override
  String get clientsTitle => '顧客';

  @override
  String get searchClientsLabel => '顧客を検索';

  @override
  String clientsCount(Object count) {
    return '$count 件の顧客';
  }

  @override
  String get noClientsYet => 'まだ顧客がいません。';

  @override
  String get noClientsForSearch => '検索に一致する顧客がいません。';

  @override
  String get cannotOpenDialer => 'ダイヤラーを開けません';

  @override
  String get cannotOpenSms => 'SMS を開けません';

  @override
  String get whatsAppNotAvailable => 'WhatsApp を利用できません';

  @override
  String get cannotOpenEmail => 'メールを開けません';

  @override
  String get deleteClientTitle => '顧客を削除しますか？';

  @override
  String deleteClientBody(Object name) {
    return '$name を削除しますか？';
  }

  @override
  String get call => '通話';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'メール';

  @override
  String get shareAppTitle => 'EzInvoice を試してみて 👇';

  @override
  String get shareAppBody => '請求書作成、PDF送信、レポート管理が簡単に。';

  @override
  String get shareAppTooltip => 'アプリを共有';

  @override
  String get openGooglePlayTooltip => 'Google Play を開く';

  @override
  String get openAppStoreTooltip => 'App Store を開く';

  @override
  String get openWebsiteTooltip => 'Webサイトを開く';

  @override
  String get availableLanguages => '利用可能な言語';

  @override
  String get usePhoneLanguage => '端末の言語を使用';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return '領収書 $invoiceNumber（$clientName）';
  }

  @override
  String get report => 'レポート';

  @override
  String get invoicesLabel => '請求書';

  @override
  String get totalSalesLabel => '総売上';

  @override
  String get totalTaxLabel => '総税額';

  @override
  String get totalTipLabel => '総チップ';

  @override
  String get netLabel => '純利益';

  @override
  String get sentLabel => '送信済み';

  @override
  String get paidLabel => '支払い済み';

  @override
  String get overdueLabel => '期限超過';

  @override
  String get reportCalculatedHint => '請求書から計算されます。';

  @override
  String get exportPdfComingSoon => 'PDF 出力（近日）';

  @override
  String get exportCsvComingSoon => 'CSV 出力（近日）';

  @override
  String get unsentLabel => '未送信';

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
  String get profileSaved => '自動保存しました';

  @override
  String get profileSaveError => '保存できませんでした。変更内容はここに保持されています。';

  @override
  String get profileRetry => '再試行';

  @override
  String get profileAutosaveHint => '変更は自動保存され、閉じても保持されます。';

  @override
  String get profileLogo => '会社のロゴ';

  @override
  String get profileDefaults => '請求書の初期設定';

  @override
  String get profileTaxInvalid => '税率を確認してください（0～100%）。';

  @override
  String get metricLoadError => 'レポートを読み込めませんでした。再試行してください。';

  @override
  String get totalInvoicedTitle => '請求総額';
}
