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
  String get reportCalculatedHint => 'Aus deinen Rechnungen berechnet.';

  @override
  String get exportPdfComingSoon => 'PDF exportieren (kommt bald)';

  @override
  String get exportCsvComingSoon => 'CSV exportieren (kommt bald)';

  @override
  String get unsentLabel => 'Nicht gesendet';

  @override
  String get servicePresetsTitle => 'Gespeicherte Dienste';

  @override
  String get servicePresetsScreenTitle => 'Gespeicherte Dienste';

  @override
  String get servicePresetsAddNew => 'Neuen Dienst hinzufügen';

  @override
  String get servicePresetsHint => 'z. B. Reinigung, Reparatur, Beratung...';

  @override
  String get servicePresetsAddButton => 'Hinzufügen';

  @override
  String get addServiceLabel => 'Dienst hinzufügen';

  @override
  String get yourPresets => 'Ihre gespeicherten Dienste';

  @override
  String get noPresetsYet => 'Noch keine gespeicherten Dienste.';

  @override
  String get notNow => 'Jetzt nicht';

  @override
  String get openPaywallPlaceholder => 'Abonnements öffnen';

  @override
  String get invoiceStyleTitle => 'Rechnungsstil';

  @override
  String get invoiceFreeStyleHint =>
      'Der kostenlose Plan verwendet eine Rechnungsversion (Minimal). Wechseln Sie zu Pro, um alle Layouts und Paletten freizuschalten.';

  @override
  String get invoicePaletteLabel => 'Rechnungspalette';

  @override
  String get invoiceLayoutLabel => 'Rechnungslayout';

  @override
  String get saveInvoicePaletteError =>
      'Rechnungspalette konnte nicht gespeichert werden.';

  @override
  String get saveInvoiceLayoutError =>
      'Rechnungslayout konnte nicht gespeichert werden.';

  @override
  String get reportStyleTitle => 'Berichtsstil';

  @override
  String get reportFreeStyleHint =>
      'Der kostenlose Plan verwendet eine Berichtsversion (Minimal). Wechseln Sie zu Pro, um alle Layouts und Paletten freizuschalten.';

  @override
  String get reportPaletteLabel => 'Berichtspalette';

  @override
  String get reportLayoutLabel => 'Berichtslayout';

  @override
  String get saveReportPaletteError =>
      'Berichtspalette konnte nicht gespeichert werden.';

  @override
  String get saveReportLayoutError =>
      'Berichtslayout konnte nicht gespeichert werden.';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return 'Stil von $docType: $style | Palette: $palette';
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

  @override
  String get profileSaved => 'Automatisch gespeichert';

  @override
  String get profileSaveError =>
      'Speichern fehlgeschlagen. Ihre Änderungen sind noch hier.';

  @override
  String get profileRetry => 'Erneut versuchen';

  @override
  String get profileAutosaveHint =>
      'Änderungen werden automatisch gespeichert und beim Schließen beibehalten.';

  @override
  String get profileLogo => 'Firmenlogo';

  @override
  String get profileDefaults => 'Rechnungsvorgaben';

  @override
  String get profileTaxInvalid => 'Steuersatz prüfen (0–100 %).';

  @override
  String get metricLoadError =>
      'Bericht konnte nicht geladen werden. Bitte erneut versuchen.';

  @override
  String get totalInvoicedTitle => 'Rechnungsbetrag gesamt';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get rememberEmail => 'Meine E-Mail merken';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get passwordResetEnterEmail =>
      'Gib deine E-Mail-Adresse ein, um den Link zum Zurücksetzen zu erhalten.';

  @override
  String get passwordResetSent =>
      'Wir haben dir eine E-Mail zum Zurücksetzen des Passworts gesendet. Prüfe auch den Spam-Ordner.';

  @override
  String get passwordResetNoAccount =>
      'Für diese E-Mail wurde kein Konto gefunden.';

  @override
  String get invalidEmail => 'Ungültige E-Mail-Adresse.';

  @override
  String get passwordResetError =>
      'Die E-Mail konnte nicht gesendet werden. Versuche es erneut.';

  @override
  String get updateRequired => 'Aktualisierung erforderlich';

  @override
  String get updateRequiredBody =>
      'Eine neue Version von Ez Invoice ist verfügbar. Aktualisiere die App im Store, um fortzufahren.';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get open => 'Öffnen';

  @override
  String get share => 'Teilen';

  @override
  String get actions => 'Aktionen';

  @override
  String get message => 'Nachricht';

  @override
  String get done => 'Fertig';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get free => 'KOSTENLOS';

  @override
  String get clientInformation => 'Kundeninformationen';

  @override
  String get clientName => 'Kundenname';

  @override
  String get notesOptional => 'Notizen (optional)';

  @override
  String get saveClient => 'Kunden speichern';

  @override
  String get importFromContacts => 'Aus Kontakten importieren';

  @override
  String get importContactsDescription =>
      'Name, Telefon und E-Mail sofort ausfüllen.';

  @override
  String get loadContacts => 'Kontakte laden';

  @override
  String get clientPhone => 'Telefon des Kunden';

  @override
  String get searchContacts => 'Kontakte suchen';

  @override
  String get shareClient => 'Kunden teilen';

  @override
  String get clientProfile => 'Kundenprofil';

  @override
  String get chooseSavedService => 'Gespeicherten Service wählen';

  @override
  String get searchSavedServices => 'Gespeicherte Services suchen';

  @override
  String get noSavedServicesFound => 'Keine gespeicherten Services gefunden';

  @override
  String get noSavedServicesToUse =>
      'Noch keine Services gespeichert. Gib oben einen ein und speichere ihn für später.';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'Bereits gespeichert: $service';
  }

  @override
  String savedService(Object service) {
    return 'Service gespeichert: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'Der Service konnte nicht gespeichert werden: $error';
  }

  @override
  String get saveServiceForLater => 'Service für später speichern';

  @override
  String get removeClient => 'Kunden entfernen';

  @override
  String get service => 'Leistung';

  @override
  String get taxAndTip => 'Steuer und Trinkgeld';

  @override
  String get totals => 'Summen';

  @override
  String dueDate(Object date) {
    return 'Fällig am: $date';
  }

  @override
  String paidDate(Object date) {
    return 'Zahlungsdatum: $date';
  }

  @override
  String get notPaidYet => 'Noch nicht bezahlt';

  @override
  String paymentMethodWithValue(Object method) {
    return 'Methode: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'Notiz: $note';
  }

  @override
  String get markAsPaid => 'Als bezahlt markieren';

  @override
  String get markAsUnpaid => 'Als unbezahlt markieren';

  @override
  String get editTax => 'Bearbeiten';

  @override
  String get addClient => 'Kunden hinzufügen';

  @override
  String get firstClientHint =>
      'Erstelle deinen ersten Kunden, um ihn für künftige Rechnungen zu verwenden.';

  @override
  String get searchSavedClients => 'Gespeicherte Kunden suchen';

  @override
  String get paymentMethod => 'Zahlungsmethode';

  @override
  String get cash => 'Bar';

  @override
  String get card => 'Karte';

  @override
  String get check => 'Scheck';

  @override
  String get other => 'Andere';

  @override
  String get noteOptional => 'Notiz (optional)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'Die Rechnung konnte nicht als bezahlt markiert werden: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'Die Rechnung konnte nicht als unbezahlt markiert werden: $error';
  }

  @override
  String deleteError(Object error) {
    return 'Die Rechnung konnte nicht gelöscht werden: $error';
  }

  @override
  String get invoiceDeleted => 'Rechnung gelöscht';

  @override
  String get invoiceMarkedSent => 'Als gesendet markiert ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'Konnte nicht als gesendet markiert werden: $error';
  }

  @override
  String get invoiceMarkedUnsent => 'Als nicht gesendet markiert ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'Konnte nicht als nicht gesendet markiert werden: $error';
  }

  @override
  String get invoiceMarkedPaid => 'Als bezahlt markiert ✅';

  @override
  String get invoiceMarkedUnpaid => 'Als unbezahlt markiert ✅';

  @override
  String get invoiceLoadingError => 'Rechnungen konnten nicht geladen werden';

  @override
  String get tipType => 'Trinkgeldart';

  @override
  String get amountOption => 'Betrag (\$)';

  @override
  String get percentageOption => 'Prozentsatz (%)';

  @override
  String get pdfPreview => 'PDF-Vorschau';

  @override
  String get openPdf => 'PDF öffnen';

  @override
  String get sharePdf => 'PDF teilen';

  @override
  String get selectReportMonth => 'Berichtsmonat auswählen';

  @override
  String reportForBusiness(Object business) {
    return 'Berichte • $business';
  }

  @override
  String get tapToChangeMonth => 'Tippen, um den Monat zu ändern';

  @override
  String csvSaved(Object path) {
    return 'CSV gespeichert: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'CSV konnte nicht exportiert werden: $error';
  }

  @override
  String get aboutTitle => 'Über';

  @override
  String get aboutTagline => 'Klare Rechnungen für Unternehmen in Bewegung';

  @override
  String get aboutAppTitle => 'Die App';

  @override
  String get aboutAppBody =>
      'EzInvoice vereint Rechnungen, Kunden, Zahlungen und Berichte in einem einfachen Ablauf, damit du den Überblick behältst und sicher bezahlt wirst.';

  @override
  String get aboutCompanyTitle => 'Das Unternehmen';

  @override
  String get aboutCompanyBody =>
      'Liisgo LLC entwickelt praktische Werkzeuge, die kleinen Unternehmen helfen, geordneter, klarer und sicherer zu arbeiten.';

  @override
  String get aboutPromiseTitle => 'Für deinen Alltag gemacht';

  @override
  String get aboutPromiseBody =>
      'Jede Entscheidung in EzInvoice soll Schritte reduzieren, Details sichtbar halten und die Führung deines Unternehmens einfacher machen.';

  @override
  String get visitLiisgo => 'Liisgo besuchen';

  @override
  String get contactSupport => 'Support kontaktieren';

  @override
  String get shareEzInvoice => 'EzInvoice teilen';

  @override
  String get sendIdeaOrBug => 'Idee oder Fehler senden';

  @override
  String get feedbackTitle => 'Dein Feedback zählt';

  @override
  String get feedbackSubtitle =>
      'Sag uns, was du verbessern würdest oder was nicht gut funktioniert hat.';

  @override
  String get feedbackIdea => 'Idee';

  @override
  String get feedbackBug => 'Fehler';

  @override
  String get feedbackHint =>
      'Schreibe deine Idee oder erkläre, was passiert ist…';

  @override
  String get feedbackRequired => 'Schreibe vor dem Senden eine Nachricht.';

  @override
  String get continueToEmail => 'Weiter zur E-Mail';

  @override
  String get couldNotOpenLink => 'Dieser Link konnte nicht geöffnet werden.';

  @override
  String shareAppText(Object storeUrl) {
    return 'Entdecke EzInvoice Pro: Rechnungen, Kunden und Berichte an einem Ort.\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return '$kind für EzInvoice';
  }

  @override
  String get supportEmailSubject => 'EzInvoice-Support';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get changePasswordSubtitle => 'Aktualisiere dein Kontopasswort.';

  @override
  String get confirmCurrentPasswordHint =>
      'Bestätige aus Sicherheitsgründen zuerst dein aktuelles Passwort.';

  @override
  String get currentPassword => 'Aktuelles Passwort';

  @override
  String get newPassword => 'Neues Passwort';

  @override
  String get confirmNewPassword => 'Neues Passwort bestätigen';

  @override
  String get updatePassword => 'Passwort aktualisieren';

  @override
  String get passwordAtLeastSix => 'Muss mindestens 6 Zeichen lang sein.';

  @override
  String get noActiveSession => 'Keine aktive Sitzung.';

  @override
  String get passwordsDoNotMatch => 'Das neue Passwort stimmt nicht überein.';

  @override
  String get passwordMustDiffer => 'Das neue Passwort muss anders sein.';

  @override
  String get passwordUpdated => 'Passwort wurde erfolgreich aktualisiert.';

  @override
  String get incorrectPassword => 'Das aktuelle Passwort ist falsch.';

  @override
  String get weakPassword => 'Das neue Passwort ist zu schwach.';

  @override
  String get reauthenticationNeeded =>
      'Melde dich aus Sicherheitsgründen erneut an und versuche es noch einmal.';

  @override
  String get changePasswordError =>
      'Das Passwort konnte nicht geändert werden.';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get reauthCancelled => 'Erneute Anmeldung abgebrochen.';

  @override
  String get accountDeleted =>
      'Dein Konto und deine Daten wurden dauerhaft gelöscht.';

  @override
  String get deleteAccountIncorrectPassword => 'Falsches Passwort.';

  @override
  String get deleteAccountError => 'Das Konto konnte nicht gelöscht werden.';

  @override
  String get deleteAccountBody =>
      'Wenn du dein Konto löschst:\n\n• Deine Kunden, Rechnungen, Berichte und dein Geschäftsprofil werden dauerhaft gelöscht.\n• Diese Aktion kann nicht rückgängig gemacht werden.\n• Falls du ein aktives Abo hast, verwalte oder kündige es im App Store/bei Google Play.';

  @override
  String get termsConditions => 'Nutzungsbedingungen';

  @override
  String get agreeTermsPrivacy =>
      'Bitte stimme zuerst den Nutzungsbedingungen und der Datenschutzerklärung zu.';

  @override
  String get currentPlan => 'Aktueller Tarif';

  @override
  String get currentPlanFree => 'Aktueller Tarif: Kostenlos';

  @override
  String get proPlanDescription =>
      'Die kostenlose Version enthält Werbung und eingeschränkte Nutzung. Pro entfernt Werbung und schaltet unbegrenzte Rechnungen, Berichte, Premiumvorlagen, Exporte und Cloud-Backup frei.';

  @override
  String get adsIncluded => 'Werbung enthalten';

  @override
  String get limitedInvoicesPerMonth => 'Begrenzte Rechnungen pro Monat';

  @override
  String get basicInvoiceStyle => 'Einfacher Rechnungsstil';

  @override
  String get basicReports => 'Einfache Berichte';

  @override
  String get pdfIncludesBranding => 'PDF enthält EzInvoice-Branding';

  @override
  String get unpaidLabel => 'Unbezahlt';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get store => 'Store';

  @override
  String get storeProductLoadingOne =>
      'Ein Aboprodukt wird noch geladen. Du kannst mit dem verfügbaren Tarif fortfahren, während das andere Produkt geladen wird.';

  @override
  String get storeProductsLoading =>
      'Verbindung zu den Aboprodukten im Store wird hergestellt. Wenn das Laden nicht abgeschlossen wird, prüfe in deiner Store-Konsole, ob die Abos bereit sind.';

  @override
  String get agreeTo => 'Ich stimme den ';

  @override
  String get and => ' und die ';

  @override
  String get currentProPlanDescription =>
      'Du hast bereits Ez Invoice Pro. Du kannst unten beide Abooptionen prüfen.';

  @override
  String freeVsPro(Object pro) {
    return 'Kostenlos vs $pro';
  }

  @override
  String get openInvoices => 'Rechnungen öffnen.';

  @override
  String get allCaughtUp => 'Alles erledigt';

  @override
  String itemsToReview(Object count) {
    return '$count zu prüfen';
  }

  @override
  String get pdfInvoice => 'Rechnung';

  @override
  String get pdfReceipt => 'Beleg';

  @override
  String get pdfBusiness => 'Unternehmen';

  @override
  String get pdfPhone => 'Telefon';

  @override
  String get pdfEmail => 'E-Mail';

  @override
  String get pdfNumber => 'Nr.';

  @override
  String get pdfDate => 'Datum';

  @override
  String get pdfDue => 'Fällig';

  @override
  String get pdfPaid => 'Bezahlt';

  @override
  String get pdfPaidDate => 'Zahlungsdatum';

  @override
  String get pdfMethod => 'Methode';

  @override
  String get pdfBillTo => 'Rechnung an';

  @override
  String get pdfClient => 'Kunde';

  @override
  String get pdfDescription => 'Beschreibung';

  @override
  String get pdfQuantity => 'Menge';

  @override
  String get pdfPrice => 'Preis';

  @override
  String get pdfSubtotal => 'Zwischensumme';

  @override
  String get pdfTax => 'Steuer';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'Steuer ($rate%)';
  }

  @override
  String get pdfTip => 'Trinkgeld';

  @override
  String pdfTipWithRate(Object rate) {
    return 'Trinkgeld ($rate%)';
  }

  @override
  String get pdfDiscount => 'Rabatt';

  @override
  String get pdfMessage => 'Nachricht';

  @override
  String get pdfPaymentNote => 'Zahlungshinweis';

  @override
  String get pdfThankYou => 'Vielen Dank für Ihren Auftrag.';

  @override
  String get pdfPoweredBy => 'Bereitgestellt von EzInvoice';

  @override
  String get pdfFreeVersion => 'KOSTENLOSE VERSION';

  @override
  String get pdfTotal => 'Gesamt';

  @override
  String get styleMinimal => 'Minimal';

  @override
  String get styleProfessional => 'Professionell';

  @override
  String get styleCorporate => 'Unternehmen';

  @override
  String get styleModern => 'Modern';

  @override
  String get styleSlate => 'Schiefer';

  @override
  String get reportDocument => 'Bericht';

  @override
  String get reportPrintDocument => 'Bericht drucken';

  @override
  String get reportMonth => 'Monat';

  @override
  String get reportYear => 'Jahr';

  @override
  String get reportGeneratedOn => 'Erstellt am';

  @override
  String get reportInvoices => 'Rechnungen';

  @override
  String get reportStatus => 'Status';

  @override
  String get reportTotals => 'Summen';

  @override
  String get reportSales => 'Umsatz';

  @override
  String get reportTotalTax => 'Gesamtsteuer';

  @override
  String get reportTotalTip => 'Gesamttrinkgeld';

  @override
  String get reportTotalInvoiced => 'Gesamt in Rechnung gestellt';

  @override
  String get reportUnsent => 'Nicht gesendet';

  @override
  String get reportSent => 'Gesendet';

  @override
  String get reportPaid => 'Bezahlt';

  @override
  String get reportOverdue => 'Überfällig';

  @override
  String get reportInvoiceNumber => 'Rechnungsnr.';

  @override
  String get reportClient => 'Kunde';

  @override
  String get reportDueDate => 'Fälligkeitsdatum';

  @override
  String get reportDescription => 'Beschreibung';

  @override
  String get reportDate => 'Datum';

  @override
  String get reportFreeVersion => 'KOSTENLOSE VERSION';

  @override
  String get reportPoweredBy => 'Bereitgestellt von EzInvoice';

  @override
  String reportPdfShareText(Object title) {
    return 'PDF-Bericht: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'CSV-Bericht: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'Drucken: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'Bericht_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'Bericht_Jahr_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'Bericht | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'Bericht | $year';
  }

  @override
  String get reportBreakdown => 'Aufschlüsselung';

  @override
  String get reportInvoicesStatus => 'Rechnungsstatus';

  @override
  String get viewReport => 'Bericht ansehen';

  @override
  String get reviewBeforeExport =>
      'Prüfen Sie die PDF- oder CSV-Datei vor dem Export.';

  @override
  String get customizeReport => 'Bericht anpassen';

  @override
  String get reportPreviewUpdates =>
      'Änderungen erscheinen sofort in Ihrer Vorschau.';

  @override
  String get yourReportPreview => 'Ihre Berichtsvorschau';

  @override
  String get reportStyleLiveHint =>
      'Ändern Sie das Design und sehen Sie es sofort.';

  @override
  String get watchAdToExportReport =>
      'Sehen Sie die vollständige Werbung, um diesen Bericht zu exportieren. Wechseln Sie zu Pro, um ohne Werbung zu exportieren.';

  @override
  String reportExportError(Object error) {
    return 'Bericht konnte nicht exportiert werden: $error';
  }

  @override
  String get shareCsvFile => 'CSV-Datei teilen';

  @override
  String get shareCsvFileDescription =>
      'Teilen Sie den .csv-Anhang per E-Mail, Drive oder einer anderen App.';

  @override
  String get shareReportAsText => 'Als Text teilen (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription =>
      'Senden Sie eine Berichtszusammenfassung als Text.';

  @override
  String get printCsv => 'CSV drucken';

  @override
  String get printReportDescription =>
      'Drucken Sie den Bericht als PDF-Tabelle.';

  @override
  String get reportPreview => 'Vorschau';

  @override
  String get live => 'Live';

  @override
  String get proFeatureUnlimitedInvoices => 'Unbegrenzte Rechnungen';

  @override
  String get proFeatureRemovePdfBranding => 'PDF-Kennzeichnung entfernen';

  @override
  String get proFeatureExportCsv => 'CSV exportieren';

  @override
  String get proFeaturePremiumTemplates => 'Premiumvorlagen';

  @override
  String get proFeatureDetailedTaxReport => 'Detaillierter Steuerbericht';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'Der kostenlose Plan erlaubt bis zu $limit Rechnungen pro Monat.';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'Entfernt „Bereitgestellt von EzInvoice“ aus PDFs.';

  @override
  String get proFeatureExportCsvDescription =>
      'Exportieren Sie Ihre Rechnungen als CSV.';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'Schalten Sie Premium-Rechnungsvorlagen frei.';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'Sehen Sie detaillierte Steueraufschlüsselungen.';

  @override
  String get pdfShareText => 'Rechnungs-PDF von EzInvoice';

  @override
  String get rewardedExportTitle => 'Diesen Bericht exportieren';

  @override
  String get watchAd => 'Anzeige ansehen';

  @override
  String get rewardedAdCouldNotComplete =>
      'Die Anzeige konnte nicht abgeschlossen werden. Bitte versuchen Sie es gleich noch einmal.';
}
