// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'Créez votre compte';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get login => 'Se connecter';

  @override
  String get register => 'Créer un compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get signIn => 'Se connecter';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get processing => 'Traitement...';

  @override
  String get invalidCredentials =>
      'Entrez un e-mail valide et un mot de passe (6+ caractères)';

  @override
  String get authError => 'Erreur d\'authentification';

  @override
  String get home => 'Accueil';

  @override
  String get clients => 'Clients';

  @override
  String get invoices => 'Factures';

  @override
  String get reports => 'Rapports';

  @override
  String get settings => 'Paramètres';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get business => 'Entreprise';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageDescription =>
      'Choisissez la langue de l\'application.';

  @override
  String get systemDefault => 'Langue du système';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'Bonjour $name,\nvoici votre facture envoyée depuis EzInvoice. ✅';
  }

  @override
  String get invoiceEmailSubject => 'Facture - EzInvoice';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get monthWord => 'Mois';

  @override
  String get planLabel => 'Forfait';

  @override
  String get invoicesRemaining => 'Factures restantes';

  @override
  String get proUnlimitedLabel => 'PRO · Illimité';

  @override
  String get createNewInvoice => 'Créer une nouvelle facture';

  @override
  String get limitReachedSubtitle => 'Limite atteinte • Passez à Pro';

  @override
  String get createInvoiceFastSubtitle =>
      'Créez une facture + PDF en quelques secondes';

  @override
  String get limitReachedTitle => 'Limite atteinte';

  @override
  String get limitReachedBody =>
      'Passez à Pro pour des factures illimitées et sans publicités.';

  @override
  String get upgrade => 'Passer à Pro';

  @override
  String get monthSummaryTitle => 'Résumé du mois';

  @override
  String get salesTitle => 'Ventes';

  @override
  String get tipTitle => 'Pourboire';

  @override
  String get subtotalTitle => 'Sous-total';

  @override
  String get taxTitle => 'Taxe';

  @override
  String get beforeTaxTip => 'Avant taxe/pourboire';

  @override
  String get collectedThisMonth => 'Collecté ce mois-ci';

  @override
  String get quickAccessTitle => 'Accès rapide';

  @override
  String get clientsManageSubtitle => 'Créer / modifier des clients';

  @override
  String get invoicesViewSendSubtitle => 'Voir et envoyer le PDF';

  @override
  String get monthlyYearlySubtitle => 'Mensuel / annuel';

  @override
  String get businessProfileSubtitle => 'Profil / logo / taxe';

  @override
  String invoiceCount(Object count) {
    return '$count facture(s)';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'Fermer';

  @override
  String get paywallHeaderTitle => 'Débloquez tout pour votre entreprise';

  @override
  String get paywallHeaderSubtitle =>
      'Sans pubs • Factures illimitées • Rapports de taxes • Modèles premium';

  @override
  String get bestValue => 'Meilleure offre';

  @override
  String get proYearly => 'Pro annuel';

  @override
  String get saveMoreYearly => 'Économisez en payant à l\'année';

  @override
  String get proMonthly => 'Pro mensuel';

  @override
  String get flexible => 'Flexible';

  @override
  String get cancelAnytime => 'Annulez à tout moment';

  @override
  String get processingPurchase => 'Traitement de l\'achat…';

  @override
  String get restoringPurchases => 'Restauration des achats…';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get continueFreeWithAds =>
      'Continuer avec la version gratuite avec pubs';

  @override
  String get alreadyProTitle => 'Vous êtes Pro ✅';

  @override
  String get alreadyProBody =>
      'Profitez de factures illimitées, des rapports et sans pubs.';

  @override
  String get continueText => 'Continuer';

  @override
  String get includesInPro => 'Inclus dans Pro';

  @override
  String get benefitNoAds => 'Sans pubs (Bannière/Interstitial/Rewarded)';

  @override
  String get benefitUnlimitedInvoices =>
      'Factures illimitées + statuts (brouillon/envoyée/payée)';

  @override
  String get benefitPremiumTemplates =>
      'Modèles premium + couleurs + logo d\'entreprise';

  @override
  String get benefitNoWatermarkPdf => 'PDF professionnel sans filigrane';

  @override
  String get benefitTaxReports =>
      'Rapports de taxes : mensuels et annuels (taxes/pourboires/net)';

  @override
  String get benefitExport => 'Exporter PDF/CSV/Excel (comptabilité)';

  @override
  String get benefitCloudBackup =>
      'Sauvegarde cloud + restauration (multi-appareils)';

  @override
  String continueWithPlan(Object plan) {
    return 'Continuer avec $plan';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'En vous abonnant, le paiement sera facturé à votre compte $store. L\'abonnement se renouvelle automatiquement sauf annulation au moins 24 heures avant la fin de la période en cours. Vous pouvez gérer ou annuler votre abonnement dans les paramètres de votre boutique.';
  }

  @override
  String get reportsTitle => 'Rapports';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'Par mois';

  @override
  String get byYear => 'Par an';

  @override
  String get monthLabel => 'Mois';

  @override
  String get yearLabel => 'Année';

  @override
  String get businessProfileTitle => 'Profil d\'entreprise';

  @override
  String get save => 'Enregistrer';

  @override
  String get uploadLogo => 'Téléverser le logo';

  @override
  String get remove => 'Supprimer';

  @override
  String get businessNameLabel => 'Nom de l\'entreprise';

  @override
  String get ownerNameLabel => 'Propriétaire / contact';

  @override
  String get phoneLabel => 'Téléphone';

  @override
  String get addressLabel => 'Adresse';

  @override
  String get currencyLabel => 'Devise';

  @override
  String get taxDefaultLabel => 'Taxe par défaut (%)';

  @override
  String get invalidNumber => 'Nombre invalide';

  @override
  String get range0to100 => 'Doit être entre 0 et 100';

  @override
  String get requiredField => 'Requis';

  @override
  String get footerNoteLabel => 'Note de bas de page (PDF)';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get businessFooterDefault => 'Merci pour votre confiance.';

  @override
  String get businessSavedSuccess =>
      'Profil d\'entreprise enregistré avec succès';

  @override
  String get businessInfoSection => 'Informations de l\'entreprise';

  @override
  String get settingsSection => 'Paramètres';

  @override
  String get footerSection => 'Note de bas de page (PDF)';

  @override
  String get upgradeToPro => 'Passer à Pro';

  @override
  String get bestValueStar => '⭐ Meilleure offre';

  @override
  String get invoicesTitle => 'Factures';

  @override
  String get noInvoicesYet => 'Aucune facture pour le moment.';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'Plan gratuit : limite mensuelle $limit factures • Passez à illimité';
  }

  @override
  String get filtersTitle => 'Filtres';

  @override
  String get clientLabel => 'Client';

  @override
  String get allMonths => 'Tous les mois';

  @override
  String get allClients => 'Tous les clients';

  @override
  String get clear => 'Effacer';

  @override
  String get invoicesSummaryLabel => 'Factures';

  @override
  String get totalTitle => 'Total';

  @override
  String get dateLabel => 'Date';

  @override
  String get noResultsForFilters =>
      'Aucun résultat pour les filtres sélectionnés.';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'Plan gratuit : $current / $limit factures ce mois-ci.\n\nPassez à Pro pour illimité.';
  }

  @override
  String get deleteInvoiceTitle => 'Supprimer la facture ?';

  @override
  String deleteInvoiceBody(Object invNo) {
    return 'Voulez-vous vraiment supprimer $invNo ?';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get sendPdf => 'Envoyer le PDF';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'Facture $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'Erreur lors de la création/envoi du PDF : $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'Rapport • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'Rapport • Année $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'Factures : $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'Ventes totales : \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'Taxe totale : \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'Pourboire total : \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'Net : \$$amount';
  }

  @override
  String get calculatedFromInvoices =>
      'Calculé à partir de vos factures dans Firestore.';

  @override
  String get noInvoicesInPeriod => 'Aucune facture sur cette période.';

  @override
  String get exportPdf => 'Exporter PDF';

  @override
  String get exportCsv => 'Exporter CSV';

  @override
  String get yearlyProReason =>
      'Le rapport annuel est PRO. Passez à Pro pour le débloquer.';

  @override
  String get exportPdfProReason => 'L\'export du PDF du rapport est PRO.';

  @override
  String get exportCsvProReason => 'L\'export CSV est PRO.';

  @override
  String get noDataToExport => 'Aucune donnée à exporter.';

  @override
  String get freePlanReportsNote =>
      'Plan gratuit : rapports mensuels uniquement. Passez à Pro pour l\'annuel et l\'export.';

  @override
  String get genericError => 'Une erreur s\'est produite. Réessayez.';

  @override
  String get newInvoiceTitle => 'Nouvelle facture';

  @override
  String get editInvoiceTitle => 'Modifier la facture';

  @override
  String get pickClient => 'Choisir un client';

  @override
  String get invoiceAutoNumberLabel => 'Facture # (auto)';

  @override
  String invoiceDateLabel(Object date) {
    return 'Date de facture : $date';
  }

  @override
  String get clientNameLabel => 'Nom du client';

  @override
  String get clientNameRequired => 'Nom du client requis';

  @override
  String get clientEmailOptionalLabel => 'E-mail du client (optionnel)';

  @override
  String get clientPhoneOptionalLabel => 'Téléphone du client (optionnel)';

  @override
  String get invalidEmailFormat => 'Format d\'e-mail invalide';

  @override
  String get itemsTitle => 'Articles';

  @override
  String get descriptionLabel => 'Description';

  @override
  String itemDateLabel(Object date) {
    return 'Date de l\'article : $date';
  }

  @override
  String get qtyLabel => 'Qté';

  @override
  String get priceLabel => 'Prix';

  @override
  String lineTotalLabel(Object amount) {
    return 'Total ligne : \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'Taxe % (propriétaire par défaut)';

  @override
  String get tipPercentChip => 'Pourboire %';

  @override
  String get tipAmountChip => 'Pourboire \$';

  @override
  String get tipPercentLabel => 'Pourcentage de pourboire (%)';

  @override
  String get tipAmountLabel => 'Montant du pourboire (\$)';

  @override
  String get messageOptionalLabel => 'Message (optionnel)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'Sous-total : \$$sub\nTaxe : \$$tax\nPourboire : \$$tip\nTotal : \$$total';
  }

  @override
  String get saving => 'Enregistrement…';

  @override
  String get saveInvoice => 'Enregistrer la facture';

  @override
  String get updateInvoice => 'Mettre à jour la facture';

  @override
  String get addAtLeastOneItem => 'Ajoutez au moins 1 article';

  @override
  String errorSavingInvoice(Object error) {
    return 'Erreur lors de l\'enregistrement : $error';
  }

  @override
  String get savedTab => 'Enregistrés';

  @override
  String get contactsTab => 'Contacts';

  @override
  String get noSavedClients => 'Aucun client enregistré';

  @override
  String get permissionDeniedContacts => 'Permission refusée : Contacts';

  @override
  String get noContactsFound =>
      'Aucun contact trouvé sur cet appareil/émulateur';

  @override
  String contactsError(Object error) {
    return 'Erreur contacts : $error';
  }

  @override
  String get noName => '(Sans nom)';

  @override
  String get newClientTitle => 'Nouveau client';

  @override
  String get editClientTitle => 'Modifier le client';

  @override
  String get clientInfoSection => 'Informations client';

  @override
  String get notesLabel => 'Notes';

  @override
  String get notesHint => 'Ajouter des notes (optionnel)';

  @override
  String get clientCreateHint =>
      'Astuce : Ajoutez e-mail/téléphone pour envoyer plus vite.';

  @override
  String get clientEditHint => 'Vous pouvez modifier le client à tout moment.';

  @override
  String errorSavingClient(Object error) {
    return 'Erreur lors de l\'enregistrement client : $error';
  }

  @override
  String get clientsTitle => 'Clients';

  @override
  String get searchClientsLabel => 'Rechercher des clients';

  @override
  String clientsCount(Object count) {
    return '$count client(s)';
  }

  @override
  String get noClientsYet => 'Aucun client pour le moment.';

  @override
  String get noClientsForSearch =>
      'Aucun client ne correspond à votre recherche.';

  @override
  String get cannotOpenDialer => 'Impossible d\'ouvrir le numéroteur';

  @override
  String get cannotOpenSms => 'Impossible d\'ouvrir les SMS';

  @override
  String get whatsAppNotAvailable => 'WhatsApp indisponible';

  @override
  String get cannotOpenEmail => 'Impossible d\'ouvrir l\'e-mail';

  @override
  String get deleteClientTitle => 'Supprimer le client ?';

  @override
  String deleteClientBody(Object name) {
    return 'Supprimer $name ?';
  }

  @override
  String get call => 'Appeler';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'E-mail';

  @override
  String get shareAppTitle => 'Essayez EzInvoice 👇';

  @override
  String get shareAppBody =>
      'Créez des factures, envoyez des PDF et suivez vos rapports facilement.';

  @override
  String get shareAppTooltip => 'Partager l\'app';

  @override
  String get openGooglePlayTooltip => 'Ouvrir Google Play';

  @override
  String get openAppStoreTooltip => 'Ouvrir l\'App Store';

  @override
  String get openWebsiteTooltip => 'Ouvrir le site';

  @override
  String get availableLanguages => 'Langues disponibles';

  @override
  String get usePhoneLanguage => 'Utiliser la langue du téléphone';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'Reçu $invoiceNumber pour $clientName';
  }

  @override
  String get report => 'Rapport';

  @override
  String get invoicesLabel => 'Factures';

  @override
  String get totalSalesLabel => 'Ventes totales';

  @override
  String get totalTaxLabel => 'Taxe totale';

  @override
  String get totalTipLabel => 'Pourboire total';

  @override
  String get netLabel => 'Net';

  @override
  String get sentLabel => 'Envoyées';

  @override
  String get paidLabel => 'Payées';

  @override
  String get overdueLabel => 'En retard';

  @override
  String get reportCalculatedHint => 'Calculé à partir de vos factures.';

  @override
  String get exportPdfComingSoon => 'Exporter PDF (bientôt)';

  @override
  String get exportCsvComingSoon => 'Exporter CSV (bientôt)';

  @override
  String get unsentLabel => 'Non envoyées';

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
  String get deleteAccountTitle => 'Supprimer le compte';

  @override
  String get deleteAccountWarning =>
      'Cette action supprimera définitivement votre compte et toutes les données associées.';

  @override
  String get deleteAccountButton => 'Supprimer le compte';

  @override
  String get deleteAccountConfirmTitle => 'Confirmer la suppression';

  @override
  String get deleteAccountConfirmMessage =>
      'Êtes-vous sûr ? Cette action est irréversible.';

  @override
  String get profileSaved => 'Enregistré automatiquement';

  @override
  String get profileSaveError =>
      'Échec de l’enregistrement. Vos modifications sont conservées ici.';

  @override
  String get profileRetry => 'Réessayer';

  @override
  String get profileAutosaveHint =>
      'Les modifications sont enregistrées automatiquement, même à la fermeture.';

  @override
  String get profileLogo => 'Logo de l’entreprise';

  @override
  String get profileDefaults => 'Valeurs de facturation';

  @override
  String get profileTaxInvalid => 'Vérifiez la taxe (0–100 %).';

  @override
  String get metricLoadError => 'Impossible de charger ce rapport. Réessayez.';

  @override
  String get totalInvoicedTitle => 'Total facturé';
}
