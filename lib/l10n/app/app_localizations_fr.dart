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
  String get servicePresetsTitle => 'Services enregistrés';

  @override
  String get servicePresetsScreenTitle => 'Services enregistrés';

  @override
  String get servicePresetsAddNew => 'Ajouter un nouveau service';

  @override
  String get servicePresetsHint => 'ex. Nettoyage, Réparation, Conseil...';

  @override
  String get servicePresetsAddButton => 'Ajouter';

  @override
  String get addServiceLabel => 'Ajouter un service';

  @override
  String get yourPresets => 'Vos services enregistrés';

  @override
  String get noPresetsYet => 'Aucun service enregistré pour le moment.';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String get openPaywallPlaceholder => 'Ouvrir les abonnements';

  @override
  String get invoiceStyleTitle => 'Style de facture';

  @override
  String get invoiceFreeStyleHint =>
      'Le plan gratuit utilise une version de facture (Minimal). Passez à Pro pour débloquer toutes les mises en page et palettes.';

  @override
  String get invoicePaletteLabel => 'Palette de facture';

  @override
  String get invoiceLayoutLabel => 'Mise en page de facture';

  @override
  String get saveInvoicePaletteError =>
      'Impossible d’enregistrer la palette de facture.';

  @override
  String get saveInvoiceLayoutError =>
      'Impossible d’enregistrer la mise en page de facture.';

  @override
  String get reportStyleTitle => 'Style du rapport';

  @override
  String get reportFreeStyleHint =>
      'Le plan gratuit utilise une version de rapport (Minimal). Passez à Pro pour débloquer toutes les mises en page et palettes.';

  @override
  String get reportPaletteLabel => 'Palette du rapport';

  @override
  String get reportLayoutLabel => 'Mise en page du rapport';

  @override
  String get saveReportPaletteError =>
      'Impossible d’enregistrer la palette du rapport.';

  @override
  String get saveReportLayoutError =>
      'Impossible d’enregistrer la mise en page du rapport.';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return 'Style de $docType : $style | Palette : $palette';
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

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get rememberEmail => 'Mémoriser mon e-mail';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get passwordResetEnterEmail =>
      'Saisissez votre e-mail pour recevoir le lien de réinitialisation.';

  @override
  String get passwordResetSent =>
      'Nous vous avons envoyé un e-mail pour réinitialiser votre mot de passe. Vérifiez les spams.';

  @override
  String get passwordResetNoAccount =>
      'Aucun compte n’a été trouvé pour cet e-mail.';

  @override
  String get invalidEmail => 'E-mail non valide.';

  @override
  String get passwordResetError => 'Impossible d’envoyer l’e-mail. Réessayez.';

  @override
  String get updateRequired => 'Mise à jour requise';

  @override
  String get updateRequiredBody =>
      'Une nouvelle version d’Ez Invoice est disponible. Pour continuer, mettez l’application à jour depuis la boutique.';

  @override
  String get updateNow => 'Mettre à jour';

  @override
  String get open => 'Ouvrir';

  @override
  String get share => 'Partager';

  @override
  String get actions => 'Actions';

  @override
  String get message => 'Message';

  @override
  String get done => 'Terminé';

  @override
  String get confirm => 'Confirmer';

  @override
  String get free => 'GRATUIT';

  @override
  String get clientInformation => 'Informations du client';

  @override
  String get clientName => 'Nom du client';

  @override
  String get notesOptional => 'Notes (facultatif)';

  @override
  String get saveClient => 'Enregistrer le client';

  @override
  String get importFromContacts => 'Importer depuis les contacts';

  @override
  String get importContactsDescription =>
      'Remplissez instantanément le nom, le téléphone et l’e-mail.';

  @override
  String get loadContacts => 'Charger les contacts';

  @override
  String get clientPhone => 'Téléphone du client';

  @override
  String get searchContacts => 'Rechercher des contacts';

  @override
  String get shareClient => 'Partager le client';

  @override
  String get clientProfile => 'Profil du client';

  @override
  String get chooseSavedService => 'Choisir un service enregistré';

  @override
  String get searchSavedServices => 'Rechercher des services enregistrés';

  @override
  String get noSavedServicesFound => 'Aucun service enregistré trouvé';

  @override
  String get noSavedServicesToUse =>
      'Aucun service enregistré pour le moment. Saisissez-en un ci-dessus, puis enregistrez-le.';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'Déjà enregistré : $service';
  }

  @override
  String savedService(Object service) {
    return 'Service enregistré : $service';
  }

  @override
  String savePresetError(Object error) {
    return 'Impossible d’enregistrer le service : $error';
  }

  @override
  String get saveServiceForLater => 'Enregistrer le service pour plus tard';

  @override
  String get removeClient => 'Retirer le client';

  @override
  String get service => 'Service';

  @override
  String get taxAndTip => 'Taxe et pourboire';

  @override
  String get totals => 'Totaux';

  @override
  String dueDate(Object date) {
    return 'Date d’échéance : $date';
  }

  @override
  String paidDate(Object date) {
    return 'Date de paiement : $date';
  }

  @override
  String get notPaidYet => 'Pas encore payée';

  @override
  String paymentMethodWithValue(Object method) {
    return 'Mode : $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'Note : $note';
  }

  @override
  String get markAsPaid => 'Marquer comme payée';

  @override
  String get markAsUnpaid => 'Marquer comme impayée';

  @override
  String get editTax => 'Modifier';

  @override
  String get addClient => 'Ajouter un client';

  @override
  String get firstClientHint =>
      'Créez votre premier client pour le réutiliser dans vos prochaines factures.';

  @override
  String get searchSavedClients => 'Rechercher des clients enregistrés';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get cash => 'Espèces';

  @override
  String get card => 'Carte';

  @override
  String get check => 'Chèque';

  @override
  String get other => 'Autre';

  @override
  String get noteOptional => 'Note (facultatif)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'Impossible de marquer la facture comme payée : $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'Impossible de marquer la facture comme impayée : $error';
  }

  @override
  String deleteError(Object error) {
    return 'Impossible de supprimer la facture : $error';
  }

  @override
  String get invoiceDeleted => 'Facture supprimée';

  @override
  String get invoiceMarkedSent => 'Marquée comme envoyée ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'Impossible de marquer comme envoyée : $error';
  }

  @override
  String get invoiceMarkedUnsent => 'Marquée comme non envoyée ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'Impossible de marquer comme non envoyée : $error';
  }

  @override
  String get invoiceMarkedPaid => 'Marquée comme payée ✅';

  @override
  String get invoiceMarkedUnpaid => 'Marquée comme impayée ✅';

  @override
  String get invoiceLoadingError => 'Impossible de charger les factures';

  @override
  String get tipType => 'Type de pourboire';

  @override
  String get amountOption => 'Montant (\$)';

  @override
  String get percentageOption => 'Pourcentage (%)';

  @override
  String get pdfPreview => 'Aperçu du PDF';

  @override
  String get openPdf => 'Ouvrir le PDF';

  @override
  String get sharePdf => 'Partager le PDF';

  @override
  String get selectReportMonth => 'Choisir le mois du rapport';

  @override
  String reportForBusiness(Object business) {
    return 'Rapports • $business';
  }

  @override
  String get tapToChangeMonth => 'Touchez pour changer de mois';

  @override
  String csvSaved(Object path) {
    return 'CSV enregistré : $path';
  }

  @override
  String csvExportError(Object error) {
    return 'Impossible d’exporter le CSV : $error';
  }

  @override
  String get aboutTitle => 'À propos';

  @override
  String get aboutTagline =>
      'Une facturation claire pour les entreprises en mouvement';

  @override
  String get aboutAppTitle => 'L’application';

  @override
  String get aboutAppBody =>
      'EzInvoice réunit factures, clients, paiements et rapports dans un flux simple afin que vous voyiez l’essentiel et soyez payé en toute confiance.';

  @override
  String get aboutCompanyTitle => 'L’entreprise';

  @override
  String get aboutCompanyBody =>
      'Liisgo LLC crée des outils pratiques pour aider les petites entreprises à travailler avec plus d’ordre, de clarté et de confiance.';

  @override
  String get aboutPromiseTitle => 'Pensé pour votre quotidien';

  @override
  String get aboutPromiseBody =>
      'Chaque décision dans EzInvoice vise à réduire les étapes, garder les détails visibles et simplifier la gestion de votre entreprise.';

  @override
  String get visitLiisgo => 'Visiter Liisgo';

  @override
  String get contactSupport => 'Contacter l’assistance';

  @override
  String get shareEzInvoice => 'Partager EzInvoice';

  @override
  String get sendIdeaOrBug => 'Envoyer une idée ou un problème';

  @override
  String get feedbackTitle => 'Votre avis compte';

  @override
  String get feedbackSubtitle =>
      'Dites-nous ce que vous amélioreriez ou ce qui n’a pas bien fonctionné.';

  @override
  String get feedbackIdea => 'Idée';

  @override
  String get feedbackBug => 'Problème';

  @override
  String get feedbackHint =>
      'Écrivez votre idée ou expliquez ce qui s’est passé…';

  @override
  String get feedbackRequired => 'Écrivez un message avant l’envoi.';

  @override
  String get continueToEmail => 'Continuer vers l’e-mail';

  @override
  String get couldNotOpenLink => 'Impossible d’ouvrir ce lien.';

  @override
  String shareAppText(Object storeUrl) {
    return 'Découvrez EzInvoice Pro : factures, clients et rapports au même endroit.\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return '$kind pour EzInvoice';
  }

  @override
  String get supportEmailSubject => 'Assistance EzInvoice';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get changePasswordSubtitle =>
      'Mettez à jour le mot de passe de votre compte.';

  @override
  String get confirmCurrentPasswordHint =>
      'Pour votre sécurité, confirmez d’abord votre mot de passe actuel.';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get updatePassword => 'Mettre à jour le mot de passe';

  @override
  String get passwordAtLeastSix => 'Doit contenir au moins 6 caractères.';

  @override
  String get noActiveSession => 'Aucune session active.';

  @override
  String get passwordsDoNotMatch =>
      'Le nouveau mot de passe ne correspond pas.';

  @override
  String get passwordMustDiffer =>
      'Le nouveau mot de passe doit être différent.';

  @override
  String get passwordUpdated => 'Mot de passe mis à jour avec succès.';

  @override
  String get incorrectPassword => 'Le mot de passe actuel est incorrect.';

  @override
  String get weakPassword => 'Le nouveau mot de passe est trop faible.';

  @override
  String get reauthenticationNeeded =>
      'Pour votre sécurité, reconnectez-vous puis réessayez.';

  @override
  String get changePasswordError => 'Impossible de changer le mot de passe.';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get reauthCancelled => 'Réauthentification annulée.';

  @override
  String get accountDeleted =>
      'Votre compte et vos données ont été supprimés définitivement.';

  @override
  String get deleteAccountIncorrectPassword => 'Mot de passe incorrect.';

  @override
  String get deleteAccountError => 'Impossible de supprimer le compte.';

  @override
  String get deleteAccountBody =>
      'Si vous supprimez votre compte :\n\n• Vos clients, factures, rapports et profil d’entreprise seront supprimés définitivement.\n• Cette action est irréversible.\n• Si vous avez un abonnement actif, gérez-le ou annulez-le dans l’App Store/Google Play.';

  @override
  String get termsConditions => 'Conditions générales';

  @override
  String get agreeTermsPrivacy =>
      'Veuillez d’abord accepter les Conditions générales et la Politique de confidentialité.';

  @override
  String get currentPlan => 'Forfait actuel';

  @override
  String get currentPlanFree => 'Forfait actuel : Gratuit';

  @override
  String get proPlanDescription =>
      'La version gratuite inclut des publicités et une utilisation limitée. Pro supprime les publicités et débloque les factures illimitées, rapports, modèles premium, exports et sauvegarde cloud.';

  @override
  String get adsIncluded => 'Publicités incluses';

  @override
  String get limitedInvoicesPerMonth => 'Factures limitées chaque mois';

  @override
  String get basicInvoiceStyle => 'Style de facture standard';

  @override
  String get basicReports => 'Rapports de base';

  @override
  String get pdfIncludesBranding => 'Le PDF inclut la marque EzInvoice';

  @override
  String get unpaidLabel => 'Impayée';

  @override
  String get loading => 'Chargement...';

  @override
  String get store => 'Boutique';

  @override
  String get storeProductLoadingOne =>
      'Un produit d’abonnement est encore en cours de chargement. Vous pouvez continuer avec le forfait disponible pendant que l’autre se charge.';

  @override
  String get storeProductsLoading =>
      'Connexion aux produits d’abonnement de la boutique. Si le chargement ne se termine pas, vérifiez que les abonnements sont prêts dans votre console.';

  @override
  String get agreeTo => 'J’accepte les ';

  @override
  String get and => ' et la ';

  @override
  String get currentProPlanDescription =>
      'Vous avez déjà Ez Invoice Pro. Vous pouvez consulter les deux options d’abonnement ci-dessous.';

  @override
  String freeVsPro(Object pro) {
    return 'Gratuit vs $pro';
  }

  @override
  String get openInvoices => 'Ouvrez les factures.';

  @override
  String get allCaughtUp => 'Tout est à jour';

  @override
  String itemsToReview(Object count) {
    return '$count à examiner';
  }

  @override
  String get pdfInvoice => 'Facture';

  @override
  String get pdfReceipt => 'Reçu';

  @override
  String get pdfBusiness => 'Entreprise';

  @override
  String get pdfPhone => 'Téléphone';

  @override
  String get pdfEmail => 'E-mail';

  @override
  String get pdfNumber => 'N°';

  @override
  String get pdfDate => 'Date';

  @override
  String get pdfDue => 'Échéance';

  @override
  String get pdfPaid => 'Payée';

  @override
  String get pdfPaidDate => 'Date de paiement';

  @override
  String get pdfMethod => 'Mode';

  @override
  String get pdfBillTo => 'Facturer à';

  @override
  String get pdfClient => 'Client';

  @override
  String get pdfDescription => 'Description';

  @override
  String get pdfQuantity => 'Qté';

  @override
  String get pdfPrice => 'Prix';

  @override
  String get pdfSubtotal => 'Sous-total';

  @override
  String get pdfTax => 'Taxe';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'Taxe ($rate%)';
  }

  @override
  String get pdfTip => 'Pourboire';

  @override
  String pdfTipWithRate(Object rate) {
    return 'Pourboire ($rate%)';
  }

  @override
  String get pdfDiscount => 'Remise';

  @override
  String get pdfMessage => 'Message';

  @override
  String get pdfPaymentNote => 'Note de paiement';

  @override
  String get pdfThankYou => 'Merci pour votre confiance.';

  @override
  String get pdfPoweredBy => 'Propulsé par EzInvoice';

  @override
  String get pdfFreeVersion => 'VERSION GRATUITE';

  @override
  String get pdfTotal => 'Total';

  @override
  String get styleMinimal => 'Minimal';

  @override
  String get styleProfessional => 'Professionnel';

  @override
  String get styleCorporate => 'Entreprise';

  @override
  String get styleModern => 'Moderne';

  @override
  String get styleSlate => 'Ardoise';

  @override
  String get reportDocument => 'Rapport';

  @override
  String get reportPrintDocument => 'Imprimer le rapport';

  @override
  String get reportMonth => 'Mois';

  @override
  String get reportYear => 'Année';

  @override
  String get reportGeneratedOn => 'Généré le';

  @override
  String get reportInvoices => 'Factures';

  @override
  String get reportStatus => 'Statut';

  @override
  String get reportTotals => 'Totaux';

  @override
  String get reportSales => 'Ventes';

  @override
  String get reportTotalTax => 'Total des taxes';

  @override
  String get reportTotalTip => 'Total des pourboires';

  @override
  String get reportTotalInvoiced => 'Total facturé';

  @override
  String get reportUnsent => 'Non envoyée';

  @override
  String get reportSent => 'Envoyée';

  @override
  String get reportPaid => 'Payée';

  @override
  String get reportOverdue => 'En retard';

  @override
  String get reportInvoiceNumber => 'N° de facture';

  @override
  String get reportClient => 'Client';

  @override
  String get reportDueDate => 'Date d’échéance';

  @override
  String get reportDescription => 'Description';

  @override
  String get reportDate => 'Date';

  @override
  String get reportFreeVersion => 'VERSION GRATUITE';

  @override
  String get reportPoweredBy => 'Propulsé par EzInvoice';

  @override
  String reportPdfShareText(Object title) {
    return 'Rapport PDF : $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'Rapport CSV : $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'Imprimer : $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'Rapport_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'Rapport_Année_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'Rapport | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'Rapport | $year';
  }

  @override
  String get reportBreakdown => 'Répartition';

  @override
  String get reportInvoicesStatus => 'Statut des factures';

  @override
  String get viewReport => 'Voir le rapport';

  @override
  String get reviewBeforeExport =>
      'Vérifiez le PDF ou le CSV avant de l’exporter.';

  @override
  String get customizeReport => 'Personnaliser le rapport';

  @override
  String get reportPreviewUpdates =>
      'Les modifications apparaissent immédiatement dans votre aperçu.';

  @override
  String get yourReportPreview => 'Aperçu de votre rapport';

  @override
  String get reportStyleLiveHint =>
      'Modifiez le design et voyez le résultat en direct.';

  @override
  String get watchAdToExportReport =>
      'Regardez l’annonce complète pour exporter ce rapport. Passez à Pro pour exporter sans annonces.';

  @override
  String reportExportError(Object error) {
    return 'Impossible d’exporter le rapport : $error';
  }

  @override
  String get shareCsvFile => 'Partager le fichier CSV';

  @override
  String get shareCsvFileDescription =>
      'Partagez la pièce jointe .csv par e-mail, Drive ou une autre application.';

  @override
  String get shareReportAsText => 'Partager comme texte (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription =>
      'Envoyez un résumé du rapport sous forme de texte.';

  @override
  String get printCsv => 'Imprimer le CSV';

  @override
  String get printReportDescription =>
      'Imprimez le rapport sous forme de tableau PDF.';

  @override
  String get reportPreview => 'Aperçu';

  @override
  String get live => 'En direct';

  @override
  String get proFeatureUnlimitedInvoices => 'Factures illimitées';

  @override
  String get proFeatureRemovePdfBranding => 'Supprimer la marque PDF';

  @override
  String get proFeatureExportCsv => 'Exporter en CSV';

  @override
  String get proFeaturePremiumTemplates => 'Modèles premium';

  @override
  String get proFeatureDetailedTaxReport => 'Rapport fiscal détaillé';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'Le plan gratuit permet jusqu’à $limit factures par mois.';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'Supprime « Propulsé par EzInvoice » des PDF.';

  @override
  String get proFeatureExportCsvDescription => 'Exportez vos factures en CSV.';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'Débloquez des modèles de facture premium.';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'Consultez des rapports détaillés de taxes.';

  @override
  String get pdfShareText => 'PDF de facture d’EzInvoice';
}
