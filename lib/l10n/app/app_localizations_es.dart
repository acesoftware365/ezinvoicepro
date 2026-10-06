// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Ez Invoice';

  @override
  String get loginSubtitle => 'Crea tu cuenta';

  @override
  String get email => 'Email';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get register => 'Crear cuenta';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta?';

  @override
  String get signUp => 'Registrarse';

  @override
  String get processing => 'Procesando...';

  @override
  String get invalidCredentials =>
      'Ingresa un email válido y contraseña (6+ caracteres)';

  @override
  String get authError => 'Error de autenticación';

  @override
  String get home => 'Inicio';

  @override
  String get clients => 'Clientes';

  @override
  String get invoices => 'Facturas';

  @override
  String get reports => 'Reportes';

  @override
  String get settings => 'Ajustes';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get business => 'Negocio';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDescription => 'Elige el idioma de la app.';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String clientMessageTemplateMultiline(Object name) {
    return 'Hola $name,\nte envío tu factura desde EzInvoice. ✅';
  }

  @override
  String get invoiceEmailSubject => 'Factura - EzInvoice';

  @override
  String get dashboardTitle => 'Panel';

  @override
  String get monthWord => 'Mes';

  @override
  String get planLabel => 'Plan';

  @override
  String get invoicesRemaining => 'Facturas restantes';

  @override
  String get proUnlimitedLabel => 'PRO · Ilimitado';

  @override
  String get createNewInvoice => 'Crear nueva factura';

  @override
  String get limitReachedSubtitle => 'Límite alcanzado • Actualiza a Pro';

  @override
  String get createInvoiceFastSubtitle => 'Crea factura + PDF en segundos';

  @override
  String get limitReachedTitle => 'Límite alcanzado';

  @override
  String get limitReachedBody =>
      'Actualiza a Pro para facturas ilimitadas y eliminar anuncios.';

  @override
  String get upgrade => 'Actualizar';

  @override
  String get monthSummaryTitle => 'Resumen del mes';

  @override
  String get salesTitle => 'Ventas';

  @override
  String get tipTitle => 'Propina';

  @override
  String get subtotalTitle => 'Subtotal';

  @override
  String get taxTitle => 'Impuesto';

  @override
  String get beforeTaxTip => 'Antes de impuesto/propina';

  @override
  String get collectedThisMonth => 'Cobrado este mes';

  @override
  String get quickAccessTitle => 'Acceso rápido';

  @override
  String get clientsManageSubtitle => 'Crear / editar clientes';

  @override
  String get invoicesViewSendSubtitle => 'Ver y enviar PDF';

  @override
  String get monthlyYearlySubtitle => 'Mensual / anual';

  @override
  String get businessProfileSubtitle => 'Perfil / logo / impuesto';

  @override
  String invoiceCount(Object count) {
    return '$count factura(s)';
  }

  @override
  String get paywallTitle => 'Ez Invoice Pro';

  @override
  String get close => 'Cerrar';

  @override
  String get paywallHeaderTitle => 'Desbloquea todo para tu negocio';

  @override
  String get paywallHeaderSubtitle =>
      'Sin anuncios • Facturas ilimitadas • Reportes de impuestos • Plantillas premium';

  @override
  String get bestValue => 'Mejor opción';

  @override
  String get proYearly => 'Pro anual';

  @override
  String get saveMoreYearly => 'Ahorra más pagando anual';

  @override
  String get proMonthly => 'Pro mensual';

  @override
  String get flexible => 'Flexible';

  @override
  String get cancelAnytime => 'Cancela cuando quieras';

  @override
  String get processingPurchase => 'Procesando compra…';

  @override
  String get restoringPurchases => 'Restaurando compras…';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get continueFreeWithAds => 'Continuar con versión gratis con anuncios';

  @override
  String get alreadyProTitle => 'Eres Pro ✅';

  @override
  String get alreadyProBody =>
      'Disfruta facturas ilimitadas, reportes y sin anuncios.';

  @override
  String get continueText => 'Continuar';

  @override
  String get includesInPro => 'Incluido en Pro';

  @override
  String get benefitNoAds => 'Sin anuncios (Banner/Interstitial/Rewarded)';

  @override
  String get benefitUnlimitedInvoices =>
      'Facturas ilimitadas + estados (borrador/enviada/pagada)';

  @override
  String get benefitPremiumTemplates =>
      'Plantillas premium + colores + logo del negocio';

  @override
  String get benefitNoWatermarkPdf => 'PDF profesional sin marca de agua';

  @override
  String get benefitTaxReports =>
      'Reportes de impuestos: mensual y anual (impuestos/propinas/neto)';

  @override
  String get benefitExport => 'Exportar PDF/CSV/Excel (contabilidad)';

  @override
  String get benefitCloudBackup =>
      'Respaldo en la nube + restaurar (multi-dispositivo)';

  @override
  String continueWithPlan(Object plan) {
    return 'Continuar con $plan';
  }

  @override
  String paywallFinePrint(Object store) {
    return 'Al suscribirte, el pago se cargará a tu cuenta de $store. La suscripción se renueva automáticamente a menos que la canceles al menos 24 horas antes de que termine el período actual. Puedes administrar o cancelar tu suscripción en la configuración de tu tienda.';
  }

  @override
  String get reportsTitle => 'Reportes';

  @override
  String get proBadge => 'PRO';

  @override
  String get byMonth => 'Por mes';

  @override
  String get byYear => 'Por año';

  @override
  String get monthLabel => 'Mes';

  @override
  String get yearLabel => 'Año';

  @override
  String get businessProfileTitle => 'Perfil del negocio';

  @override
  String get save => 'Guardar';

  @override
  String get uploadLogo => 'Subir logo';

  @override
  String get remove => 'Quitar';

  @override
  String get businessNameLabel => 'Nombre del negocio';

  @override
  String get ownerNameLabel => 'Dueño / contacto';

  @override
  String get phoneLabel => 'Teléfono';

  @override
  String get addressLabel => 'Dirección';

  @override
  String get currencyLabel => 'Moneda';

  @override
  String get taxDefaultLabel => 'Impuesto predeterminado (%)';

  @override
  String get invalidNumber => 'Número inválido';

  @override
  String get range0to100 => 'Debe estar entre 0 y 100';

  @override
  String get requiredField => 'Requerido';

  @override
  String get footerNoteLabel => 'Nota al pie (PDF)';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get businessFooterDefault => 'Gracias por su preferencia.';

  @override
  String get businessSavedSuccess =>
      'Perfil del negocio guardado correctamente';

  @override
  String get businessInfoSection => 'Información del negocio';

  @override
  String get settingsSection => 'Ajustes';

  @override
  String get footerSection => 'Nota al pie (PDF)';

  @override
  String get upgradeToPro => 'Actualizar a Pro';

  @override
  String get bestValueStar => '⭐ Mejor opción';

  @override
  String get invoicesTitle => 'Facturas';

  @override
  String get noInvoicesYet => 'Aún no hay facturas.';

  @override
  String freePlanMonthlyLimitBanner(Object limit) {
    return 'Plan gratis: límite mensual $limit facturas • Actualiza para ilimitadas';
  }

  @override
  String get filtersTitle => 'Filtros';

  @override
  String get clientLabel => 'Cliente';

  @override
  String get allMonths => 'Todos los meses';

  @override
  String get allClients => 'Todos los clientes';

  @override
  String get clear => 'Limpiar';

  @override
  String get invoicesSummaryLabel => 'Facturas';

  @override
  String get totalTitle => 'Total';

  @override
  String get dateLabel => 'Fecha';

  @override
  String get noResultsForFilters =>
      'No hay resultados para los filtros seleccionados.';

  @override
  String freePlanLimitDialogBody(Object current, Object limit) {
    return 'Plan gratis: $current / $limit facturas este mes.\n\nActualiza a Pro para ilimitadas.';
  }

  @override
  String get deleteInvoiceTitle => '¿Eliminar factura?';

  @override
  String deleteInvoiceBody(Object invNo) {
    return '¿Seguro que quieres eliminar $invNo?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get sendPdf => 'Enviar PDF';

  @override
  String shareInvoiceText(Object invNo, Object client) {
    return 'Factura $invNo - $client';
  }

  @override
  String pdfSendError(Object error) {
    return 'Error al crear/enviar PDF: $error';
  }

  @override
  String reportTitleMonth(Object month, Object year) {
    return 'Reporte • $month $year';
  }

  @override
  String reportTitleYear(Object year) {
    return 'Reporte • Año $year';
  }

  @override
  String invoicesLine(Object count) {
    return 'Facturas: $count';
  }

  @override
  String totalSalesLine(Object amount) {
    return 'Ventas totales: \$$amount';
  }

  @override
  String totalTaxLine(Object amount) {
    return 'Impuesto total: \$$amount';
  }

  @override
  String totalTipLine(Object amount) {
    return 'Propina total: \$$amount';
  }

  @override
  String netLine(Object amount) {
    return 'Neto: \$$amount';
  }

  @override
  String get calculatedFromInvoices =>
      'Calculado desde tus facturas en Firestore.';

  @override
  String get noInvoicesInPeriod => 'No hay facturas en ese período.';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get yearlyProReason =>
      'El reporte anual es PRO. Actualiza para desbloquearlo.';

  @override
  String get exportPdfProReason => 'Exportar el PDF del reporte es PRO.';

  @override
  String get exportCsvProReason => 'Exportar CSV es PRO.';

  @override
  String get noDataToExport => 'No hay datos para exportar.';

  @override
  String get freePlanReportsNote =>
      'Plan gratis: solo reportes mensuales. Actualiza para reportes anuales y exportar.';

  @override
  String get genericError => 'Algo salió mal. Intenta de nuevo.';

  @override
  String get newInvoiceTitle => 'Nueva factura';

  @override
  String get editInvoiceTitle => 'Editar factura';

  @override
  String get pickClient => 'Elegir cliente';

  @override
  String get invoiceAutoNumberLabel => 'Factura # (auto)';

  @override
  String invoiceDateLabel(Object date) {
    return 'Fecha de factura: $date';
  }

  @override
  String get clientNameLabel => 'Nombre del cliente';

  @override
  String get clientNameRequired => 'Nombre del cliente requerido';

  @override
  String get clientEmailOptionalLabel => 'Email del cliente (opcional)';

  @override
  String get clientPhoneOptionalLabel => 'Teléfono del cliente (opcional)';

  @override
  String get invalidEmailFormat => 'Formato de email inválido';

  @override
  String get itemsTitle => 'Items';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String itemDateLabel(Object date) {
    return 'Fecha del item: $date';
  }

  @override
  String get qtyLabel => 'Cant.';

  @override
  String get priceLabel => 'Precio';

  @override
  String lineTotalLabel(Object amount) {
    return 'Total de línea: \$$amount';
  }

  @override
  String get taxDefaultOwnerLabel => 'Impuesto % (dueño predeterminado)';

  @override
  String get tipPercentChip => 'Propina %';

  @override
  String get tipAmountChip => 'Propina \$';

  @override
  String get tipPercentLabel => 'Porcentaje de propina (%)';

  @override
  String get tipAmountLabel => 'Monto de propina (\$)';

  @override
  String get messageOptionalLabel => 'Mensaje (opcional)';

  @override
  String totalsBlock(Object sub, Object tax, Object tip, Object total) {
    return 'Subtotal: \$$sub\nImpuesto: \$$tax\nPropina: \$$tip\nTotal: \$$total';
  }

  @override
  String get saving => 'Guardando…';

  @override
  String get saveInvoice => 'Guardar factura';

  @override
  String get updateInvoice => 'Actualizar factura';

  @override
  String get addAtLeastOneItem => 'Agrega al menos 1 item';

  @override
  String errorSavingInvoice(Object error) {
    return 'Error al guardar factura: $error';
  }

  @override
  String get savedTab => 'Guardados';

  @override
  String get contactsTab => 'Contactos';

  @override
  String get noSavedClients => 'No hay clientes guardados';

  @override
  String get permissionDeniedContacts => 'Permiso denegado: Contactos';

  @override
  String get noContactsFound =>
      'No se encontraron contactos en este dispositivo/emulador';

  @override
  String contactsError(Object error) {
    return 'Error de contactos: $error';
  }

  @override
  String get noName => '(Sin nombre)';

  @override
  String get newClientTitle => 'Nuevo cliente';

  @override
  String get editClientTitle => 'Editar cliente';

  @override
  String get clientInfoSection => 'Información del cliente';

  @override
  String get notesLabel => 'Notas';

  @override
  String get notesHint => 'Agregar notas (opcional)';

  @override
  String get clientCreateHint =>
      'Tip: Agrega email/teléfono para enviar facturas más rápido.';

  @override
  String get clientEditHint =>
      'Puedes actualizar la info del cliente cuando quieras.';

  @override
  String errorSavingClient(Object error) {
    return 'Error al guardar cliente: $error';
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
  String get noClientsYet => 'Aún no hay clientes.';

  @override
  String get noClientsForSearch =>
      'No hay clientes que coincidan con tu búsqueda.';

  @override
  String get cannotOpenDialer => 'No se puede abrir el marcador';

  @override
  String get cannotOpenSms => 'No se puede abrir SMS';

  @override
  String get whatsAppNotAvailable => 'WhatsApp no está disponible';

  @override
  String get cannotOpenEmail => 'No se puede abrir email';

  @override
  String get deleteClientTitle => '¿Eliminar cliente?';

  @override
  String deleteClientBody(Object name) {
    return '¿Quitar a $name?';
  }

  @override
  String get call => 'Llamar';

  @override
  String get sms => 'SMS';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailAction => 'Email';

  @override
  String get shareAppTitle => 'Prueba EzInvoice 👇';

  @override
  String get shareAppBody =>
      'Crea facturas, envía PDFs y controla reportes fácilmente.';

  @override
  String get shareAppTooltip => 'Compartir app';

  @override
  String get openGooglePlayTooltip => 'Abrir Google Play';

  @override
  String get openAppStoreTooltip => 'Abrir App Store';

  @override
  String get openWebsiteTooltip => 'Abrir sitio web';

  @override
  String get availableLanguages => 'Idiomas disponibles';

  @override
  String get usePhoneLanguage => 'Usar el idioma del teléfono';

  @override
  String shareReceiptText(Object invoiceNumber, Object clientName) {
    return 'Recibo $invoiceNumber para $clientName';
  }

  @override
  String get report => 'Reporte';

  @override
  String get invoicesLabel => 'Facturas';

  @override
  String get totalSalesLabel => 'Ventas totales';

  @override
  String get totalTaxLabel => 'Impuesto total';

  @override
  String get totalTipLabel => 'Propina total';

  @override
  String get netLabel => 'Neto';

  @override
  String get sentLabel => 'Enviadas';

  @override
  String get paidLabel => 'Pagadas';

  @override
  String get overdueLabel => 'Vencidas';

  @override
  String get reportCalculatedHint => 'Calculado desde tus facturas.';

  @override
  String get exportPdfComingSoon => 'Exportar PDF (pronto)';

  @override
  String get exportCsvComingSoon => 'Exportar CSV (pronto)';

  @override
  String get unsentLabel => 'No enviadas';

  @override
  String get servicePresetsTitle => 'Servicios guardados';

  @override
  String get servicePresetsScreenTitle => 'Servicios guardados';

  @override
  String get servicePresetsAddNew => 'Agregar nuevo servicio';

  @override
  String get servicePresetsHint => 'ej. Limpieza, Reparación, Consultoría...';

  @override
  String get servicePresetsAddButton => 'Agregar';

  @override
  String get addServiceLabel => 'Agregar un servicio';

  @override
  String get yourPresets => 'Tus servicios guardados';

  @override
  String get noPresetsYet => 'Aún no hay servicios guardados.';

  @override
  String get notNow => 'Ahora no';

  @override
  String get openPaywallPlaceholder => 'Abrir suscripción';

  @override
  String get invoiceStyleTitle => 'Estilo de factura';

  @override
  String get invoiceFreeStyleHint =>
      'El plan gratis usa una versión de factura (Minimal). Mejora a Pro para desbloquear todos los diseños y paletas.';

  @override
  String get invoicePaletteLabel => 'Paleta de factura';

  @override
  String get invoiceLayoutLabel => 'Diseño de factura';

  @override
  String get saveInvoicePaletteError =>
      'No se pudo guardar la paleta de factura.';

  @override
  String get saveInvoiceLayoutError =>
      'No se pudo guardar el diseño de factura.';

  @override
  String get reportStyleTitle => 'Estilo de reporte';

  @override
  String get reportFreeStyleHint =>
      'El plan gratis usa una versión de reporte (Minimal). Mejora a Pro para desbloquear todos los diseños y paletas.';

  @override
  String get reportPaletteLabel => 'Paleta de reporte';

  @override
  String get reportLayoutLabel => 'Diseño de reporte';

  @override
  String get saveReportPaletteError =>
      'No se pudo guardar la paleta de reporte.';

  @override
  String get saveReportLayoutError =>
      'No se pudo guardar el diseño de reporte.';

  @override
  String stylePaletteFootnote(Object docType, Object style, Object palette) {
    return 'Estilo de $docType: $style | Paleta: $palette';
  }

  @override
  String get deleteAccountTitle => 'Eliminar cuenta';

  @override
  String get deleteAccountWarning =>
      'Esta acción eliminará permanentemente tu cuenta y todos los datos asociados.';

  @override
  String get deleteAccountButton => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmTitle => 'Confirmar eliminación';

  @override
  String get deleteAccountConfirmMessage =>
      '¿Estás seguro? Esta acción no se puede deshacer.';

  @override
  String get profileSaved => 'Guardado automáticamente';

  @override
  String get profileSaveError => 'No se pudo guardar. Tus cambios siguen aquí.';

  @override
  String get profileRetry => 'Reintentar';

  @override
  String get profileAutosaveHint =>
      'Los cambios se guardan automáticamente y se conservan al cerrar.';

  @override
  String get profileLogo => 'Logo del negocio';

  @override
  String get profileDefaults => 'Valores de factura';

  @override
  String get profileTaxInvalid => 'Revisa el impuesto (0–100 %).';

  @override
  String get metricLoadError =>
      'No se pudo cargar el reporte. Inténtalo de nuevo.';

  @override
  String get totalInvoicedTitle => 'Total facturado';

  @override
  String versionLabel(Object version) {
    return 'Versión $version';
  }

  @override
  String errorWithDetails(Object error) {
    return 'Error: $error';
  }

  @override
  String get rememberEmail => 'Recordar mi email';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get passwordResetEnterEmail =>
      'Ingresa tu email para enviarte el enlace.';

  @override
  String get passwordResetSent =>
      'Te enviamos un email para restablecer tu contraseña. Revisa Spam o Correo no deseado.';

  @override
  String get passwordResetNoAccount =>
      'No encontramos una cuenta con ese email.';

  @override
  String get invalidEmail => 'Email inválido.';

  @override
  String get passwordResetError =>
      'No se pudo enviar el email. Intenta otra vez.';

  @override
  String get updateRequired => 'Actualización requerida';

  @override
  String get updateRequiredBody =>
      'Hay una versión nueva de Ez Invoice. Para continuar, actualiza la app desde la tienda.';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get open => 'Abrir';

  @override
  String get share => 'Compartir';

  @override
  String get actions => 'Acciones';

  @override
  String get message => 'Mensaje';

  @override
  String get done => 'Listo';

  @override
  String get confirm => 'Confirmar';

  @override
  String get free => 'GRATIS';

  @override
  String get clientInformation => 'Información del cliente';

  @override
  String get clientName => 'Nombre del cliente';

  @override
  String get notesOptional => 'Notas (opcional)';

  @override
  String get saveClient => 'Guardar cliente';

  @override
  String get importFromContacts => 'Importar desde contactos';

  @override
  String get importContactsDescription =>
      'Completa nombre, teléfono y email al instante.';

  @override
  String get loadContacts => 'Cargar contactos';

  @override
  String get clientPhone => 'Teléfono del cliente';

  @override
  String get searchContacts => 'Buscar contactos';

  @override
  String get shareClient => 'Compartir cliente';

  @override
  String get clientProfile => 'Perfil del cliente';

  @override
  String get chooseSavedService => 'Elegir servicio guardado';

  @override
  String get searchSavedServices => 'Buscar servicios guardados';

  @override
  String get noSavedServicesFound => 'No se encontraron servicios guardados';

  @override
  String get noSavedServicesToUse =>
      'Aún no hay servicios guardados. Escribe uno arriba y guárdalo para después.';

  @override
  String savedServiceAlreadyExists(Object service) {
    return 'Ya está guardado: $service';
  }

  @override
  String savedService(Object service) {
    return 'Servicio guardado: $service';
  }

  @override
  String savePresetError(Object error) {
    return 'No se pudo guardar el servicio: $error';
  }

  @override
  String get saveServiceForLater => 'Guardar servicio para después';

  @override
  String get removeClient => 'Quitar cliente';

  @override
  String get service => 'Servicio';

  @override
  String get taxAndTip => 'Impuesto y propina';

  @override
  String get totals => 'Totales';

  @override
  String dueDate(Object date) {
    return 'Fecha de vencimiento: $date';
  }

  @override
  String paidDate(Object date) {
    return 'Fecha de pago: $date';
  }

  @override
  String get notPaidYet => 'Aún no pagada';

  @override
  String paymentMethodWithValue(Object method) {
    return 'Método: $method';
  }

  @override
  String paymentNoteWithValue(Object note) {
    return 'Nota: $note';
  }

  @override
  String get markAsPaid => 'Marcar como pagada';

  @override
  String get markAsUnpaid => 'Marcar como no pagada';

  @override
  String get editTax => 'Editar';

  @override
  String get addClient => 'Agregar un cliente';

  @override
  String get firstClientHint =>
      'Crea tu primer cliente para reutilizarlo en futuras facturas.';

  @override
  String get searchSavedClients => 'Buscar clientes guardados';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get cash => 'Efectivo';

  @override
  String get card => 'Tarjeta';

  @override
  String get check => 'Cheque';

  @override
  String get other => 'Otro';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String invoiceMarkPaidError(Object error) {
    return 'No se pudo marcar la factura como pagada: $error';
  }

  @override
  String invoiceMarkUnpaidError(Object error) {
    return 'No se pudo marcar la factura como no pagada: $error';
  }

  @override
  String deleteError(Object error) {
    return 'No se pudo eliminar la factura: $error';
  }

  @override
  String get invoiceDeleted => 'Factura eliminada';

  @override
  String get invoiceMarkedSent => 'Marcada como enviada ✅';

  @override
  String invoiceMarkSentError(Object error) {
    return 'No se pudo marcar como enviada: $error';
  }

  @override
  String get invoiceMarkedUnsent => 'Marcada como no enviada ✅';

  @override
  String invoiceMarkUnsentError(Object error) {
    return 'No se pudo marcar como no enviada: $error';
  }

  @override
  String get invoiceMarkedPaid => 'Marcada como pagada ✅';

  @override
  String get invoiceMarkedUnpaid => 'Marcada como no pagada ✅';

  @override
  String get invoiceLoadingError => 'No se pudieron cargar las facturas';

  @override
  String get tipType => 'Tipo de propina';

  @override
  String get amountOption => 'Monto (\$)';

  @override
  String get percentageOption => 'Porcentaje (%)';

  @override
  String get pdfPreview => 'Vista previa de PDF';

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get sharePdf => 'Compartir PDF';

  @override
  String get selectReportMonth => 'Seleccionar mes del reporte';

  @override
  String reportForBusiness(Object business) {
    return 'Reportes • $business';
  }

  @override
  String get tapToChangeMonth => 'Toca para cambiar el mes';

  @override
  String csvSaved(Object path) {
    return 'CSV guardado: $path';
  }

  @override
  String csvExportError(Object error) {
    return 'No se pudo exportar CSV: $error';
  }

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutTagline => 'Facturas claras para negocios en movimiento';

  @override
  String get aboutAppTitle => 'La aplicación';

  @override
  String get aboutAppBody =>
      'EzInvoice reúne facturas, clientes, pagos y reportes en un flujo simple, para que puedas ver lo importante y cobrar con más claridad.';

  @override
  String get aboutCompanyTitle => 'La compañía';

  @override
  String get aboutCompanyBody =>
      'Liisgo LLC crea herramientas prácticas para ayudar a los pequeños negocios a trabajar con más orden, claridad y confianza.';

  @override
  String get aboutPromiseTitle => 'Pensado para tu día a día';

  @override
  String get aboutPromiseBody =>
      'Cada decisión de EzInvoice busca reducir pasos, mantener los detalles visibles y hacer que administrar tu negocio se sienta más sencillo.';

  @override
  String get visitLiisgo => 'Visitar Liisgo';

  @override
  String get contactSupport => 'Contactar soporte';

  @override
  String get shareEzInvoice => 'Compartir EzInvoice';

  @override
  String get sendIdeaOrBug => 'Enviar una idea o error';

  @override
  String get feedbackTitle => 'Tu opinión cuenta';

  @override
  String get feedbackSubtitle =>
      'Cuéntanos qué te gustaría mejorar o qué no funcionó bien.';

  @override
  String get feedbackIdea => 'Idea';

  @override
  String get feedbackBug => 'Error';

  @override
  String get feedbackHint => 'Escribe tu idea o explica lo que ocurrió…';

  @override
  String get feedbackRequired => 'Escribe un mensaje antes de enviarlo.';

  @override
  String get continueToEmail => 'Continuar al correo';

  @override
  String get couldNotOpenLink => 'No se pudo abrir este enlace.';

  @override
  String shareAppText(Object storeUrl) {
    return 'Conoce EzInvoice Pro: facturas, clientes y reportes en un solo lugar.\n$storeUrl';
  }

  @override
  String feedbackEmailSubject(Object kind) {
    return '$kind para EzInvoice';
  }

  @override
  String get supportEmailSubject => 'Soporte de EzInvoice';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get changePasswordSubtitle => 'Actualiza la contraseña de tu cuenta.';

  @override
  String get confirmCurrentPasswordHint =>
      'Por seguridad, primero confirma tu contraseña actual.';

  @override
  String get currentPassword => 'Contraseña actual';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get confirmNewPassword => 'Confirmar nueva contraseña';

  @override
  String get updatePassword => 'Actualizar contraseña';

  @override
  String get passwordAtLeastSix => 'Debe tener al menos 6 caracteres.';

  @override
  String get noActiveSession => 'No hay sesión activa.';

  @override
  String get passwordsDoNotMatch => 'La nueva contraseña no coincide.';

  @override
  String get passwordMustDiffer => 'La nueva contraseña debe ser diferente.';

  @override
  String get passwordUpdated => 'Contraseña actualizada correctamente.';

  @override
  String get incorrectPassword => 'La contraseña actual es incorrecta.';

  @override
  String get weakPassword => 'La nueva contraseña es muy débil.';

  @override
  String get reauthenticationNeeded =>
      'Por seguridad, vuelve a iniciar sesión e intenta otra vez.';

  @override
  String get changePasswordError => 'No se pudo cambiar la contraseña.';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get reauthCancelled => 'Cancelaste la confirmación.';

  @override
  String get accountDeleted =>
      'Tu cuenta y datos fueron eliminados permanentemente.';

  @override
  String get deleteAccountIncorrectPassword => 'Contraseña incorrecta.';

  @override
  String get deleteAccountError => 'No se pudo eliminar la cuenta.';

  @override
  String get deleteAccountBody =>
      'Si eliminas tu cuenta:\n\n• Se eliminarán permanentemente tus clientes, facturas, reportes y perfil de negocio.\n• Esta acción no se puede deshacer.\n• Si tienes una suscripción activa, debes gestionarla o cancelarla en App Store/Google Play.';

  @override
  String get termsConditions => 'Términos y condiciones';

  @override
  String get agreeTermsPrivacy =>
      'Primero acepta los Términos y condiciones y la Política de privacidad.';

  @override
  String get currentPlan => 'Plan actual';

  @override
  String get currentPlanFree => 'Plan actual: Gratis';

  @override
  String get proPlanDescription =>
      'Gratis incluye anuncios y uso limitado. Pro elimina anuncios y desbloquea facturas ilimitadas, reportes, plantillas premium, exportaciones y respaldo en la nube.';

  @override
  String get adsIncluded => 'Incluye anuncios';

  @override
  String get limitedInvoicesPerMonth => 'Facturas limitadas por mes';

  @override
  String get basicInvoiceStyle => 'Estilo básico de factura';

  @override
  String get basicReports => 'Reportes básicos';

  @override
  String get pdfIncludesBranding => 'El PDF incluye la marca EzInvoice';

  @override
  String get unpaidLabel => 'No pagada';

  @override
  String get loading => 'Cargando...';

  @override
  String get store => 'Tienda';

  @override
  String get storeProductLoadingOne =>
      'Un producto de suscripción todavía está cargando. Puedes continuar con el plan disponible mientras carga el otro producto.';

  @override
  String get storeProductsLoading =>
      'Conectando con los productos de suscripción de la tienda. Si no termina de cargar, confirma que las suscripciones estén listas en la consola de tu tienda.';

  @override
  String get agreeTo => 'Acepto los ';

  @override
  String get and => ' y la ';

  @override
  String get currentProPlanDescription =>
      'Ya tienes Ez Invoice Pro. Puedes revisar las dos opciones de suscripción abajo.';

  @override
  String freeVsPro(Object pro) {
    return 'Gratis vs $pro';
  }

  @override
  String get openInvoices => 'Abre Facturas.';

  @override
  String get allCaughtUp => 'Todo al día';

  @override
  String itemsToReview(Object count) {
    return '$count por revisar';
  }

  @override
  String get pdfInvoice => 'Factura';

  @override
  String get pdfReceipt => 'Recibo';

  @override
  String get pdfBusiness => 'Negocio';

  @override
  String get pdfPhone => 'Teléfono';

  @override
  String get pdfEmail => 'Email';

  @override
  String get pdfNumber => 'Núm.';

  @override
  String get pdfDate => 'Fecha';

  @override
  String get pdfDue => 'Vence';

  @override
  String get pdfPaid => 'Pagada';

  @override
  String get pdfPaidDate => 'Fecha de pago';

  @override
  String get pdfMethod => 'Método';

  @override
  String get pdfBillTo => 'Facturar a';

  @override
  String get pdfClient => 'Cliente';

  @override
  String get pdfDescription => 'Descripción';

  @override
  String get pdfQuantity => 'Cant.';

  @override
  String get pdfPrice => 'Precio';

  @override
  String get pdfSubtotal => 'Subtotal';

  @override
  String get pdfTax => 'Impuesto';

  @override
  String pdfTaxWithRate(Object rate) {
    return 'Impuesto ($rate%)';
  }

  @override
  String get pdfTip => 'Propina';

  @override
  String pdfTipWithRate(Object rate) {
    return 'Propina ($rate%)';
  }

  @override
  String get pdfDiscount => 'Descuento';

  @override
  String get pdfMessage => 'Mensaje';

  @override
  String get pdfPaymentNote => 'Nota de pago';

  @override
  String get pdfThankYou => 'Gracias por su preferencia.';

  @override
  String get pdfPoweredBy => 'Desarrollado por EzInvoice';

  @override
  String get pdfFreeVersion => 'VERSIÓN GRATUITA';

  @override
  String get pdfTotal => 'Total';

  @override
  String get styleMinimal => 'Minimal';

  @override
  String get styleProfessional => 'Profesional';

  @override
  String get styleCorporate => 'Corporativo';

  @override
  String get styleModern => 'Moderno';

  @override
  String get styleSlate => 'Pizarra';

  @override
  String get reportDocument => 'Reporte';

  @override
  String get reportPrintDocument => 'Imprimir reporte';

  @override
  String get reportMonth => 'Mes';

  @override
  String get reportYear => 'Año';

  @override
  String get reportGeneratedOn => 'Generado el';

  @override
  String get reportInvoices => 'Facturas';

  @override
  String get reportStatus => 'Estado';

  @override
  String get reportTotals => 'Totales';

  @override
  String get reportSales => 'Ventas';

  @override
  String get reportTotalTax => 'Total de impuestos';

  @override
  String get reportTotalTip => 'Total de propinas';

  @override
  String get reportTotalInvoiced => 'Total facturado';

  @override
  String get reportUnsent => 'Sin enviar';

  @override
  String get reportSent => 'Enviada';

  @override
  String get reportPaid => 'Pagada';

  @override
  String get reportOverdue => 'Vencida';

  @override
  String get reportInvoiceNumber => 'Núm. de factura';

  @override
  String get reportClient => 'Cliente';

  @override
  String get reportDueDate => 'Fecha de vencimiento';

  @override
  String get reportDescription => 'Descripción';

  @override
  String get reportDate => 'Fecha';

  @override
  String get reportFreeVersion => 'VERSIÓN GRATUITA';

  @override
  String get reportPoweredBy => 'Desarrollado por EzInvoice';

  @override
  String reportPdfShareText(Object title) {
    return 'Reporte PDF: $title';
  }

  @override
  String reportCsvShareText(Object title) {
    return 'Reporte CSV: $title';
  }

  @override
  String reportPrintShareText(Object title) {
    return 'Imprimir: $title';
  }

  @override
  String reportFileMonthly(Object month, Object year) {
    return 'Reporte_${month}_$year';
  }

  @override
  String reportFileYearly(Object year) {
    return 'Reporte_Año_$year';
  }

  @override
  String reportTextMonthly(Object month, Object year) {
    return 'Reporte | $month $year';
  }

  @override
  String reportTextYearly(Object year) {
    return 'Reporte | $year';
  }

  @override
  String get reportBreakdown => 'Desglose';

  @override
  String get reportInvoicesStatus => 'Estado de facturas';

  @override
  String get viewReport => 'Ver reporte';

  @override
  String get reviewBeforeExport => 'Revisa el PDF o CSV antes de exportarlo.';

  @override
  String get customizeReport => 'Personaliza el reporte';

  @override
  String get reportPreviewUpdates =>
      'Los cambios aparecen de inmediato en tu vista previa.';

  @override
  String get yourReportPreview => 'Vista de tu reporte';

  @override
  String get reportStyleLiveHint => 'Cambia el diseño y míralo en vivo.';

  @override
  String get watchAdToExportReport =>
      'Mira el anuncio completo para exportar este reporte. Actualiza a Pro para exportar sin anuncios.';

  @override
  String reportExportError(Object error) {
    return 'No se pudo exportar el reporte: $error';
  }

  @override
  String get shareCsvFile => 'Compartir archivo CSV';

  @override
  String get shareCsvFileDescription =>
      'Comparte el archivo .csv por email, Drive u otra app.';

  @override
  String get shareReportAsText => 'Compartir como texto (WhatsApp / SMS)';

  @override
  String get shareReportAsTextDescription =>
      'Envía un resumen del reporte como texto.';

  @override
  String get printCsv => 'Imprimir CSV';

  @override
  String get printReportDescription => 'Imprime el reporte como tabla PDF.';

  @override
  String get reportPreview => 'Vista previa';

  @override
  String get live => 'En vivo';

  @override
  String get proFeatureUnlimitedInvoices => 'Facturas ilimitadas';

  @override
  String get proFeatureRemovePdfBranding => 'Eliminar marca del PDF';

  @override
  String get proFeatureExportCsv => 'Exportar CSV';

  @override
  String get proFeaturePremiumTemplates => 'Plantillas premium';

  @override
  String get proFeatureDetailedTaxReport => 'Reporte detallado de impuestos';

  @override
  String proFeatureUnlimitedInvoicesDescription(Object limit) {
    return 'El plan gratis permite hasta $limit facturas por mes.';
  }

  @override
  String get proFeatureRemovePdfBrandingDescription =>
      'Elimina “Desarrollado por EzInvoice” de los PDFs.';

  @override
  String get proFeatureExportCsvDescription => 'Exporta tus facturas a CSV.';

  @override
  String get proFeaturePremiumTemplatesDescription =>
      'Desbloquea plantillas premium de facturas.';

  @override
  String get proFeatureDetailedTaxReportDescription =>
      'Consulta reportes detallados de impuestos.';

  @override
  String get pdfShareText => 'PDF de factura de EzInvoice';
}
