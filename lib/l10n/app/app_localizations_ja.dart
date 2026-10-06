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
  String get servicePresetsTitle => '保存済みサービス';

  @override
  String get servicePresetsScreenTitle => '保存済みサービス';

  @override
  String get servicePresetsAddNew => '新しいサービスを追加';

  @override
  String get servicePresetsHint => '例: 清掃、修理、コンサルティング...';

  @override
  String get servicePresetsAddButton => '追加';

  @override
  String get addServiceLabel => 'サービスを追加';

  @override
  String get yourPresets => '保存済みサービス';

  @override
  String get noPresetsYet => '保存済みサービスはまだありません。';

  @override
  String get notNow => '今はしない';

  @override
  String get openPaywallPlaceholder => 'サブスクリプションを開く';

  @override
  String get invoiceStyleTitle => '請求書スタイル';

  @override
  String get invoiceFreeStyleHint =>
      '無料プランでは請求書のバージョンは 1 つ（Minimal）です。すべてのレイアウトとパレットを使うには Pro にアップグレードしてください。';

  @override
  String get invoicePaletteLabel => '請求書パレット';

  @override
  String get invoiceLayoutLabel => '請求書レイアウト';

  @override
  String get saveInvoicePaletteError => '請求書パレットを保存できませんでした。';

  @override
  String get saveInvoiceLayoutError => '請求書レイアウトを保存できませんでした。';

  @override
  String get reportStyleTitle => 'レポートスタイル';

  @override
  String get reportFreeStyleHint =>
      '無料プランではレポートのバージョンは 1 つ（Minimal）です。すべてのレイアウトとパレットを使うには Pro にアップグレードしてください。';

  @override
  String get reportPaletteLabel => 'レポートパレット';

  @override
  String get reportLayoutLabel => 'レポートレイアウト';

  @override
  String get saveReportPaletteError => 'レポートパレットを保存できませんでした。';

  @override
  String get saveReportLayoutError => 'レポートレイアウトを保存できませんでした。';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return '$docType スタイル: $style | パレット: $palette';
  }

  @override
  String get deleteAccountTitle => 'アカウントを削除';

  @override
  String get deleteAccountWarning => 'この操作により、アカウントと関連するすべてのデータが完全に削除されます。';

  @override
  String get deleteAccountButton => 'アカウントを削除';

  @override
  String get deleteAccountConfirmTitle => '削除の確認';

  @override
  String get deleteAccountConfirmMessage => '本当によろしいですか？この操作は元に戻せません。';

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

  @override
  String versionLabel(Object version) {
    return 'バージョン $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'エラー: $error';
  }

  @override
  String get rememberEmail => 'メールアドレスを記憶する';

  @override
  String get forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get passwordResetEnterEmail => 'リセットリンクを送るため、メールアドレスを入力してください。';

  @override
  String get passwordResetSent => 'パスワード再設定用のメールを送信しました。迷惑メールフォルダもご確認ください。';

  @override
  String get passwordResetNoAccount => 'このメールアドレスのアカウントは見つかりませんでした。';

  @override
  String get invalidEmail => 'メールアドレスが正しくありません。';

  @override
  String get passwordResetError => 'メールを送信できませんでした。もう一度お試しください。';

  @override
  String get updateRequired => '更新が必要です';

  @override
  String get updateRequiredBody =>
      'Ez Invoice の新しいバージョンがあります。続けるにはストアからアプリを更新してください。';

  @override
  String get updateNow => '今すぐ更新';

  @override
  String get open => '開く';

  @override
  String get share => '共有';

  @override
  String get actions => '操作';

  @override
  String get message => 'メッセージ';

  @override
  String get done => '完了';

  @override
  String get confirm => '確認';

  @override
  String get free => '無料';

  @override
  String get clientInformation => '顧客情報';

  @override
  String get clientName => '顧客名';

  @override
  String get notesOptional => 'メモ（任意）';

  @override
  String get saveClient => '顧客を保存';

  @override
  String get importFromContacts => '連絡先から読み込む';

  @override
  String get importContactsDescription => '名前、電話番号、メールをすぐに入力できます。';

  @override
  String get loadContacts => '連絡先を読み込む';

  @override
  String get clientPhone => '顧客の電話番号';

  @override
  String get searchContacts => '連絡先を検索';

  @override
  String get shareClient => '顧客を共有';

  @override
  String get clientProfile => '顧客プロフィール';

  @override
  String get chooseSavedService => '保存したサービスを選択';

  @override
  String get searchSavedServices => '保存したサービスを検索';

  @override
  String get noSavedServicesFound => '保存したサービスが見つかりません';

  @override
  String get noSavedServicesToUse => '保存したサービスはまだありません。上で入力して後で使うために保存してください。';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'すでに保存済み: $service';
  }

  @override
  String savedService(Object service) {
    return 'サービスを保存しました: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'サービスを保存できませんでした: $error';
  }

  @override
  String get saveServiceForLater => 'サービスを後で使うために保存';

  @override
  String get removeClient => '顧客を削除';

  @override
  String get service => 'サービス';

  @override
  String get taxAndTip => '税金とチップ';

  @override
  String get totals => '合計';

  @override
  String dueDate(Object date) {
    return '支払期日: $date';
  }

  @override
  String paidDate(Object date) {
    return '支払日: $date';
  }

  @override
  String get notPaidYet => '未払い';

  @override
  String paymentMethodWithValue(Object method) {
    return '方法: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'メモ: $note';
  }

  @override
  String get markAsPaid => '支払い済みにする';

  @override
  String get markAsUnpaid => '未払いにする';

  @override
  String get editTax => '編集';

  @override
  String get addClient => '顧客を追加';

  @override
  String get firstClientHint => '今後の請求書で再利用するために最初の顧客を作成してください。';

  @override
  String get searchSavedClients => '保存した顧客を検索';

  @override
  String get paymentMethod => '支払い方法';

  @override
  String get cash => '現金';

  @override
  String get card => 'カード';

  @override
  String get check => '小切手';

  @override
  String get other => 'その他';

  @override
  String get noteOptional => 'メモ（任意）';

  @override
  String invoiceMarkPaidError(Object error) {
    return '請求書を支払い済みにできませんでした: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return '請求書を未払いにできませんでした: $error';
  }

  @override
  String deleteError(Object error) {
    return '請求書を削除できませんでした: $error';
  }

  @override
  String get invoiceDeleted => '請求書を削除しました';

  @override
  String get invoiceMarkedSent => '送信済みにしました ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return '送信済みにできませんでした: $error';
  }

  @override
  String get invoiceMarkedUnsent => '未送信にしました ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return '未送信にできませんでした: $error';
  }

  @override
  String get invoiceMarkedPaid => '支払い済みにしました ✅';

  @override
  String get invoiceMarkedUnpaid => '未払いにしました ✅';

  @override
  String get invoiceLoadingError => '請求書を読み込めませんでした';

  @override
  String get tipType => 'チップの種類';

  @override
  String get amountOption => '金額 (\$)';

  @override
  String get percentageOption => '割合 (%)';

  @override
  String get pdfPreview => 'PDFプレビュー';

  @override
  String get openPdf => 'PDFを開く';

  @override
  String get sharePdf => 'PDFを共有';

  @override
  String get selectReportMonth => 'レポート月を選択';

  @override
  String reportForBusiness(Object business) {
    return 'レポート • $business';
  }

  @override
  String get tapToChangeMonth => 'タップして月を変更';

  @override
  String csvSaved(Object path) {
    return 'CSVを保存しました: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'CSVをエクスポートできませんでした: $error';
  }

  @override
  String get aboutTitle => 'このアプリについて';

  @override
  String get aboutTagline => '動き続けるビジネスのためのわかりやすい請求書';

  @override
  String get aboutAppTitle => 'アプリ';

  @override
  String get aboutAppBody =>
      'EzInvoice は請求書、顧客、支払い、レポートを一つの簡単な流れにまとめ、大切なことを把握して安心して支払いを受けられるようにします。';

  @override
  String get aboutCompanyTitle => '会社';

  @override
  String get aboutCompanyBody =>
      'Liisgo LLC は、小規模事業者がより整理され、明確で、自信を持って働ける実用的なツールを作っています。';

  @override
  String get aboutPromiseTitle => '毎日の仕事のために';

  @override
  String get aboutPromiseBody =>
      'EzInvoice のすべての設計は、手順を減らし、詳細を見やすくし、ビジネス管理をより簡単にするためのものです。';

  @override
  String get visitLiisgo => 'Liisgo を見る';

  @override
  String get contactSupport => 'サポートに連絡';

  @override
  String get shareEzInvoice => 'EzInvoice を共有';

  @override
  String get sendIdeaOrBug => 'アイデアまたは不具合を送る';

  @override
  String get feedbackTitle => 'ご意見をお聞かせください';

  @override
  String get feedbackSubtitle => '改善したいことや、うまく動かなかったことを教えてください。';

  @override
  String get feedbackIdea => 'アイデア';

  @override
  String get feedbackBug => '不具合';

  @override
  String get feedbackHint => 'アイデアまたは起きたことを書いてください…';

  @override
  String get feedbackRequired => '送信前にメッセージを入力してください。';

  @override
  String get continueToEmail => 'メールへ進む';

  @override
  String get couldNotOpenLink => 'このリンクを開けませんでした。';

  @override
  String shareAppText(Object storeUrl) {
    return 'EzInvoice Pro：請求書、顧客、レポートを一か所で管理。\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return 'EzInvoice の$kind';
  }

  @override
  String get supportEmailSubject => 'EzInvoice サポート';

  @override
  String get changePassword => 'パスワードを変更';

  @override
  String get changePasswordSubtitle => 'アカウントのパスワードを更新します。';

  @override
  String get confirmCurrentPasswordHint => '安全のため、先に現在のパスワードを確認してください。';

  @override
  String get currentPassword => '現在のパスワード';

  @override
  String get newPassword => '新しいパスワード';

  @override
  String get confirmNewPassword => '新しいパスワードを確認';

  @override
  String get updatePassword => 'パスワードを更新';

  @override
  String get passwordAtLeastSix => '6文字以上で入力してください。';

  @override
  String get noActiveSession => 'アクティブなセッションがありません。';

  @override
  String get passwordsDoNotMatch => '新しいパスワードが一致しません。';

  @override
  String get passwordMustDiffer => '新しいパスワードは現在のものと異なる必要があります。';

  @override
  String get passwordUpdated => 'パスワードを更新しました。';

  @override
  String get incorrectPassword => '現在のパスワードが正しくありません。';

  @override
  String get weakPassword => '新しいパスワードが弱すぎます。';

  @override
  String get reauthenticationNeeded => '安全のため、もう一度サインインして再試行してください。';

  @override
  String get changePasswordError => 'パスワードを変更できませんでした。';

  @override
  String get confirmPassword => 'パスワードを確認';

  @override
  String get reauthCancelled => '再認証をキャンセルしました。';

  @override
  String get accountDeleted => 'アカウントとデータを完全に削除しました。';

  @override
  String get deleteAccountIncorrectPassword => 'パスワードが正しくありません。';

  @override
  String get deleteAccountError => 'アカウントを削除できませんでした。';

  @override
  String get deleteAccountBody =>
      'アカウントを削除すると：\n\n• 顧客、請求書、レポート、事業プロフィールが完全に削除されます。\n• この操作は元に戻せません。\n• 有効なサブスクリプションがある場合は、App Store または Google Play で管理または解約してください。';

  @override
  String get termsConditions => '利用規約';

  @override
  String get agreeTermsPrivacy => 'まず利用規約とプライバシーポリシーに同意してください。';

  @override
  String get currentPlan => '現在のプラン';

  @override
  String get currentPlanFree => '現在のプラン：無料';

  @override
  String get proPlanDescription =>
      '無料版には広告と利用制限があります。Pro では広告がなくなり、無制限の請求書、レポート、プレミアムテンプレート、エクスポート、クラウドバックアップが利用できます。';

  @override
  String get adsIncluded => '広告あり';

  @override
  String get limitedInvoicesPerMonth => '毎月の請求書数に制限';

  @override
  String get basicInvoiceStyle => '基本の請求書スタイル';

  @override
  String get basicReports => '基本レポート';

  @override
  String get pdfIncludesBranding => 'PDF に EzInvoice のブランド表示が含まれます';

  @override
  String get unpaidLabel => '未払い';

  @override
  String get loading => '読み込み中...';

  @override
  String get store => 'ストア';

  @override
  String get storeProductLoadingOne =>
      'サブスクリプション商品の一つを読み込み中です。もう一方の読み込み中も利用可能なプランで続けられます。';

  @override
  String get storeProductsLoading =>
      'ストアのサブスクリプション商品に接続しています。読み込みが完了しない場合は、ストアコンソールでサブスクリプションの準備状況を確認してください。';

  @override
  String get agreeTo => '次に同意します：';

  @override
  String get and => 'と';

  @override
  String get currentProPlanDescription =>
      'すでに Ez Invoice Pro を利用しています。下で両方のサブスクリプションオプションを確認できます。';

  @override
  String freeVsPro(Object pro) {
    return '無料版と $pro';
  }

  @override
  String get openInvoices => '請求書を開く。';

  @override
  String get allCaughtUp => 'すべて完了';

  @override
  String itemsToReview(Object count) {
    return '$count 件を確認';
  }

  @override
  String get pdfInvoice => '請求書';

  @override
  String get pdfReceipt => '領収書';

  @override
  String get pdfBusiness => '事業';

  @override
  String get pdfPhone => '電話';

  @override
  String get pdfEmail => 'メール';

  @override
  String get pdfNumber => '番号';

  @override
  String get pdfDate => '日付';

  @override
  String get pdfDue => '期限';

  @override
  String get pdfPaid => '支払い済み';

  @override
  String get pdfPaidDate => '支払日';

  @override
  String get pdfMethod => '方法';

  @override
  String get pdfBillTo => '請求先';

  @override
  String get pdfClient => '顧客';

  @override
  String get pdfDescription => '説明';

  @override
  String get pdfQuantity => '数量';

  @override
  String get pdfPrice => '価格';

  @override
  String get pdfSubtotal => '小計';

  @override
  String get pdfTax => '税';

  @override
  String pdfTaxWithRate(Object rate) {
    return '税 ($rate%)';
  }

  @override
  String get pdfTip => 'チップ';

  @override
  String pdfTipWithRate(Object rate) {
    return 'チップ ($rate%)';
  }

  @override
  String get pdfDiscount => '割引';

  @override
  String get pdfMessage => 'メッセージ';

  @override
  String get pdfPaymentNote => '支払いメモ';

  @override
  String get pdfThankYou => 'ご利用ありがとうございます。';

  @override
  String get pdfPoweredBy => 'EzInvoice 提供';

  @override
  String get pdfFreeVersion => '無料版';

  @override
  String get pdfTotal => '合計';

  @override
  String get styleMinimal => 'ミニマル';

  @override
  String get styleProfessional => 'プロフェッショナル';

  @override
  String get styleCorporate => 'コーポレート';

  @override
  String get styleModern => 'モダン';

  @override
  String get styleSlate => 'スレート';

  @override
  String get reportDocument => 'レポート';

  @override
  String get reportPrintDocument => 'レポートを印刷';

  @override
  String get reportMonth => '月';

  @override
  String get reportYear => '年';

  @override
  String get reportGeneratedOn => '作成日';

  @override
  String get reportInvoices => '請求書';

  @override
  String get reportStatus => 'ステータス';

  @override
  String get reportTotals => '合計';

  @override
  String get reportSales => '売上';

  @override
  String get reportTotalTax => '税金合計';

  @override
  String get reportTotalTip => 'チップ合計';

  @override
  String get reportTotalInvoiced => '請求総額';

  @override
  String get reportUnsent => '未送信';

  @override
  String get reportSent => '送信済み';

  @override
  String get reportPaid => '支払済み';

  @override
  String get reportOverdue => '期限超過';

  @override
  String get reportInvoiceNumber => '請求書番号';

  @override
  String get reportClient => '顧客';

  @override
  String get reportDueDate => '支払期日';

  @override
  String get reportDescription => '説明';

  @override
  String get reportDate => '日付';

  @override
  String get reportFreeVersion => '無料版';

  @override
  String get reportPoweredBy => 'EzInvoice 提供';

  @override
  String reportPdfShareText(Object title) {
    return 'PDF レポート: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'CSV レポート: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return '印刷: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'レポート_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'レポート_年_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'レポート | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'レポート | $year';
  }

  @override
  String get reportBreakdown => '内訳';

  @override
  String get reportInvoicesStatus => '請求書のステータス';

  @override
  String get viewReport => 'レポートを見る';

  @override
  String get reviewBeforeExport => 'エクスポート前に PDF または CSV を確認します。';

  @override
  String get customizeReport => 'レポートをカスタマイズ';

  @override
  String get reportPreviewUpdates => '変更はすぐにプレビューに反映されます。';

  @override
  String get yourReportPreview => 'レポートのプレビュー';

  @override
  String get reportStyleLiveHint => 'デザインを変更してすぐに確認できます。';

  @override
  String get watchAdToExportReport =>
      'このレポートをエクスポートするには広告を最後まで視聴してください。広告なしでエクスポートするには Pro にアップグレードしてください。';

  @override
  String reportExportError(Object error) {
    return 'レポートをエクスポートできませんでした: $error';
  }

  @override
  String get shareCsvFile => 'CSV ファイルを共有';

  @override
  String get shareCsvFileDescription =>
      'メール、Drive、または別のアプリで .csv 添付ファイルを共有します。';

  @override
  String get shareReportAsText => 'テキストとして共有 (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription => 'レポートの要約をテキストで送信します。';

  @override
  String get printCsv => 'CSV を印刷';

  @override
  String get printReportDescription => 'レポートを PDF テーブルとして印刷します。';

  @override
  String get reportPreview => 'プレビュー';

  @override
  String get live => 'ライブ';

  @override
  String get proFeatureUnlimitedInvoices => '請求書を無制限に';

  @override
  String get proFeatureRemovePdfBranding => 'PDF ブランディングを削除';

  @override
  String get proFeatureExportCsv => 'CSV をエクスポート';

  @override
  String get proFeaturePremiumTemplates => 'プレミアムテンプレート';

  @override
  String get proFeatureDetailedTaxReport => '詳細な税レポート';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return '無料プランでは月に最大 $limit 件の請求書を利用できます。';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'PDF から「Powered by EzInvoice」を削除します。';

  @override
  String get proFeatureExportCsvDescription => '請求書を CSV にエクスポートします。';

  @override
  String get proFeaturePremiumTemplatesDescription => 'プレミアム請求書テンプレートを解除します。';

  @override
  String get proFeatureDetailedTaxReportDescription => '詳細な税の内訳レポートを表示します。';

  @override
  String get pdfShareText => 'EzInvoice の請求書 PDF';

  @override
  String get rewardedExportTitle => 'このレポートを書き出す';

  @override
  String get watchAd => '広告を見る';

  @override
  String get rewardedAdCouldNotComplete => '広告を完了できませんでした。しばらくしてからもう一度お試しください。';
}
