import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  // Brand
  static const Color brandGreen = Color(0xFF1F6E5C);

  // Company/App
  static const String company = 'Liisgo LLC';
  static const String appName = 'EzInvoice';
  static const String website = 'https://liisgo.com/#/apps/EzInvoice';
  static const String supportEmail = 'sales@liisgo.com';

  // IMPORTANT: set a FIXED date (don't change daily)
  static const String lastUpdatedEn = 'January 11, 2026';
  static const String lastUpdatedEs = '11 de enero de 2026';

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    final isEs = _isSpanish(context);

    if (uri.scheme == 'mailto') {
      final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
      if (!launched) {
        await _showEmailFallbackDialog(isEs: isEs);
      }
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      _showSnack(
        isEs ? 'No se pudo abrir el enlace.' : 'Could not open the link.',
      );
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _showEmailFallbackDialog({required bool isEs}) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEs ? 'Soporte por email' : 'Email Support'),
        content: Text(
          isEs
              ? 'No se pudo abrir la app de correo.\n\nEmail: $supportEmail'
              : 'Could not open the mail app.\n\nEmail: $supportEmail',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(isEs ? 'Cerrar' : 'Close'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await Clipboard.setData(const ClipboardData(text: supportEmail));
              _showSnack(
                isEs
                    ? 'Email copiado al portapapeles.'
                    : 'Support email copied to clipboard.',
              );
            },
            child: Text(isEs ? 'Copiar email' : 'Copy email'),
          ),
        ],
      ),
    );
  }

  bool _isSpanish(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'es';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEs = _isSpanish(context);

    final title = isEs ? 'Política de privacidad' : 'Privacy Policy';
    final lastUpdatedLabel = isEs ? 'Ultima actualizacion' : 'Last updated';
    final lastUpdatedValue = isEs ? lastUpdatedEs : lastUpdatedEn;

    return Theme(
      data: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$lastUpdatedLabel: $lastUpdatedValue',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 8),

              _section(
                title: isEs ? 'Resumen' : 'Overview',
                body: isEs
                    ? '$company ("nosotros") opera la aplicación móvil $appName (la "App"). '
                          'Esta Política de privacidad explica cómo recopilamos, usamos, divulgamos y protegemos la información cuando usas la App.'
                    : '$company ("we", "our", or "us") operates the $appName mobile application (the "App"). '
                          'This Privacy Policy explains how we collect, use, disclose, and protect information when you use the App.',
              ),

              _section(
                title: isEs
                    ? 'Información que recopilamos'
                    : 'Information We Collect',
                body: isEs
                    ? 'Dependiendo de cómo uses la App, podemos recopilar:\n'
                          '• Información de cuenta y negocio que proporcionas (ej.: nombre del negocio, dirección, logo).\n'
                          '• Datos de facturas que creas (ej.: nombre del cliente, items, montos, impuesto/propina).\n'
                          '• Datos del dispositivo y uso (ej.: interacciones, diagnósticos, reportes de fallos).\n'
                          '• Acceso opcional a contactos (solo si eliges importar clientes desde tus contactos).'
                    : 'Depending on how you use the App, we may collect:\n'
                          '• Account and business info you provide (e.g., business name, address, logo).\n'
                          '• Invoice data you create (e.g., customer name, items, amounts, tax/tip).\n'
                          '• Device and usage data (e.g., app interactions, diagnostics, crash logs).\n'
                          '• Optional contacts access (only if you choose to import customers from your phone contacts).',
              ),

              _section(
                title: isEs
                    ? 'Cómo usamos la información'
                    : 'How We Use Information',
                body: isEs
                    ? 'Usamos la información para:\n'
                          '• Proveer y mejorar funciones (facturas, PDFs, reportes).\n'
                          '• Guardar preferencias y ajustes.\n'
                          '• Dar soporte y responder solicitudes.\n'
                          '• Prevenir fraude/abuso y hacer cumplir nuestros términos.\n'
                          '• Cumplir obligaciones legales.'
                    : 'We use information to:\n'
                          '• Provide and improve app features (invoices, PDFs, reports).\n'
                          '• Save your preferences and settings.\n'
                          '• Provide support and respond to requests.\n'
                          '• Prevent fraud, abuse, and enforce our terms.\n'
                          '• Comply with legal obligations.',
              ),

              _section(
                title: isEs ? 'Compartir datos' : 'Data Sharing',
                body: isEs
                    ? 'No vendemos tu información personal.\n\n'
                          'Solo compartimos información en casos limitados:\n'
                          '• Proveedores de servicios (ej.: analítica, crash reporting, pagos) para operar la App.\n'
                          '• Cumplimiento legal (si la ley lo requiere).\n'
                          '• Transferencias comerciales (fusión, adquisición o venta de activos).'
                    : 'We do not sell your personal information.\n\n'
                          'We may share information only in limited cases:\n'
                          '• Service providers (e.g., analytics, crash reporting, payment processing) to operate the App.\n'
                          '• Legal compliance (if required by law or valid legal request).\n'
                          '• Business transfers (if we are involved in a merger, acquisition, or asset sale).',
              ),

              _section(
                title: isEs
                    ? 'Pagos y suscripciones'
                    : 'Payments & Subscriptions',
                body: isEs
                    ? 'Si compras una suscripción, los pagos son procesados por Apple App Store o Google Play. '
                          'Nosotros no recibimos ni almacenamos los detalles completos de tu tarjeta. '
                          'El estado de la suscripción se usa para desbloquear funciones Pro.'
                    : 'If you purchase a subscription, payments are processed by Apple App Store or Google Play. '
                          'We do not receive or store your full payment card details. '
                          'Subscription status may be used to unlock Pro features.',
              ),

              _section(
                title: isEs
                    ? 'Publicidad (versión gratis)'
                    : 'Advertising (Free Version)',
                body: isEs
                    ? 'La versión gratis puede mostrar anuncios. Los socios de anuncios pueden recopilar identificadores '
                          'limitados del dispositivo para mostrar anuncios y medir rendimiento. '
                          'Puedes eliminar anuncios mejorando a Pro (si está disponible).'
                    : 'The free version may display ads. Ad partners may collect limited device identifiers to show ads and measure performance. '
                          'You can remove ads by upgrading to Pro (if available in your plan).',
              ),

              _section(
                title: isEs ? 'Contactos (opcional)' : 'Contacts (Optional)',
                body: isEs
                    ? 'Si otorgas permiso de contactos, la App puede leer datos de contactos para ayudarte a elegir clientes más rápido. '
                          'Puedes negar o revocar este permiso en cualquier momento en la configuración del dispositivo.'
                    : 'If you grant contacts permission, the App can read contact data to help you select customers faster. '
                          'You can deny or revoke this permission at any time in your device settings.',
              ),

              _section(
                title: isEs ? 'Retención de datos' : 'Data Retention',
                body: isEs
                    ? 'Retenemos información solo el tiempo necesario para proveer la App y por propósitos legítimos '
                          '(como cumplimiento, resolución de disputas y hacer cumplir políticas).'
                    : 'We retain information only as long as necessary to provide the App and for legitimate business purposes '
                          '(such as compliance, dispute resolution, and enforcement).',
              ),

              _section(
                title: isEs ? 'Seguridad' : 'Security',
                body: isEs
                    ? 'Usamos medidas razonables para proteger la información. Sin embargo, ningún método de transmisión '
                          'o almacenamiento es 100% seguro.'
                    : 'We use reasonable safeguards to protect information. However, no method of transmission or storage is 100% secure.',
              ),

              _section(
                title: isEs ? 'Tus derechos' : 'Your Rights',
                body: isEs
                    ? 'Dependiendo de tu ubicación, puedes tener derecho a acceder, corregir, eliminar o exportar tus datos. '
                          'Para solicitar ayuda con tus datos, contáctanos.'
                    : 'Depending on your location, you may have rights to access, correct, delete, or export your data. '
                          'To request help with your data, contact us.',
              ),

              _section(
                title: isEs ? 'Privacidad de menores' : "Children's Privacy",
                body: isEs
                    ? 'La App no está dirigida a menores de 13 años y no recopilamos intencionalmente información personal de menores.'
                    : 'The App is not intended for children under 13 and we do not knowingly collect personal information from children.',
              ),

              _section(
                title: isEs
                    ? 'Cambios a esta política'
                    : 'Changes to This Policy',
                body: isEs
                    ? 'Podemos actualizar esta Política de privacidad ocasionalmente. Las actualizaciones se publicarán en la App '
                          'y/o en nuestro sitio web.'
                    : 'We may update this Privacy Policy from time to time. Updates will be posted in the App and/or on our website.',
              ),

              const SizedBox(height: 18),

              _contactCard(
                title: isEs ? 'Contacto' : 'Contact',
                websiteText: isEs ? 'Visitar sitio web' : 'Visit website',
                emailText: isEs ? 'Enviar email a soporte' : 'Email support',
                footerText: isEs
                    ? 'Si tienes preguntas sobre privacidad, contáctanos usando las opciones arriba.'
                    : 'If you have questions about privacy, contact us using the options above.',
                onWebsite: () => _openUrl(website),
                onEmail: () => _openUrl(
                  'mailto:$supportEmail?subject=${Uri.encodeComponent(isEs ? "Solicitud de privacidad - $appName" : "Privacy Policy Request - $appName")}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section({required String title, required String body}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 13.5, height: 1.35)),
        ],
      ),
    );
  }

  Widget _contactCard({
    required String title,
    required String websiteText,
    required String emailText,
    required String footerText,
    required VoidCallback onWebsite,
    required VoidCallback onEmail,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onWebsite,
            icon: const Icon(Icons.public),
            label: Text(websiteText),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onEmail,
            icon: const Icon(Icons.email),
            label: Text(emailText),
          ),
          const SizedBox(height: 6),
          Text(
            footerText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
