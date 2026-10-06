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
  String get reportCalculatedHint => 'Calculado a partir das suas faturas.';

  @override
  String get exportPdfComingSoon => 'Exportar PDF (em breve)';

  @override
  String get exportCsvComingSoon => 'Exportar CSV (em breve)';

  @override
  String get unsentLabel => 'Não enviadas';

  @override
  String get servicePresetsTitle => 'Serviços salvos';

  @override
  String get servicePresetsScreenTitle => 'Serviços salvos';

  @override
  String get servicePresetsAddNew => 'Adicionar novo serviço';

  @override
  String get servicePresetsHint => 'ex.: Limpeza, Reparo, Consultoria...';

  @override
  String get servicePresetsAddButton => 'Adicionar';

  @override
  String get addServiceLabel => 'Adicionar um serviço';

  @override
  String get yourPresets => 'Seus serviços salvos';

  @override
  String get noPresetsYet => 'Ainda não há serviços salvos.';

  @override
  String get notNow => 'Agora não';

  @override
  String get openPaywallPlaceholder => 'Abrir assinaturas';

  @override
  String get invoiceStyleTitle => 'Estilo da fatura';

  @override
  String get invoiceFreeStyleHint =>
      'O plano gratuito usa uma versão de fatura (Minimal). Atualize para Pro para liberar todos os layouts e paletas.';

  @override
  String get invoicePaletteLabel => 'Paleta da fatura';

  @override
  String get invoiceLayoutLabel => 'Layout da fatura';

  @override
  String get saveInvoicePaletteError =>
      'Não foi possível salvar a paleta da fatura.';

  @override
  String get saveInvoiceLayoutError =>
      'Não foi possível salvar o layout da fatura.';

  @override
  String get reportStyleTitle => 'Estilo do relatório';

  @override
  String get reportFreeStyleHint =>
      'O plano gratuito usa uma versão de relatório (Minimal). Atualize para Pro para liberar todos os layouts e paletas.';

  @override
  String get reportPaletteLabel => 'Paleta do relatório';

  @override
  String get reportLayoutLabel => 'Layout do relatório';

  @override
  String get saveReportPaletteError =>
      'Não foi possível salvar a paleta do relatório.';

  @override
  String get saveReportLayoutError =>
      'Não foi possível salvar o layout do relatório.';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return 'Estilo de $docType: $style | Paleta: $palette';
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

  @override
  String get profileSaved => 'Salvo automaticamente';

  @override
  String get profileSaveError =>
      'Não foi possível salvar. Suas alterações continuam aqui.';

  @override
  String get profileRetry => 'Tentar novamente';

  @override
  String get profileAutosaveHint =>
      'As alterações são salvas automaticamente e mantidas ao fechar.';

  @override
  String get profileLogo => 'Logo da empresa';

  @override
  String get profileDefaults => 'Padrões da fatura';

  @override
  String get profileTaxInvalid => 'Verifique o imposto (0–100%).';

  @override
  String get metricLoadError =>
      'Não foi possível carregar o relatório. Tente novamente.';

  @override
  String get totalInvoicedTitle => 'Total faturado';

  @override
  String versionLabel(Object version) {
    return 'Versão $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'Erro: $error';
  }

  @override
  String get rememberEmail => 'Lembrar meu e-mail';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get passwordResetEnterEmail =>
      'Digite seu e-mail para enviar o link de redefinição.';

  @override
  String get passwordResetSent =>
      'Enviamos um e-mail para redefinir sua senha. Verifique Spam ou Lixo eletrônico.';

  @override
  String get passwordResetNoAccount =>
      'Nenhuma conta foi encontrada com esse e-mail.';

  @override
  String get invalidEmail => 'E-mail inválido.';

  @override
  String get passwordResetError =>
      'Não foi possível enviar o e-mail. Tente novamente.';

  @override
  String get updateRequired => 'Atualização necessária';

  @override
  String get updateRequiredBody =>
      'Uma nova versão do Ez Invoice está disponível. Para continuar, atualize o app na loja.';

  @override
  String get updateNow => 'Atualizar agora';

  @override
  String get open => 'Abrir';

  @override
  String get share => 'Compartilhar';

  @override
  String get actions => 'Ações';

  @override
  String get message => 'Mensagem';

  @override
  String get done => 'Concluído';

  @override
  String get confirm => 'Confirmar';

  @override
  String get free => 'GRÁTIS';

  @override
  String get clientInformation => 'Informações do cliente';

  @override
  String get clientName => 'Nome do cliente';

  @override
  String get notesOptional => 'Notas (opcional)';

  @override
  String get saveClient => 'Salvar cliente';

  @override
  String get importFromContacts => 'Importar dos contatos';

  @override
  String get importContactsDescription =>
      'Preencha nome, telefone e e-mail instantaneamente.';

  @override
  String get loadContacts => 'Carregar contatos';

  @override
  String get clientPhone => 'Telefone do cliente';

  @override
  String get searchContacts => 'Buscar contatos';

  @override
  String get shareClient => 'Compartilhar cliente';

  @override
  String get clientProfile => 'Perfil do cliente';

  @override
  String get chooseSavedService => 'Escolher serviço salvo';

  @override
  String get searchSavedServices => 'Buscar serviços salvos';

  @override
  String get noSavedServicesFound => 'Nenhum serviço salvo encontrado';

  @override
  String get noSavedServicesToUse =>
      'Ainda não há serviços salvos. Digite um acima e salve-o para depois.';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'Já salvo: $service';
  }

  @override
  String savedService(Object service) {
    return 'Serviço salvo: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'Não foi possível salvar o serviço: $error';
  }

  @override
  String get saveServiceForLater => 'Salvar serviço para depois';

  @override
  String get removeClient => 'Remover cliente';

  @override
  String get service => 'Serviço';

  @override
  String get taxAndTip => 'Imposto e gorjeta';

  @override
  String get totals => 'Totais';

  @override
  String dueDate(Object date) {
    return 'Vencimento: $date';
  }

  @override
  String paidDate(Object date) {
    return 'Data de pagamento: $date';
  }

  @override
  String get notPaidYet => 'Ainda não paga';

  @override
  String paymentMethodWithValue(Object method) {
    return 'Método: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'Nota: $note';
  }

  @override
  String get markAsPaid => 'Marcar como paga';

  @override
  String get markAsUnpaid => 'Marcar como não paga';

  @override
  String get editTax => 'Editar';

  @override
  String get addClient => 'Adicionar um cliente';

  @override
  String get firstClientHint =>
      'Crie seu primeiro cliente para reutilizá-lo em futuras faturas.';

  @override
  String get searchSavedClients => 'Buscar clientes salvos';

  @override
  String get paymentMethod => 'Método de pagamento';

  @override
  String get cash => 'Dinheiro';

  @override
  String get card => 'Cartão';

  @override
  String get check => 'Cheque';

  @override
  String get other => 'Outro';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'Não foi possível marcar a fatura como paga: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'Não foi possível marcar a fatura como não paga: $error';
  }

  @override
  String deleteError(Object error) {
    return 'Não foi possível excluir a fatura: $error';
  }

  @override
  String get invoiceDeleted => 'Fatura excluída';

  @override
  String get invoiceMarkedSent => 'Marcada como enviada ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'Não foi possível marcar como enviada: $error';
  }

  @override
  String get invoiceMarkedUnsent => 'Marcada como não enviada ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'Não foi possível marcar como não enviada: $error';
  }

  @override
  String get invoiceMarkedPaid => 'Marcada como paga ✅';

  @override
  String get invoiceMarkedUnpaid => 'Marcada como não paga ✅';

  @override
  String get invoiceLoadingError => 'Não foi possível carregar as faturas';

  @override
  String get tipType => 'Tipo de gorjeta';

  @override
  String get amountOption => 'Valor (\$)';

  @override
  String get percentageOption => 'Porcentagem (%)';

  @override
  String get pdfPreview => 'Prévia do PDF';

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get sharePdf => 'Compartilhar PDF';

  @override
  String get selectReportMonth => 'Selecionar mês do relatório';

  @override
  String reportForBusiness(Object business) {
    return 'Relatórios • $business';
  }

  @override
  String get tapToChangeMonth => 'Toque para alterar o mês';

  @override
  String csvSaved(Object path) {
    return 'CSV salvo: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'Não foi possível exportar CSV: $error';
  }

  @override
  String get aboutTitle => 'Sobre';

  @override
  String get aboutTagline => 'Faturamento claro para negócios em movimento';

  @override
  String get aboutAppTitle => 'O aplicativo';

  @override
  String get aboutAppBody =>
      'O EzInvoice reúne faturas, clientes, pagamentos e relatórios em um fluxo simples para que você veja o que importa e receba com confiança.';

  @override
  String get aboutCompanyTitle => 'A empresa';

  @override
  String get aboutCompanyBody =>
      'A Liisgo LLC cria ferramentas práticas que ajudam pequenos negócios a trabalhar com mais organização, clareza e confiança.';

  @override
  String get aboutPromiseTitle => 'Feito para o seu dia a dia';

  @override
  String get aboutPromiseBody =>
      'Cada decisão do EzInvoice busca reduzir etapas, manter os detalhes visíveis e simplificar a gestão do seu negócio.';

  @override
  String get visitLiisgo => 'Visitar Liisgo';

  @override
  String get contactSupport => 'Contatar o suporte';

  @override
  String get shareEzInvoice => 'Compartilhar EzInvoice';

  @override
  String get sendIdeaOrBug => 'Enviar uma ideia ou erro';

  @override
  String get feedbackTitle => 'Sua opinião importa';

  @override
  String get feedbackSubtitle =>
      'Conte-nos o que você melhoraria ou o que não funcionou bem.';

  @override
  String get feedbackIdea => 'Ideia';

  @override
  String get feedbackBug => 'Erro';

  @override
  String get feedbackHint => 'Escreva sua ideia ou explique o que aconteceu…';

  @override
  String get feedbackRequired => 'Escreva uma mensagem antes de enviar.';

  @override
  String get continueToEmail => 'Continuar para o e-mail';

  @override
  String get couldNotOpenLink => 'Não foi possível abrir este link.';

  @override
  String shareAppText(Object storeUrl) {
    return 'Conheça o EzInvoice Pro: faturas, clientes e relatórios em um só lugar.\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return '$kind para EzInvoice';
  }

  @override
  String get supportEmailSubject => 'Suporte EzInvoice';

  @override
  String get changePassword => 'Alterar senha';

  @override
  String get changePasswordSubtitle => 'Atualize a senha da sua conta.';

  @override
  String get confirmCurrentPasswordHint =>
      'Por segurança, confirme primeiro sua senha atual.';

  @override
  String get currentPassword => 'Senha atual';

  @override
  String get newPassword => 'Nova senha';

  @override
  String get confirmNewPassword => 'Confirmar nova senha';

  @override
  String get updatePassword => 'Atualizar senha';

  @override
  String get passwordAtLeastSix => 'Deve ter pelo menos 6 caracteres.';

  @override
  String get noActiveSession => 'Não há sessão ativa.';

  @override
  String get passwordsDoNotMatch => 'A nova senha não corresponde.';

  @override
  String get passwordMustDiffer => 'A nova senha deve ser diferente.';

  @override
  String get passwordUpdated => 'Senha atualizada com sucesso.';

  @override
  String get incorrectPassword => 'A senha atual está incorreta.';

  @override
  String get weakPassword => 'A nova senha é muito fraca.';

  @override
  String get reauthenticationNeeded =>
      'Por segurança, entre novamente e tente outra vez.';

  @override
  String get changePasswordError => 'Não foi possível alterar a senha.';

  @override
  String get confirmPassword => 'Confirmar senha';

  @override
  String get reauthCancelled => 'A confirmação foi cancelada.';

  @override
  String get accountDeleted =>
      'Sua conta e seus dados foram excluídos permanentemente.';

  @override
  String get deleteAccountIncorrectPassword => 'Senha incorreta.';

  @override
  String get deleteAccountError => 'Não foi possível excluir a conta.';

  @override
  String get deleteAccountBody =>
      'Se você excluir sua conta:\n\n• Seus clientes, faturas, relatórios e perfil do negócio serão excluídos permanentemente.\n• Esta ação não pode ser desfeita.\n• Se tiver uma assinatura ativa, gerencie ou cancele na App Store/Google Play.';

  @override
  String get termsConditions => 'Termos e condições';

  @override
  String get agreeTermsPrivacy =>
      'Primeiro concorde com os Termos e condições e a Política de privacidade.';

  @override
  String get currentPlan => 'Plano atual';

  @override
  String get currentPlanFree => 'Plano atual: Grátis';

  @override
  String get proPlanDescription =>
      'O plano grátis inclui anúncios e uso limitado. O Pro remove anúncios e libera faturas ilimitadas, relatórios, modelos premium, exportações e backup na nuvem.';

  @override
  String get adsIncluded => 'Inclui anúncios';

  @override
  String get limitedInvoicesPerMonth => 'Faturas limitadas por mês';

  @override
  String get basicInvoiceStyle => 'Estilo básico de fatura';

  @override
  String get basicReports => 'Relatórios básicos';

  @override
  String get pdfIncludesBranding => 'O PDF inclui a marca EzInvoice';

  @override
  String get unpaidLabel => 'Não paga';

  @override
  String get loading => 'Carregando...';

  @override
  String get store => 'Loja';

  @override
  String get storeProductLoadingOne =>
      'Um produto de assinatura ainda está carregando. Você pode continuar com o plano disponível enquanto o outro produto carrega.';

  @override
  String get storeProductsLoading =>
      'Conectando aos produtos de assinatura da loja. Se não terminar de carregar, confirme que as assinaturas estão prontas no console da loja.';

  @override
  String get agreeTo => 'Eu concordo com os ';

  @override
  String get and => ' e a ';

  @override
  String get currentProPlanDescription =>
      'Você já tem o Ez Invoice Pro. Você pode revisar as duas opções de assinatura abaixo.';

  @override
  String freeVsPro(Object pro) {
    return 'Grátis vs $pro';
  }

  @override
  String get openInvoices => 'Abra as faturas.';

  @override
  String get allCaughtUp => 'Tudo em dia';

  @override
  String itemsToReview(Object count) {
    return '$count para revisar';
  }

  @override
  String get pdfInvoice => 'Fatura';

  @override
  String get pdfReceipt => 'Recibo';

  @override
  String get pdfBusiness => 'Negócio';

  @override
  String get pdfPhone => 'Telefone';

  @override
  String get pdfEmail => 'E-mail';

  @override
  String get pdfNumber => 'Nº';

  @override
  String get pdfDate => 'Data';

  @override
  String get pdfDue => 'Vencimento';

  @override
  String get pdfPaid => 'Paga';

  @override
  String get pdfPaidDate => 'Data de pagamento';

  @override
  String get pdfMethod => 'Método';

  @override
  String get pdfBillTo => 'Cobrar de';

  @override
  String get pdfClient => 'Cliente';

  @override
  String get pdfDescription => 'Descrição';

  @override
  String get pdfQuantity => 'Qtd.';

  @override
  String get pdfPrice => 'Preço';

  @override
  String get pdfSubtotal => 'Subtotal';

  @override
  String get pdfTax => 'Imposto';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'Imposto ($rate%)';
  }

  @override
  String get pdfTip => 'Gorjeta';

  @override
  String pdfTipWithRate(Object rate) {
    return 'Gorjeta ($rate%)';
  }

  @override
  String get pdfDiscount => 'Desconto';

  @override
  String get pdfMessage => 'Mensagem';

  @override
  String get pdfPaymentNote => 'Nota de pagamento';

  @override
  String get pdfThankYou => 'Obrigado pela sua preferência.';

  @override
  String get pdfPoweredBy => 'Desenvolvido por EzInvoice';

  @override
  String get pdfFreeVersion => 'VERSÃO GRÁTIS';

  @override
  String get pdfTotal => 'Total';

  @override
  String get styleMinimal => 'Minimal';

  @override
  String get styleProfessional => 'Profissional';

  @override
  String get styleCorporate => 'Corporativo';

  @override
  String get styleModern => 'Moderno';

  @override
  String get styleSlate => 'Ardósia';

  @override
  String get reportDocument => 'Relatório';

  @override
  String get reportPrintDocument => 'Imprimir relatório';

  @override
  String get reportMonth => 'Mês';

  @override
  String get reportYear => 'Ano';

  @override
  String get reportGeneratedOn => 'Gerado em';

  @override
  String get reportInvoices => 'Faturas';

  @override
  String get reportStatus => 'Status';

  @override
  String get reportTotals => 'Totais';

  @override
  String get reportSales => 'Vendas';

  @override
  String get reportTotalTax => 'Total de impostos';

  @override
  String get reportTotalTip => 'Total de gorjetas';

  @override
  String get reportTotalInvoiced => 'Total faturado';

  @override
  String get reportUnsent => 'Não enviada';

  @override
  String get reportSent => 'Enviada';

  @override
  String get reportPaid => 'Paga';

  @override
  String get reportOverdue => 'Vencida';

  @override
  String get reportInvoiceNumber => 'Nº da fatura';

  @override
  String get reportClient => 'Cliente';

  @override
  String get reportDueDate => 'Data de vencimento';

  @override
  String get reportDescription => 'Descrição';

  @override
  String get reportDate => 'Data';

  @override
  String get reportFreeVersion => 'VERSÃO GRATUITA';

  @override
  String get reportPoweredBy => 'Desenvolvido por EzInvoice';

  @override
  String reportPdfShareText(Object title) {
    return 'Relatório PDF: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'Relatório CSV: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'Imprimir: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'Relatório_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'Relatório_Ano_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'Relatório | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'Relatório | $year';
  }

  @override
  String get reportBreakdown => 'Detalhamento';

  @override
  String get reportInvoicesStatus => 'Status das faturas';

  @override
  String get viewReport => 'Ver relatório';

  @override
  String get reviewBeforeExport => 'Revise o PDF ou CSV antes de exportar.';

  @override
  String get customizeReport => 'Personalize o relatório';

  @override
  String get reportPreviewUpdates =>
      'As mudanças aparecem imediatamente na prévia.';

  @override
  String get yourReportPreview => 'Prévia do seu relatório';

  @override
  String get reportStyleLiveHint => 'Altere o design e veja ao vivo.';

  @override
  String get watchAdToExportReport =>
      'Assista ao anúncio completo para exportar este relatório. Atualize para Pro para exportar sem anúncios.';

  @override
  String reportExportError(Object error) {
    return 'Não foi possível exportar o relatório: $error';
  }

  @override
  String get shareCsvFile => 'Compartilhar arquivo CSV';

  @override
  String get shareCsvFileDescription =>
      'Compartilhe o anexo .csv por e-mail, Drive ou outro app.';

  @override
  String get shareReportAsText => 'Compartilhar como texto (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription =>
      'Envie um resumo do relatório como texto.';

  @override
  String get printCsv => 'Imprimir CSV';

  @override
  String get printReportDescription => 'Imprima o relatório como tabela PDF.';

  @override
  String get reportPreview => 'Prévia';

  @override
  String get live => 'Ao vivo';

  @override
  String get proFeatureUnlimitedInvoices => 'Faturas ilimitadas';

  @override
  String get proFeatureRemovePdfBranding => 'Remover marca do PDF';

  @override
  String get proFeatureExportCsv => 'Exportar CSV';

  @override
  String get proFeaturePremiumTemplates => 'Modelos premium';

  @override
  String get proFeatureDetailedTaxReport => 'Relatório fiscal detalhado';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'O plano gratuito permite até $limit faturas por mês.';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'Remove “Desenvolvido por EzInvoice” dos PDFs.';

  @override
  String get proFeatureExportCsvDescription => 'Exporte suas faturas para CSV.';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'Desbloqueie modelos de fatura premium.';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'Veja relatórios detalhados de impostos.';

  @override
  String get pdfShareText => 'PDF da fatura do EzInvoice';

  @override
  String get rewardedExportTitle => 'Exportar este relatório';

  @override
  String get watchAd => 'Ver anúncio';

  @override
  String get rewardedAdCouldNotComplete =>
      'Não foi possível concluir o anúncio. Tente novamente em instantes.';
}
