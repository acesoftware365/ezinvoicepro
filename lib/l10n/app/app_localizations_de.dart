// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'Erstelle dein Konto';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get login => 'Anmelden';

  @override
  String get register => 'Konto erstellen';

  @override
  String get alreadyHaveAccount => 'Hast du bereits ein Konto?';

  @override
  String get signIn => 'Anmelden';

  @override
  String get dontHaveAccount => 'Noch kein Konto?';

  @override
  String get signUp => 'Registrieren';

  @override
  String get processing => 'Wird verarbeitet...';

  @override
  String get invalidCredentials =>
      'Gib eine gültige E-Mail und ein Passwort ein (6+ Zeichen)';

  @override
  String get authError => 'Authentifizierungsfehler';

  @override
  String get home => 'Start';

  @override
  String get clients => 'Kunden';

  @override
  String get invoices => 'Rechnungen';

  @override
  String get reports => 'Berichte';

  @override
  String get settings => 'Einstellungen';

  @override
  String get logout => 'Abmelden';

  @override
  String get business => 'Unternehmen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageDescription => 'Wähle die Sprache der App.';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'Hallo $name,\nich sende dir deine Rechnung von EzInvoice. ✅';
  }

  @override
  String get invoiceEmailSubject => 'Rechnung - EzInvoice';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get monthWord => 'Monat';

  @override
  String get planLabel => 'Plan';

  @override
  String get invoicesRemaining => 'Verbleibende Rechnungen';

  @override
  String get proUnlimitedLabel => 'PRO · Unbegrenzt';

  @override
  String get createNewInvoice => 'Neue Rechnung erstellen';

  @override
  String get limitReachedSubtitle => 'Limit erreicht • Upgrade auf Pro';

  @override
  String get createInvoiceFastSubtitle =>
      'Rechnung + PDF in Sekunden erstellen';

  @override
  String get limitReachedTitle => 'Limit erreicht';

  @override
  String get limitReachedBody =>
      'Upgrade auf Pro für unbegrenzte Rechnungen und ohne Werbung.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get monthSummaryTitle => 'Monatsübersicht';

  @override
  String get salesTitle => 'Umsatz';

  @override
  String get tipTitle => 'Trinkgeld';

  @override
  String get subtotalTitle => 'Zwischensumme';

  @override
  String get taxTitle => 'Steuer';

  @override
  String get beforeTaxTip => 'Vor Steuer/Trinkgeld';

  @override
  String get collectedThisMonth => 'Diesen Monat eingenommen';

  @override
  String get quickAccessTitle => 'Schnellzugriff';

  @override
  String get clientsManageSubtitle => 'Kunden erstellen / bearbeiten';

  @override
  String get invoicesViewSendSubtitle => 'PDF ansehen und senden';

  @override
  String get monthlyYearlySubtitle => 'Monatlich / jährlich';

  @override
  String get businessProfileSubtitle => 'Profil / Logo / Steuer';

  @override
  String invoiceCount(Object count) {
    return '$count Rechnung(en)';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'Schließen';

  @override
  String get paywallHeaderTitle => 'Schalte alles für dein Business frei';

  @override
  String get paywallHeaderSubtitle =>
      'Keine Werbung • Unbegrenzte Rechnungen • Steuerberichte • Premium-Vorlagen';

  @override
  String get bestValue => 'Bestes Angebot';

  @override
  String get proYearly => 'Pro jährlich';

  @override
  String get saveMoreYearly => 'Spare mehr mit Jahreszahlung';

  @override
  String get proMonthly => 'Pro monatlich';

  @override
  String get flexible => 'Flexibel';

  @override
  String get cancelAnytime => 'Jederzeit kündbar';

  @override
  String get processingPurchase => 'Kauf wird verarbeitet…';

  @override
  String get restoringPurchases => 'Käufe werden wiederhergestellt…';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get continueFreeWithAds =>
      'Mit kostenloser Version mit Werbung fortfahren';

  @override
  String get alreadyProTitle => 'Du bist Pro ✅';

  @override
  String get alreadyProBody =>
      'Genieße unbegrenzte Rechnungen, Berichte und keine Werbung.';

  @override
  String get continueText => 'Weiter';

  @override
  String get includesInPro => 'In Pro enthalten';

  @override
  String get benefitNoAds => 'Keine Werbung (Banner/Interstitial/Rewarded)';

  @override
  String get benefitUnlimitedInvoices =>
      'Unbegrenzte Rechnungen + Status (Entwurf/gesendet/bezahlt)';

  @override
  String get benefitPremiumTemplates =>
      'Premium-Vorlagen + Farben + Business-Logo';

  @override
  String get benefitNoWatermarkPdf => 'Professionelles PDF ohne Wasserzeichen';

  @override
  String get benefitTaxReports =>
      'Steuerberichte: monatlich & jährlich (Steuern/Trinkgeld/Netto)';

  @override
  String get benefitExport => 'Export PDF/CSV/Excel (für Buchhaltung)';

  @override
  String get benefitCloudBackup =>
      'Cloud-Backup + Wiederherstellung (Multi-Device)';

  @override
  String continueWithPlan(Object plan) {
    return 'Weiter mit $plan';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'Mit dem Abonnement wird die Zahlung deinem $store-Konto belastet. Das Abonnement verlängert sich automatisch, sofern du nicht mindestens 24 Stunden vor Ablauf des aktuellen Zeitraums kündigst. Du kannst dein Abonnement in den Einstellungen deines Stores verwalten oder kündigen.';
  }

  @override
  String get reportsTitle => 'Berichte';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'Nach Monat';

  @override
  String get byYear => 'Nach Jahr';

  @override
  String get monthLabel => 'Monat';

  @override
  String get yearLabel => 'Jahr';

  @override
  String get businessProfileTitle => 'Business-Profil';

  @override
  String get save => 'Speichern';

  @override
  String get uploadLogo => 'Logo hochladen';

  @override
  String get remove => 'Entfernen';

  @override
  String get businessNameLabel => 'Firmenname';

  @override
  String get ownerNameLabel => 'Inhaber / Kontaktname';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get addressLabel => 'Adresse';

  @override
  String get currencyLabel => 'Währung';

  @override
  String get taxDefaultLabel => 'Standardsteuer (%)';

  @override
  String get invalidNumber => 'Ungültige Zahl';

  @override
  String get range0to100 => 'Muss zwischen 0 und 100 liegen';

  @override
  String get requiredField => 'Erforderlich';

  @override
  String get footerNoteLabel => 'Fußzeile (PDF)';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get businessFooterDefault => 'Vielen Dank für Ihr Vertrauen.';

  @override
  String get businessSavedSuccess => 'Business-Profil erfolgreich gespeichert';

  @override
  String get businessInfoSection => 'Business-Informationen';

  @override
  String get settingsSection => 'Einstellungen';

  @override
  String get footerSection => 'Fußzeile (PDF)';

  @override
  String get upgradeToPro => 'Upgrade auf Pro';

  @override
  String get bestValueStar => '⭐ Bestes Angebot';

  @override
  String get invoicesTitle => 'Rechnungen';

  @override
  String get noInvoicesYet => 'Noch keine Rechnungen.';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'Kostenloser Plan: Monatslimit $limit Rechnungen • Upgrade für unbegrenzt';
  }

  @override
  String get filtersTitle => 'Filter';

  @override
  String get clientLabel => 'Kunde';

  @override
  String get allMonths => 'Alle Monate';

  @override
  String get allClients => 'Alle Kunden';

  @override
  String get clear => 'Zurücksetzen';

  @override
  String get invoicesSummaryLabel => 'Rechnungen';

  @override
  String get totalTitle => 'Gesamt';

  @override
  String get dateLabel => 'Datum';

  @override
  String get noResultsForFilters =>
      'Keine Ergebnisse für die ausgewählten Filter.';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'Kostenloser Plan: $current / $limit Rechnungen diesen Monat.\n\nUpgrade auf Pro für unbegrenzt.';
  }

  @override
  String get deleteInvoiceTitle => 'Rechnung löschen?';

  @override
  String deleteInvoiceBody(Object invNo) {
    return 'Möchtest du $invNo wirklich löschen?';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get sendPdf => 'PDF senden';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'Rechnung $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'Fehler beim Erstellen/Senden des PDFs: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'Bericht • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'Bericht • Jahr $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'Rechnungen: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'Umsatz gesamt: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'Steuer gesamt: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'Trinkgeld gesamt: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'Netto: \$$amount';
  }

  @override
  String get calculatedFromInvoices =>
      'Aus deinen Rechnungen in Firestore berechnet.';

  @override
  String get noInvoicesInPeriod => 'Keine Rechnungen in diesem Zeitraum.';

  @override
  String get exportPdf => 'PDF exportieren';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get yearlyProReason =>
      'Jahresbericht ist PRO. Upgrade zum Freischalten.';

  @override
  String get exportPdfProReason => 'PDF-Export des Berichts ist PRO.';

  @override
  String get exportCsvProReason => 'CSV-Export ist PRO.';

  @override
  String get noDataToExport => 'Keine Daten zum Exportieren.';

  @override
  String get freePlanReportsNote =>
      'Kostenloser Plan: nur Monatsberichte. Upgrade für Jahresberichte und Export.';

  @override
  String get genericError =>
      'Etwas ist schiefgelaufen. Bitte erneut versuchen.';

  @override
  String get newInvoiceTitle => 'Neue Rechnung';

  @override
  String get editInvoiceTitle => 'Rechnung bearbeiten';

  @override
  String get pickClient => 'Kunden auswählen';

  @override
  String get invoiceAutoNumberLabel => 'Rechnung # (auto)';

  @override
  String invoiceDateLabel(Object date) {
    return 'Rechnungsdatum: $date';
  }

  @override
  String get clientNameLabel => 'Kundenname';

  @override
  String get clientNameRequired => 'Kundenname erforderlich';

  @override
  String get clientEmailOptionalLabel => 'Kunden-E-Mail (optional)';

  @override
  String get clientPhoneOptionalLabel => 'Kundentelefon (optional)';

  @override
  String get invalidEmailFormat => 'Ungültiges E-Mail-Format';

  @override
  String get itemsTitle => 'Positionen';

  @override
  String get descriptionLabel => 'Beschreibung';

  @override
  String itemDateLabel(Object date) {
    return 'Positionsdatum: $date';
  }

  @override
  String get qtyLabel => 'Menge';

  @override
  String get priceLabel => 'Preis';

  @override
  String lineTotalLabel(Object amount) {
    return 'Positionssumme: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'Steuer % (Standard-Inhaber)';

  @override
  String get tipPercentChip => 'Trinkgeld %';

  @override
  String get tipAmountChip => 'Trinkgeld \$';

  @override
  String get tipPercentLabel => 'Trinkgeld-Prozent (%)';

  @override
  String get tipAmountLabel => 'Trinkgeldbetrag (\$)';

  @override
  String get messageOptionalLabel => 'Nachricht (optional)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'Zwischensumme: \$$sub\nSteuer: \$$tax\nTrinkgeld: \$$tip\nGesamt: \$$total';
  }

  @override
  String get saving => 'Speichern…';

  @override
  String get saveInvoice => 'Rechnung speichern';

  @override
  String get updateInvoice => 'Rechnung aktualisieren';

  @override
  String get addAtLeastOneItem => 'Füge mindestens 1 Position hinzu';

  @override
  String errorSavingInvoice(Object error) {
    return 'Fehler beim Speichern: $error';
  }

  @override
  String get savedTab => 'Gespeichert';

  @override
  String get contactsTab => 'Kontakte';

  @override
  String get noSavedClients => 'Keine gespeicherten Kunden';

  @override
  String get permissionDeniedContacts => 'Berechtigung verweigert: Kontakte';

  @override
  String get noContactsFound =>
      'Keine Kontakte auf diesem Gerät/Emulator gefunden';

  @override
  String contactsError(Object error) {
    return 'Kontaktfehler: $error';
  }

  @override
  String get noName => '(Kein Name)';

  @override
  String get newClientTitle => 'Neuer Kunde';

  @override
  String get editClientTitle => 'Kunde bearbeiten';

  @override
  String get clientInfoSection => 'Kundeninformationen';

  @override
  String get notesLabel => 'Notizen';

  @override
  String get notesHint => 'Notizen hinzufügen (optional)';

  @override
  String get clientCreateHint =>
      'Tipp: E-Mail/Telefon hinzufügen, um Rechnungen schneller zu senden.';

  @override
  String get clientEditHint => 'Du kannst Kundendaten jederzeit aktualisieren.';

  @override
  String errorSavingClient(Object error) {
    return 'Fehler beim Speichern des Kunden: $error';
  }

  @override
  String get clientsTitle => 'Kunden';

  @override
  String get searchClientsLabel => 'Kunden suchen';

  @override
  String clientsCount(Object count) {
    return '$count Kunde(n)';
  }

  @override
  String get noClientsYet => 'Noch keine Kunden.';

  @override
  String get noClientsForSearch => 'Keine Kunden passen zu deiner Suche.';

  @override
  String get cannotOpenDialer => 'Wähltastatur kann nicht geöffnet werden';

  @override
  String get cannotOpenSms => 'SMS kann nicht geöffnet werden';

  @override
  String get whatsAppNotAvailable => 'WhatsApp nicht verfügbar';

  @override
  String get cannotOpenEmail => 'E-Mail kann nicht geöffnet werden';

  @override
  String get deleteClientTitle => 'Kunde löschen?';

  @override
  String deleteClientBody(Object name) {
    return '$name entfernen?';
  }

  @override
  String get call => 'Anrufen';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'E-Mail';

  @override
  String get shareAppTitle => 'Probiere EzInvoice 👇';

  @override
  String get shareAppBody =>
      'Rechnungen erstellen, PDFs senden und Berichte einfach verfolgen.';

  @override
  String get shareAppTooltip => 'App teilen';

  @override
  String get openGooglePlayTooltip => 'Google Play öffnen';

  @override
  String get openAppStoreTooltip => 'App Store öffnen';

  @override
  String get openWebsiteTooltip => 'Website öffnen';

  @override
  String get availableLanguages => 'Verfügbare Sprachen';

  @override
  String get usePhoneLanguage => 'Gerätesprache verwenden';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'Beleg $invoiceNumber für $clientName';
  }

  @override
  String get report => 'Bericht';

  @override
  String get invoicesLabel => 'Rechnungen';

  @override
  String get totalSalesLabel => 'Umsatz gesamt';

  @override
  String get totalTaxLabel => 'Steuer gesamt';

  @override
  String get totalTipLabel => 'Trinkgeld gesamt';

  @override
  String get netLabel => 'Netto';

  @override
  String get sentLabel => 'Gesendet';

  @override
  String get paidLabel => 'Bezahlt';

  @override
  String get overdueLabel => 'Überfällig';

  @override
  String get reportCalculatedHint =>
      'Aus deinen Rechnungen in Firestore berechnet.';

  @override
  String get exportPdfComingSoon => 'PDF exportieren (kommt bald)';

  @override
  String get exportCsvComingSoon => 'CSV exportieren (kommt bald)';

  @override
  String get unsentLabel => 'Nicht gesendet';

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
  String get deleteAccountTitle => 'Konto löschen';

  @override
  String get deleteAccountWarning =>
      'Diese Aktion löscht Ihr Konto und alle zugehörigen Daten dauerhaft.';

  @override
  String get deleteAccountButton => 'Konto löschen';

  @override
  String get deleteAccountConfirmTitle => 'Löschen bestätigen';

  @override
  String get deleteAccountConfirmMessage =>
      'Sind Sie sicher? Diese Aktion kann nicht rückgängig gemacht werden.';
}
