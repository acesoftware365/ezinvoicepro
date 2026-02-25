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
  String get reportCalculatedHint =>
      'Calculado desde tus facturas en Firestore.';

  @override
  String get exportPdfComingSoon => 'Exportar PDF (pronto)';

  @override
  String get exportCsvComingSoon => 'Exportar CSV (pronto)';

  @override
  String get unsentLabel => 'No enviadas';

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
}
