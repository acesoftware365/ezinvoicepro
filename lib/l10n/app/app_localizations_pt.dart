// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'Crie sua conta';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get login => 'Entrar';

  @override
  String get register => 'Criar conta';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get signIn => 'Entrar';

  @override
  String get dontHaveAccount => 'Não tem uma conta?';

  @override
  String get signUp => 'Cadastrar';

  @override
  String get processing => 'Processando...';

  @override
  String get invalidCredentials =>
      'Digite um e-mail válido e uma senha (6+ caracteres)';

  @override
  String get authError => 'Erro de autenticação';

  @override
  String get home => 'Início';

  @override
  String get clients => 'Clientes';

  @override
  String get invoices => 'Faturas';

  @override
  String get reports => 'Relatórios';

  @override
  String get settings => 'Configurações';

  @override
  String get logout => 'Sair';

  @override
  String get business => 'Negócio';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDescription => 'Escolha o idioma do app.';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'Olá $name,\nestou enviando sua fatura pelo EzInvoice. ✅';
  }

  @override
  String get invoiceEmailSubject => 'Fatura - EzInvoice';

  @override
  String get dashboardTitle => 'Painel';

  @override
  String get monthWord => 'Mês';

  @override
  String get planLabel => 'Plano';

  @override
  String get invoicesRemaining => 'Faturas restantes';

  @override
  String get proUnlimitedLabel => 'PRO · Ilimitado';

  @override
  String get createNewInvoice => 'Criar nova fatura';

  @override
  String get limitReachedSubtitle => 'Limite atingido • Atualize para Pro';

  @override
  String get createInvoiceFastSubtitle => 'Crie fatura + PDF em segundos';

  @override
  String get limitReachedTitle => 'Limite atingido';

  @override
  String get limitReachedBody =>
      'Atualize para Pro para faturas ilimitadas e remover anúncios.';

  @override
  String get upgrade => 'Atualizar';

  @override
  String get monthSummaryTitle => 'Resumo do mês';

  @override
  String get salesTitle => 'Vendas';

  @override
  String get tipTitle => 'Gorjeta';

  @override
  String get subtotalTitle => 'Subtotal';

  @override
  String get taxTitle => 'Imposto';

  @override
  String get beforeTaxTip => 'Antes de imposto/gorjeta';

  @override
  String get collectedThisMonth => 'Recebido neste mês';

  @override
  String get quickAccessTitle => 'Acesso rápido';

  @override
  String get clientsManageSubtitle => 'Criar / editar clientes';

  @override
  String get invoicesViewSendSubtitle => 'Ver e enviar PDF';

  @override
  String get monthlyYearlySubtitle => 'Mensal / anual';

  @override
  String get businessProfileSubtitle => 'Perfil / logo / imposto';

  @override
  String invoiceCount(Object count) {
    return '$count fatura(s)';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'Fechar';

  @override
  String get paywallHeaderTitle => 'Desbloqueie tudo para o seu negócio';

  @override
  String get paywallHeaderSubtitle =>
      'Sem anúncios • Faturas ilimitadas • Relatórios de impostos • Modelos premium';

  @override
  String get bestValue => 'Melhor custo-benefício';

  @override
  String get proYearly => 'Pro Anual';

  @override
  String get saveMoreYearly => 'Economize mais pagando anual';

  @override
  String get proMonthly => 'Pro Mensal';

  @override
  String get flexible => 'Flexível';

  @override
  String get cancelAnytime => 'Cancele a qualquer momento';

  @override
  String get processingPurchase => 'Processando compra…';

  @override
  String get restoringPurchases => 'Restaurando compras…';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get continueFreeWithAds =>
      'Continuar com a versão grátis com anúncios';

  @override
  String get alreadyProTitle => 'Você é Pro ✅';

  @override
  String get alreadyProBody =>
      'Aproveite faturas ilimitadas, relatórios e sem anúncios.';

  @override
  String get continueText => 'Continuar';

  @override
  String get includesInPro => 'Incluído no Pro';

  @override
  String get benefitNoAds => 'Sem anúncios (Banner/Interstitial/Rewarded)';

  @override
  String get benefitUnlimitedInvoices =>
      'Faturas ilimitadas + status (rascunho/enviada/paga)';

  @override
  String get benefitPremiumTemplates =>
      'Modelos premium + cores + logo do negócio';

  @override
  String get benefitNoWatermarkPdf => 'PDF profissional sem marca d’água';

  @override
  String get benefitTaxReports =>
      'Relatórios: mensal e anual (impostos/gorjetas/líquido)';

  @override
  String get benefitExport => 'Exportar PDF/CSV/Excel (para contabilidade)';

  @override
  String get benefitCloudBackup =>
      'Backup na nuvem + restauração (multi-dispositivo)';

  @override
  String continueWithPlan(Object plan) {
    return 'Continuar com $plan';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'Ao assinar, o pagamento será cobrado da sua conta $store. A assinatura renova automaticamente, a menos que você cancele pelo menos 24 horas antes do fim do período atual. Você pode gerenciar ou cancelar sua assinatura nas configurações da loja.';
  }

  @override
  String get reportsTitle => 'Relatórios';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'Por mês';

  @override
  String get byYear => 'Por ano';

  @override
  String get monthLabel => 'Mês';

  @override
  String get yearLabel => 'Ano';

  @override
  String get businessProfileTitle => 'Perfil do Negócio';

  @override
  String get save => 'Salvar';

  @override
  String get uploadLogo => 'Enviar logo';

  @override
  String get remove => 'Remover';

  @override
  String get businessNameLabel => 'Nome do negócio';

  @override
  String get ownerNameLabel => 'Proprietário / contato';

  @override
  String get phoneLabel => 'Telefone';

  @override
  String get addressLabel => 'Endereço';

  @override
  String get currencyLabel => 'Moeda';

  @override
  String get taxDefaultLabel => 'Imposto padrão (%)';

  @override
  String get invalidNumber => 'Número inválido';

  @override
  String get range0to100 => 'Deve estar entre 0 e 100';

  @override
  String get requiredField => 'Obrigatório';

  @override
  String get footerNoteLabel => 'Nota no rodapé (PDF)';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get businessFooterDefault => 'Obrigado pelo seu negócio.';

  @override
  String get businessSavedSuccess => 'Perfil do negócio salvo com sucesso';

  @override
  String get businessInfoSection => 'Informações do negócio';

  @override
  String get settingsSection => 'Configurações';

  @override
  String get footerSection => 'Nota no rodapé (PDF)';

  @override
  String get upgradeToPro => 'Atualizar para Pro';

  @override
  String get bestValueStar => '⭐ Melhor valor';

  @override
  String get invoicesTitle => 'Faturas';

  @override
  String get noInvoicesYet => 'Nenhuma fatura ainda.';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'Plano grátis: limite mensal $limit faturas • Atualize para ilimitado';
  }

  @override
  String get filtersTitle => 'Filtros';

  @override
  String get clientLabel => 'Cliente';

  @override
  String get allMonths => 'Todos os meses';

  @override
  String get allClients => 'Todos os clientes';

  @override
  String get clear => 'Limpar';

  @override
  String get invoicesSummaryLabel => 'Faturas';

  @override
  String get totalTitle => 'Total';

  @override
  String get dateLabel => 'Data';

  @override
  String get noResultsForFilters =>
      'Sem resultados para os filtros selecionados.';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'Plano grátis: $current / $limit faturas neste mês.\n\nAtualize para Pro para ilimitado.';
  }

  @override
  String get deleteInvoiceTitle => 'Excluir fatura?';

  @override
  String deleteInvoiceBody(Object invNo) {
    return 'Tem certeza que deseja excluir $invNo?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get edit => 'Editar';

  @override
  String get sendPdf => 'Enviar PDF';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'Fatura $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'Erro ao criar/enviar PDF: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'Relatório • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'Relatório • Ano $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'Faturas: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'Vendas totais: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'Imposto total: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'Gorjeta total: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'Líquido: \$$amount';
  }

  @override
  String get calculatedFromInvoices =>
      'Calculado a partir das suas faturas no Firestore.';

  @override
  String get noInvoicesInPeriod => 'Nenhuma fatura nesse período.';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get yearlyProReason =>
      'Relatório anual é PRO. Atualize para desbloquear.';

  @override
  String get exportPdfProReason => 'Exportar PDF do relatório é PRO.';

  @override
  String get exportCsvProReason => 'Exportar CSV é PRO.';

  @override
  String get noDataToExport => 'Sem dados para exportar.';

  @override
  String get freePlanReportsNote =>
      'Plano grátis: apenas relatórios mensais. Atualize para relatórios anuais e exportação.';

  @override
  String get genericError => 'Algo deu errado. Tente novamente.';

  @override
  String get newInvoiceTitle => 'Nova fatura';

  @override
  String get editInvoiceTitle => 'Editar fatura';

  @override
  String get pickClient => 'Selecionar cliente';

  @override
  String get invoiceAutoNumberLabel => 'Fatura # (auto)';

  @override
  String invoiceDateLabel(Object date) {
    return 'Data da fatura: $date';
  }

  @override
  String get clientNameLabel => 'Nome do cliente';

  @override
  String get clientNameRequired => 'Nome do cliente é obrigatório';

  @override
  String get clientEmailOptionalLabel => 'E-mail do cliente (opcional)';

  @override
  String get clientPhoneOptionalLabel => 'Telefone do cliente (opcional)';

  @override
  String get invalidEmailFormat => 'Formato de e-mail inválido';

  @override
  String get itemsTitle => 'Itens';

  @override
  String get descriptionLabel => 'Descrição';

  @override
  String itemDateLabel(Object date) {
    return 'Data do item: $date';
  }

  @override
  String get qtyLabel => 'Qtd';

  @override
  String get priceLabel => 'Preço';

  @override
  String lineTotalLabel(Object amount) {
    return 'Total da linha: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'Imposto % (padrão do dono)';

  @override
  String get tipPercentChip => 'Gorjeta %';

  @override
  String get tipAmountChip => 'Gorjeta \$';

  @override
  String get tipPercentLabel => 'Percentual de gorjeta (%)';

  @override
  String get tipAmountLabel => 'Valor da gorjeta (\$)';

  @override
  String get messageOptionalLabel => 'Mensagem (opcional)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'Subtotal: \$$sub\nImposto: \$$tax\nGorjeta: \$$tip\nTotal: \$$total';
  }

  @override
  String get saving => 'Salvando…';

  @override
  String get saveInvoice => 'Salvar fatura';

  @override
  String get updateInvoice => 'Atualizar fatura';

  @override
  String get addAtLeastOneItem => 'Adicione pelo menos 1 item';

  @override
  String errorSavingInvoice(Object error) {
    return 'Erro ao salvar fatura: $error';
  }

  @override
  String get savedTab => 'Salvos';

  @override
  String get contactsTab => 'Contatos';

  @override
  String get noSavedClients => 'Nenhum cliente salvo';

  @override
  String get permissionDeniedContacts => 'Permissão negada: Contatos';

  @override
  String get noContactsFound =>
      'Nenhum contato encontrado neste dispositivo/emulador';

  @override
  String contactsError(Object error) {
    return 'Erro de contatos: $error';
  }

  @override
  String get noName => '(Sem nome)';

  @override
  String get newClientTitle => 'Novo cliente';

  @override
  String get editClientTitle => 'Editar cliente';

  @override
  String get clientInfoSection => 'Informações do cliente';

  @override
  String get notesLabel => 'Notas';

  @override
  String get notesHint => 'Adicionar notas (opcional)';

  @override
  String get clientCreateHint =>
      'Dica: Adicione e-mail/telefone para enviar faturas mais rápido.';

  @override
  String get clientEditHint =>
      'Você pode atualizar as informações do cliente a qualquer momento.';

  @override
  String errorSavingClient(Object error) {
    return 'Erro ao salvar cliente: $error';
  }

  @override
  String get clientsTitle => 'Clientes';

  @override
  String get searchClientsLabel => 'Buscar clientes';

  @override
  String clientsCount(Object count) {
    return '$count cliente(s)';
  }

  @override
  String get noClientsYet => 'Nenhum cliente ainda.';

  @override
  String get noClientsForSearch => 'Nenhum cliente corresponde à sua busca.';

  @override
  String get cannotOpenDialer => 'Não foi possível abrir o discador';

  @override
  String get cannotOpenSms => 'Não foi possível abrir SMS';

  @override
  String get whatsAppNotAvailable => 'WhatsApp não disponível';

  @override
  String get cannotOpenEmail => 'Não foi possível abrir e-mail';

  @override
  String get deleteClientTitle => 'Excluir cliente?';

  @override
  String deleteClientBody(Object name) {
    return 'Remover $name?';
  }

  @override
  String get call => 'Ligar';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'E-mail';

  @override
  String get shareAppTitle => 'Experimente o EzInvoice 👇';

  @override
  String get shareAppBody =>
      'Crie faturas, envie PDFs e acompanhe relatórios facilmente.';

  @override
  String get shareAppTooltip => 'Compartilhar app';

  @override
  String get openGooglePlayTooltip => 'Abrir Google Play';

  @override
  String get openAppStoreTooltip => 'Abrir App Store';

  @override
  String get openWebsiteTooltip => 'Abrir site';

  @override
  String get availableLanguages => 'Idiomas disponíveis';

  @override
  String get usePhoneLanguage => 'Usar idioma do telefone';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'Recibo $invoiceNumber para $clientName';
  }

  @override
  String get report => 'Relatório';

  @override
  String get invoicesLabel => 'Faturas';

  @override
  String get totalSalesLabel => 'Vendas totais';

  @override
  String get totalTaxLabel => 'Imposto total';

  @override
  String get totalTipLabel => 'Gorjeta total';

  @override
  String get netLabel => 'Líquido';

  @override
  String get sentLabel => 'Enviadas';

  @override
  String get paidLabel => 'Pagas';

  @override
  String get overdueLabel => 'Em atraso';

  @override
  String get reportCalculatedHint =>
      'Calculado a partir das suas faturas no Firestore.';

  @override
  String get exportPdfComingSoon => 'Exportar PDF (em breve)';

  @override
  String get exportCsvComingSoon => 'Exportar CSV (em breve)';

  @override
  String get unsentLabel => 'Não enviadas';

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
  String get deleteAccountTitle => 'Excluir conta';

  @override
  String get deleteAccountWarning =>
      'Esta ação excluirá permanentemente sua conta e todos os dados associados.';

  @override
  String get deleteAccountButton => 'Excluir conta';

  @override
  String get deleteAccountConfirmTitle => 'Confirmar exclusão';

  @override
  String get deleteAccountConfirmMessage =>
      'Tem certeza? Esta ação não pode ser desfeita.';
}
