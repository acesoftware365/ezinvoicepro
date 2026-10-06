import 'package:flutter/widgets.dart';

class LegalSection {
  const LegalSection(this.title, this.body);

  final String title;
  final String body;
}

class LegalDocumentContent {
  const LegalDocumentContent({required this.title, required this.sections});

  final String title;
  final List<LegalSection> sections;
}

class LegalContent {
  const LegalContent({
    required this.lastUpdated,
    required this.contact,
    required this.visitWebsite,
    required this.emailSupport,
    required this.contactSupport,
    required this.contactFooter,
    required this.emailSupportTitle,
    required this.emailFallback,
    required this.copyEmail,
    required this.emailCopied,
    required this.close,
    required this.couldNotOpenLink,
    required this.privacyEmailSubject,
    required this.termsEmailSubject,
    required this.privacy,
    required this.terms,
  });

  final String lastUpdated;
  final String contact;
  final String visitWebsite;
  final String emailSupport;
  final String contactSupport;
  final String contactFooter;
  final String emailSupportTitle;
  final String emailFallback;
  final String copyEmail;
  final String emailCopied;
  final String close;
  final String couldNotOpenLink;
  final String privacyEmailSubject;
  final String termsEmailSubject;
  final LegalDocumentContent privacy;
  final LegalDocumentContent terms;

  static LegalContent forLocale(Locale locale) {
    return _legalContentByLanguage[locale.languageCode.toLowerCase()] ??
        _legalContentByLanguage['en']!;
  }
}

LegalSection _s(String title, String body) => LegalSection(title, body);

const _company = 'Liisgo LLC';
const _app = 'EzInvoice';

final Map<String, LegalContent> _legalContentByLanguage = {
  'en': LegalContent(
    lastUpdated: 'Last updated',
    contact: 'Contact',
    visitWebsite: 'Visit website',
    emailSupport: 'Email support',
    contactSupport: 'Contact support',
    contactFooter:
        'If you have privacy questions, contact us using the options above.',
    emailSupportTitle: 'Email support',
    emailFallback:
        'Could not open the mail app. You can copy our support email instead.',
    copyEmail: 'Copy email',
    emailCopied: 'Support email copied to clipboard.',
    close: 'Close',
    couldNotOpenLink: 'Could not open this link.',
    privacyEmailSubject: 'Privacy Policy Request - $_app',
    termsEmailSubject: 'Terms & Conditions - $_app',
    privacy: LegalDocumentContent(
      title: 'Privacy Policy',
      sections: [
        _s(
          'Overview',
          '$_company ("we", "our", or "us") operates the $_app mobile application (the "App"). This Privacy Policy explains how we collect, use, disclose, and protect information when you use the App.',
        ),
        _s(
          'Information We Collect',
          'Depending on how you use the App, we may collect:\n• Account and business information you provide, such as a business name, address, or logo.\n• Invoice data you create, such as customer details, items, amounts, tax, and tip.\n• Device and usage data, such as app interactions, diagnostics, and crash logs.\n• Optional contacts access only when you choose to import customers from your phone contacts.',
        ),
        _s(
          'Third-Party Services',
          'The App may use third-party services to operate properly, including Firebase and Google Cloud for authentication, database, and storage; Google Mobile Ads for ads in the free version; and diagnostics, analytics, or crash-reporting tools to improve stability. These providers may process data under their own policies.',
        ),
        _s(
          'How We Use Information',
          'We use information to provide and improve app features, save your preferences and settings, provide support, prevent fraud or abuse, enforce our terms, and comply with legal obligations.',
        ),
        _s(
          'Data Sharing',
          'We do not sell your personal information. We may share information only with service providers that help operate the App, when required by law or a valid legal request, or as part of a merger, acquisition, or asset sale.',
        ),
        _s(
          'Payments & Subscriptions',
          'If you purchase a subscription, payments are processed by Apple App Store or Google Play. We do not receive or store your full payment-card details. Subscription status may be used to unlock Pro features.',
        ),
        _s(
          'Advertising (Free Version)',
          'The free version may display ads. Ad partners may collect limited device identifiers to show ads and measure performance. You can remove ads by upgrading to Pro when that option is available.',
        ),
        _s(
          'Contacts (Optional)',
          'If you grant contacts permission, the App can read contact data to help you select customers faster. You can deny or revoke this permission at any time in your device settings.',
        ),
        _s(
          'Data Retention',
          'We retain information only as long as necessary to provide the App and for legitimate purposes such as compliance, dispute resolution, and enforcement.',
        ),
        _s(
          'Security',
          'We use reasonable safeguards to protect information. However, no method of transmission or storage is completely secure.',
        ),
        _s(
          'Your Rights',
          'Depending on your location, you may have rights to access, correct, delete, or export your data. You can delete your account from Settings or contact us for help with your data.',
        ),
        _s(
          "Children's Privacy",
          'The App is not intended for children under 13, and we do not knowingly collect personal information from children.',
        ),
        _s(
          'Changes to This Policy',
          'We may update this Privacy Policy from time to time. Updates will be posted in the App or on our website.',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'Terms & Conditions',
      sections: [
        _s(
          'Acceptance of Terms',
          'By using $_app or purchasing a Pro subscription, you agree to these Terms and our Privacy Policy. If you do not agree, do not use the App or purchase a subscription.',
        ),
        _s(
          'Use of the App',
          '$_app helps create invoices, reports, exports, and business-related documents. You are responsible for reviewing the accuracy of invoices, taxes, totals, and data before sending or using them.',
        ),
        _s(
          'Pro Subscriptions',
          'Pro may unlock features such as removing ads, unlimited invoices, advanced reports, premium templates, exports, and cloud backup. Purchases are processed by Apple App Store or Google Play. Subscriptions automatically renew until cancelled through your store account settings.',
        ),
        _s(
          'Free vs Pro',
          'The free version may include ads, usage limits, and basic features. Pro removes ads and unlocks additional features as shown on the subscription screen.',
        ),
        _s(
          'Cancellation & Refunds',
          'You can cancel a subscription from your Apple App Store or Google Play account. Refunds are handled by the applicable store according to its policies.',
        ),
        _s(
          'Data & Privacy',
          'Our handling of your data is described in our Privacy Policy. You must have permission to enter customer or business data into the App.',
        ),
        _s(
          'Limitation of Liability',
          'The App is provided “as is.” To the extent permitted by law, $_company is not liable for indirect losses, data errors, business decisions, tax calculations, or misuse of the App.',
        ),
        _s(
          'Changes',
          'We may update these Terms from time to time. Changes will be posted in the App and become effective when posted.',
        ),
      ],
    ),
  ),
  'es': LegalContent(
    lastUpdated: 'Última actualización',
    contact: 'Contacto',
    visitWebsite: 'Visitar sitio web',
    emailSupport: 'Enviar email a soporte',
    contactSupport: 'Contactar soporte',
    contactFooter:
        'Si tienes preguntas sobre privacidad, contáctanos usando las opciones arriba.',
    emailSupportTitle: 'Soporte por email',
    emailFallback:
        'No se pudo abrir la app de correo. Puedes copiar nuestro email de soporte.',
    copyEmail: 'Copiar email',
    emailCopied: 'Email de soporte copiado al portapapeles.',
    close: 'Cerrar',
    couldNotOpenLink: 'No se pudo abrir el enlace.',
    privacyEmailSubject: 'Solicitud de privacidad - $_app',
    termsEmailSubject: 'Términos y condiciones - $_app',
    privacy: LegalDocumentContent(
      title: 'Política de privacidad',
      sections: [
        _s(
          'Resumen',
          '$_company ("nosotros") opera la aplicación móvil $_app (la "App"). Esta Política de privacidad explica cómo recopilamos, usamos, divulgamos y protegemos la información cuando usas la App.',
        ),
        _s(
          'Información que recopilamos',
          'Dependiendo de cómo uses la App, podemos recopilar:\n• Información de cuenta y negocio que proporcionas, como nombre del negocio, dirección o logo.\n• Datos de facturas que creas, como datos del cliente, artículos, montos, impuesto y propina.\n• Datos del dispositivo y uso, como interacciones, diagnósticos y reportes de fallos.\n• Acceso opcional a contactos solo cuando eliges importar clientes desde tus contactos.',
        ),
        _s(
          'Servicios de terceros',
          'La App puede usar servicios de terceros para funcionar correctamente, incluyendo Firebase y Google Cloud para autenticación, base de datos y almacenamiento; Google Mobile Ads para anuncios en la versión gratis; y herramientas de diagnóstico, analítica o reportes de fallos para mejorar estabilidad. Estos proveedores pueden procesar datos según sus propias políticas.',
        ),
        _s(
          'Cómo usamos la información',
          'Usamos la información para ofrecer y mejorar las funciones de la App, guardar tus preferencias y ajustes, brindar soporte, prevenir fraude o abuso, hacer cumplir nuestros términos y cumplir obligaciones legales.',
        ),
        _s(
          'Compartir datos',
          'No vendemos tu información personal. Solo podemos compartir información con proveedores que ayudan a operar la App, cuando la ley o una solicitud legal válida lo exige, o como parte de una fusión, adquisición o venta de activos.',
        ),
        _s(
          'Pagos y suscripciones',
          'Si compras una suscripción, los pagos son procesados por Apple App Store o Google Play. No recibimos ni almacenamos los detalles completos de tu tarjeta. El estado de la suscripción puede usarse para desbloquear funciones Pro.',
        ),
        _s(
          'Publicidad (versión gratis)',
          'La versión gratis puede mostrar anuncios. Los socios de anuncios pueden recopilar identificadores limitados del dispositivo para mostrar anuncios y medir rendimiento. Puedes eliminar anuncios mejorando a Pro cuando esa opción esté disponible.',
        ),
        _s(
          'Contactos (opcional)',
          'Si otorgas permiso de contactos, la App puede leer datos de contactos para ayudarte a elegir clientes más rápido. Puedes negar o revocar este permiso en cualquier momento desde la configuración del dispositivo.',
        ),
        _s(
          'Retención de datos',
          'Retenemos información solo el tiempo necesario para proveer la App y por propósitos legítimos como cumplimiento, resolución de disputas y aplicación de políticas.',
        ),
        _s(
          'Seguridad',
          'Usamos medidas razonables para proteger la información. Sin embargo, ningún método de transmisión o almacenamiento es completamente seguro.',
        ),
        _s(
          'Tus derechos',
          'Dependiendo de tu ubicación, puedes tener derecho a acceder, corregir, eliminar o exportar tus datos. Puedes borrar tu cuenta desde Configuración o contactarnos para recibir ayuda con tus datos.',
        ),
        _s(
          'Privacidad de menores',
          'La App no está dirigida a menores de 13 años y no recopilamos intencionalmente información personal de menores.',
        ),
        _s(
          'Cambios a esta política',
          'Podemos actualizar esta Política de privacidad ocasionalmente. Las actualizaciones se publicarán en la App o en nuestro sitio web.',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'Términos y condiciones',
      sections: [
        _s(
          'Aceptación de los términos',
          'Al usar $_app o comprar una suscripción Pro, aceptas estos Términos y nuestra Política de privacidad. Si no aceptas estos términos, no uses la App ni compres una suscripción.',
        ),
        _s(
          'Uso de la App',
          '$_app ayuda a crear facturas, reportes, exportaciones y documentos relacionados con negocios. Eres responsable de revisar la exactitud de tus facturas, impuestos, totales y datos antes de enviarlos o usarlos.',
        ),
        _s(
          'Suscripciones Pro',
          'Pro puede desbloquear funciones como eliminar anuncios, facturas ilimitadas, reportes avanzados, plantillas premium, exportaciones y respaldo en la nube. Las compras se procesan por Apple App Store o Google Play. Las suscripciones se renuevan automáticamente hasta que las canceles desde la configuración de tu tienda.',
        ),
        _s(
          'Gratis vs Pro',
          'La versión gratis puede incluir anuncios, límites de uso y funciones básicas. Pro elimina anuncios y desbloquea funciones adicionales según se muestra en la pantalla de suscripción.',
        ),
        _s(
          'Cancelaciones y reembolsos',
          'Puedes cancelar una suscripción desde tu cuenta de Apple App Store o Google Play. Los reembolsos son manejados por la tienda correspondiente según sus políticas.',
        ),
        _s(
          'Datos y privacidad',
          'El uso de tus datos se describe en nuestra Política de privacidad. Debes tener permiso para ingresar datos de clientes o negocios en la App.',
        ),
        _s(
          'Limitación de responsabilidad',
          'La App se ofrece “tal cual”. En la medida permitida por la ley, $_company no será responsable por pérdidas indirectas, errores de datos, decisiones comerciales, cálculos de impuestos o uso incorrecto de la App.',
        ),
        _s(
          'Cambios',
          'Podemos actualizar estos Términos ocasionalmente. Los cambios se publicarán en la App y entrarán en vigor cuando se publiquen.',
        ),
      ],
    ),
  ),
  'pt': LegalContent(
    lastUpdated: 'Última atualização',
    contact: 'Contato',
    visitWebsite: 'Visitar o site',
    emailSupport: 'Enviar e-mail ao suporte',
    contactSupport: 'Falar com o suporte',
    contactFooter:
        'Se você tiver dúvidas sobre privacidade, fale conosco usando as opções acima.',
    emailSupportTitle: 'Suporte por e-mail',
    emailFallback:
        'Não foi possível abrir o aplicativo de e-mail. Você pode copiar nosso e-mail de suporte.',
    copyEmail: 'Copiar e-mail',
    emailCopied: 'E-mail de suporte copiado.',
    close: 'Fechar',
    couldNotOpenLink: 'Não foi possível abrir este link.',
    privacyEmailSubject: 'Solicitação de privacidade - $_app',
    termsEmailSubject: 'Termos e condições - $_app',
    privacy: LegalDocumentContent(
      title: 'Política de privacidade',
      sections: [
        _s(
          'Visão geral',
          '$_company ("nós") opera o aplicativo móvel $_app (o "App"). Esta Política de privacidade explica como coletamos, usamos, divulgamos e protegemos informações quando você usa o App.',
        ),
        _s(
          'Informações que coletamos',
          'Dependendo de como você usa o App, podemos coletar:\n• Informações de conta e negócio fornecidas por você, como nome, endereço ou logotipo.\n• Dados das faturas criadas por você, como dados do cliente, itens, valores, imposto e gorjeta.\n• Dados do dispositivo e de uso, como interações, diagnósticos e relatórios de falhas.\n• Acesso opcional aos contatos somente quando você optar por importar clientes dos contatos do telefone.',
        ),
        _s(
          'Serviços de terceiros',
          'O App pode usar serviços de terceiros para funcionar corretamente, incluindo Firebase e Google Cloud para autenticação, banco de dados e armazenamento; Google Mobile Ads para anúncios na versão gratuita; e ferramentas de diagnóstico, análise ou relatórios de falhas para melhorar a estabilidade. Esses fornecedores podem processar dados de acordo com suas próprias políticas.',
        ),
        _s(
          'Como usamos as informações',
          'Usamos as informações para fornecer e melhorar recursos do App, salvar suas preferências e configurações, oferecer suporte, prevenir fraude ou abuso, aplicar nossos termos e cumprir obrigações legais.',
        ),
        _s(
          'Compartilhamento de dados',
          'Não vendemos suas informações pessoais. Podemos compartilhar informações apenas com provedores que ajudam a operar o App, quando exigido por lei ou por uma solicitação legal válida, ou como parte de uma fusão, aquisição ou venda de ativos.',
        ),
        _s(
          'Pagamentos e assinaturas',
          'Se você comprar uma assinatura, os pagamentos serão processados pela Apple App Store ou Google Play. Não recebemos nem armazenamos os dados completos do seu cartão. O status da assinatura pode ser usado para liberar recursos Pro.',
        ),
        _s(
          'Publicidade (versão gratuita)',
          'A versão gratuita pode exibir anúncios. Parceiros de anúncios podem coletar identificadores limitados do dispositivo para exibir anúncios e medir desempenho. Você pode remover anúncios atualizando para Pro quando essa opção estiver disponível.',
        ),
        _s(
          'Contatos (opcional)',
          'Se você conceder permissão para contatos, o App poderá ler dados de contato para ajudar a escolher clientes mais rapidamente. Você pode negar ou revogar essa permissão a qualquer momento nas configurações do dispositivo.',
        ),
        _s(
          'Retenção de dados',
          'Mantemos as informações somente pelo tempo necessário para fornecer o App e para finalidades legítimas, como conformidade, resolução de disputas e aplicação de políticas.',
        ),
        _s(
          'Segurança',
          'Usamos medidas razoáveis para proteger as informações. No entanto, nenhum método de transmissão ou armazenamento é totalmente seguro.',
        ),
        _s(
          'Seus direitos',
          'Dependendo da sua localização, você pode ter o direito de acessar, corrigir, excluir ou exportar seus dados. Você pode excluir sua conta em Configurações ou entrar em contato conosco para obter ajuda.',
        ),
        _s(
          'Privacidade de crianças',
          'O App não é destinado a crianças menores de 13 anos e não coletamos intencionalmente informações pessoais de crianças.',
        ),
        _s(
          'Alterações nesta política',
          'Podemos atualizar esta Política de privacidade ocasionalmente. As atualizações serão publicadas no App ou em nosso site.',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'Termos e condições',
      sections: [
        _s(
          'Aceitação dos termos',
          'Ao usar o $_app ou comprar uma assinatura Pro, você concorda com estes Termos e nossa Política de privacidade. Se não concordar, não use o App nem compre uma assinatura.',
        ),
        _s(
          'Uso do App',
          'O $_app ajuda a criar faturas, relatórios, exportações e documentos relacionados a negócios. Você é responsável por revisar a precisão das faturas, impostos, totais e dados antes de enviá-los ou usá-los.',
        ),
        _s(
          'Assinaturas Pro',
          'O Pro pode liberar recursos como remoção de anúncios, faturas ilimitadas, relatórios avançados, modelos premium, exportações e backup na nuvem. As compras são processadas pela Apple App Store ou Google Play. As assinaturas são renovadas automaticamente até serem canceladas nas configurações da sua loja.',
        ),
        _s(
          'Grátis vs Pro',
          'A versão gratuita pode incluir anúncios, limites de uso e recursos básicos. O Pro remove anúncios e libera recursos adicionais exibidos na tela de assinatura.',
        ),
        _s(
          'Cancelamentos e reembolsos',
          'Você pode cancelar uma assinatura pela sua conta da Apple App Store ou Google Play. Os reembolsos são tratados pela loja aplicável de acordo com suas políticas.',
        ),
        _s(
          'Dados e privacidade',
          'O tratamento dos seus dados é descrito em nossa Política de privacidade. Você deve ter permissão para inserir dados de clientes ou negócios no App.',
        ),
        _s(
          'Limitação de responsabilidade',
          'O App é fornecido “como está”. Na medida permitida por lei, $_company não se responsabiliza por perdas indiretas, erros de dados, decisões comerciais, cálculos de impostos ou uso indevido do App.',
        ),
        _s(
          'Alterações',
          'Podemos atualizar estes Termos periodicamente. As alterações serão publicadas no App e entrarão em vigor quando forem publicadas.',
        ),
      ],
    ),
  ),
  'fr': LegalContent(
    lastUpdated: 'Dernière mise à jour',
    contact: 'Contact',
    visitWebsite: 'Visiter le site web',
    emailSupport: 'Envoyer un e-mail au support',
    contactSupport: 'Contacter le support',
    contactFooter:
        'Pour toute question sur la confidentialité, contactez-nous avec les options ci-dessus.',
    emailSupportTitle: 'Support par e-mail',
    emailFallback:
        'Impossible d’ouvrir l’application e-mail. Vous pouvez copier notre adresse de support.',
    copyEmail: 'Copier l’e-mail',
    emailCopied: 'E-mail de support copié.',
    close: 'Fermer',
    couldNotOpenLink: 'Impossible d’ouvrir ce lien.',
    privacyEmailSubject: 'Demande de confidentialité - $_app',
    termsEmailSubject: 'Conditions générales - $_app',
    privacy: LegalDocumentContent(
      title: 'Politique de confidentialité',
      sections: [
        _s(
          'Vue d’ensemble',
          '$_company (« nous ») exploite l’application mobile $_app (l’« App »). Cette Politique de confidentialité explique comment nous recueillons, utilisons, divulguons et protégeons les informations lorsque vous utilisez l’App.',
        ),
        _s(
          'Informations que nous recueillons',
          'Selon votre utilisation de l’App, nous pouvons recueillir :\n• Les informations de compte et d’entreprise que vous fournissez, comme le nom, l’adresse ou le logo.\n• Les données de factures que vous créez, comme les données client, articles, montants, taxes et pourboires.\n• Les données d’appareil et d’utilisation, comme les interactions, diagnostics et rapports de plantage.\n• L’accès facultatif aux contacts seulement si vous choisissez d’importer des clients depuis votre téléphone.',
        ),
        _s(
          'Services tiers',
          'L’App peut utiliser des services tiers pour fonctionner correctement, notamment Firebase et Google Cloud pour l’authentification, la base de données et le stockage ; Google Mobile Ads pour les annonces de la version gratuite ; et des outils de diagnostic, d’analyse ou de rapport de plantage. Ces fournisseurs peuvent traiter les données selon leurs propres politiques.',
        ),
        _s(
          'Utilisation des informations',
          'Nous utilisons les informations pour fournir et améliorer les fonctions de l’App, enregistrer vos préférences, offrir une assistance, prévenir la fraude ou les abus, appliquer nos conditions et respecter les obligations légales.',
        ),
        _s(
          'Partage des données',
          'Nous ne vendons pas vos informations personnelles. Nous pouvons partager des informations uniquement avec des prestataires qui aident à exploiter l’App, lorsque la loi ou une demande légale valide l’exige, ou dans le cadre d’une fusion, acquisition ou vente d’actifs.',
        ),
        _s(
          'Paiements et abonnements',
          'Si vous achetez un abonnement, les paiements sont traités par l’Apple App Store ou Google Play. Nous ne recevons ni ne stockons les détails complets de votre carte. L’état de l’abonnement peut servir à débloquer les fonctions Pro.',
        ),
        _s(
          'Publicité (version gratuite)',
          'La version gratuite peut afficher des annonces. Des partenaires publicitaires peuvent recueillir des identifiants limités de l’appareil pour afficher des annonces et mesurer les performances. Vous pouvez supprimer les annonces en passant à Pro lorsque cette option est disponible.',
        ),
        _s(
          'Contacts (facultatif)',
          'Si vous accordez l’autorisation d’accéder aux contacts, l’App peut lire leurs données pour vous aider à choisir plus rapidement des clients. Vous pouvez refuser ou retirer cette autorisation à tout moment dans les réglages de l’appareil.',
        ),
        _s(
          'Conservation des données',
          'Nous conservons les informations uniquement pendant la durée nécessaire à la fourniture de l’App et à des fins légitimes telles que la conformité, la résolution des litiges et l’application des politiques.',
        ),
        _s(
          'Sécurité',
          'Nous utilisons des mesures raisonnables pour protéger les informations. Cependant, aucune méthode de transmission ou de stockage n’est totalement sûre.',
        ),
        _s(
          'Vos droits',
          'Selon votre lieu de résidence, vous pouvez avoir le droit d’accéder à vos données, de les corriger, de les supprimer ou de les exporter. Vous pouvez supprimer votre compte dans Réglages ou nous contacter pour obtenir de l’aide.',
        ),
        _s(
          'Confidentialité des enfants',
          'L’App ne s’adresse pas aux enfants de moins de 13 ans et nous ne recueillons pas sciemment leurs informations personnelles.',
        ),
        _s(
          'Modifications de cette politique',
          'Nous pouvons mettre à jour cette Politique de confidentialité périodiquement. Les mises à jour seront publiées dans l’App ou sur notre site web.',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'Conditions générales',
      sections: [
        _s(
          'Acceptation des conditions',
          'En utilisant $_app ou en achetant un abonnement Pro, vous acceptez ces Conditions et notre Politique de confidentialité. Si vous n’acceptez pas ces conditions, n’utilisez pas l’App et n’achetez pas d’abonnement.',
        ),
        _s(
          'Utilisation de l’App',
          '$_app aide à créer des factures, rapports, exports et documents liés à l’entreprise. Vous êtes responsable de vérifier l’exactitude des factures, taxes, totaux et données avant de les envoyer ou de les utiliser.',
        ),
        _s(
          'Abonnements Pro',
          'Pro peut débloquer des fonctions telles que la suppression des annonces, des factures illimitées, des rapports avancés, des modèles premium, des exports et une sauvegarde cloud. Les achats sont traités par l’Apple App Store ou Google Play. Les abonnements se renouvellent automatiquement jusqu’à leur annulation dans les réglages de votre boutique.',
        ),
        _s(
          'Gratuit vs Pro',
          'La version gratuite peut inclure des annonces, des limites d’utilisation et des fonctions de base. Pro supprime les annonces et débloque les fonctions supplémentaires affichées sur l’écran d’abonnement.',
        ),
        _s(
          'Annulation et remboursements',
          'Vous pouvez annuler un abonnement depuis votre compte Apple App Store ou Google Play. Les remboursements sont gérés par la boutique concernée selon ses politiques.',
        ),
        _s(
          'Données et confidentialité',
          'Le traitement de vos données est décrit dans notre Politique de confidentialité. Vous devez avoir l’autorisation de saisir des données client ou entreprise dans l’App.',
        ),
        _s(
          'Limitation de responsabilité',
          'L’App est fournie « telle quelle ». Dans la mesure permise par la loi, $_company n’est pas responsable des pertes indirectes, erreurs de données, décisions commerciales, calculs fiscaux ou utilisation incorrecte de l’App.',
        ),
        _s(
          'Modifications',
          'Nous pouvons mettre à jour ces Conditions périodiquement. Les changements seront publiés dans l’App et prendront effet dès leur publication.',
        ),
      ],
    ),
  ),
  'de': LegalContent(
    lastUpdated: 'Zuletzt aktualisiert',
    contact: 'Kontakt',
    visitWebsite: 'Website besuchen',
    emailSupport: 'Support per E-Mail',
    contactSupport: 'Support kontaktieren',
    contactFooter:
        'Bei Fragen zum Datenschutz kontaktieren Sie uns über die oben genannten Optionen.',
    emailSupportTitle: 'E-Mail-Support',
    emailFallback:
        'Die E-Mail-App konnte nicht geöffnet werden. Sie können unsere Support-E-Mail-Adresse kopieren.',
    copyEmail: 'E-Mail kopieren',
    emailCopied: 'Support-E-Mail wurde kopiert.',
    close: 'Schließen',
    couldNotOpenLink: 'Dieser Link konnte nicht geöffnet werden.',
    privacyEmailSubject: 'Datenschutzanfrage - $_app',
    termsEmailSubject: 'Allgemeine Geschäftsbedingungen - $_app',
    privacy: LegalDocumentContent(
      title: 'Datenschutzerklärung',
      sections: [
        _s(
          'Überblick',
          '$_company („wir“, „uns“) betreibt die mobile Anwendung $_app (die „App“). Diese Datenschutzerklärung erläutert, wie wir Informationen erfassen, verwenden, weitergeben und schützen, wenn Sie die App nutzen.',
        ),
        _s(
          'Informationen, die wir erfassen',
          'Je nach Nutzung der App können wir Folgendes erfassen:\n• Konto- und Unternehmensinformationen, die Sie angeben, etwa Firmenname, Adresse oder Logo.\n• Von Ihnen erstellte Rechnungsdaten, etwa Kundendaten, Positionen, Beträge, Steuer und Trinkgeld.\n• Geräte- und Nutzungsdaten, etwa App-Interaktionen, Diagnosen und Absturzberichte.\n• Optionalen Zugriff auf Kontakte nur, wenn Sie Kunden aus Ihren Telefonkontakten importieren möchten.',
        ),
        _s(
          'Drittanbieterdienste',
          'Die App kann Drittanbieterdienste nutzen, damit sie ordnungsgemäß funktioniert, einschließlich Firebase und Google Cloud für Authentifizierung, Datenbank und Speicher; Google Mobile Ads für Werbung in der kostenlosen Version; sowie Diagnose-, Analyse- oder Absturzberichtswerkzeuge zur Verbesserung der Stabilität. Diese Anbieter können Daten nach ihren eigenen Richtlinien verarbeiten.',
        ),
        _s(
          'Wie wir Informationen verwenden',
          'Wir verwenden Informationen, um App-Funktionen bereitzustellen und zu verbessern, Ihre Einstellungen zu speichern, Support zu leisten, Betrug oder Missbrauch zu verhindern, unsere Bedingungen durchzusetzen und rechtliche Pflichten zu erfüllen.',
        ),
        _s(
          'Weitergabe von Daten',
          'Wir verkaufen Ihre personenbezogenen Daten nicht. Wir geben Informationen nur an Dienstleister weiter, die den Betrieb der App unterstützen, wenn dies gesetzlich oder aufgrund eines gültigen rechtlichen Ersuchens erforderlich ist oder im Rahmen einer Fusion, Übernahme oder eines Vermögensverkaufs.',
        ),
        _s(
          'Zahlungen und Abonnements',
          'Wenn Sie ein Abonnement kaufen, werden Zahlungen über den Apple App Store oder Google Play abgewickelt. Wir erhalten oder speichern nicht die vollständigen Kartendaten. Der Abonnementstatus kann zum Freischalten von Pro-Funktionen verwendet werden.',
        ),
        _s(
          'Werbung (kostenlose Version)',
          'Die kostenlose Version kann Werbung anzeigen. Werbepartner können eingeschränkte Gerätekennungen erfassen, um Werbung anzuzeigen und die Leistung zu messen. Sie können Werbung durch ein Upgrade auf Pro entfernen, sofern diese Option verfügbar ist.',
        ),
        _s(
          'Kontakte (optional)',
          'Wenn Sie die Kontaktberechtigung erteilen, kann die App Kontaktdaten lesen, damit Sie Kunden schneller auswählen können. Sie können diese Berechtigung jederzeit in den Geräteeinstellungen verweigern oder widerrufen.',
        ),
        _s(
          'Aufbewahrung von Daten',
          'Wir bewahren Informationen nur so lange auf, wie es zur Bereitstellung der App und für berechtigte Zwecke wie Compliance, Streitbeilegung und Durchsetzung von Richtlinien erforderlich ist.',
        ),
        _s(
          'Sicherheit',
          'Wir verwenden angemessene Schutzmaßnahmen. Dennoch ist keine Übertragungs- oder Speichermethode vollständig sicher.',
        ),
        _s(
          'Ihre Rechte',
          'Je nach Ihrem Standort haben Sie möglicherweise das Recht, auf Ihre Daten zuzugreifen, sie zu berichtigen, zu löschen oder zu exportieren. Sie können Ihr Konto in den Einstellungen löschen oder uns um Hilfe bitten.',
        ),
        _s(
          'Datenschutz von Kindern',
          'Die App richtet sich nicht an Kinder unter 13 Jahren und wir erfassen wissentlich keine personenbezogenen Daten von Kindern.',
        ),
        _s(
          'Änderungen dieser Richtlinie',
          'Wir können diese Datenschutzerklärung gelegentlich aktualisieren. Aktualisierungen werden in der App oder auf unserer Website veröffentlicht.',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'Allgemeine Geschäftsbedingungen',
      sections: [
        _s(
          'Annahme der Bedingungen',
          'Durch die Nutzung von $_app oder den Kauf eines Pro-Abonnements stimmen Sie diesen Bedingungen und unserer Datenschutzerklärung zu. Wenn Sie nicht zustimmen, nutzen Sie die App nicht und kaufen Sie kein Abonnement.',
        ),
        _s(
          'Nutzung der App',
          '$_app hilft beim Erstellen von Rechnungen, Berichten, Exporten und geschäftsbezogenen Dokumenten. Sie sind dafür verantwortlich, die Richtigkeit von Rechnungen, Steuern, Summen und Daten vor dem Senden oder Verwenden zu prüfen.',
        ),
        _s(
          'Pro-Abonnements',
          'Pro kann Funktionen wie das Entfernen von Werbung, unbegrenzte Rechnungen, erweiterte Berichte, Premiumvorlagen, Exporte und Cloud-Sicherung freischalten. Käufe werden über den Apple App Store oder Google Play abgewickelt. Abonnements verlängern sich automatisch, bis sie in Ihren Store-Kontoeinstellungen gekündigt werden.',
        ),
        _s(
          'Kostenlos vs. Pro',
          'Die kostenlose Version kann Werbung, Nutzungsbeschränkungen und Basisfunktionen enthalten. Pro entfernt Werbung und schaltet die auf dem Abonnementbildschirm angezeigten Zusatzfunktionen frei.',
        ),
        _s(
          'Kündigung und Erstattungen',
          'Sie können ein Abonnement über Ihr Apple-App-Store- oder Google-Play-Konto kündigen. Erstattungen werden gemäß den Richtlinien vom jeweiligen Store bearbeitet.',
        ),
        _s(
          'Daten und Datenschutz',
          'Der Umgang mit Ihren Daten wird in unserer Datenschutzerklärung beschrieben. Sie müssen berechtigt sein, Kunden- oder Unternehmensdaten in die App einzugeben.',
        ),
        _s(
          'Haftungsbeschränkung',
          'Die App wird „wie besehen“ bereitgestellt. Soweit gesetzlich zulässig, haftet $_company nicht für indirekte Verluste, Datenfehler, Geschäftsentscheidungen, Steuerberechnungen oder die missbräuchliche Nutzung der App.',
        ),
        _s(
          'Änderungen',
          'Wir können diese Bedingungen von Zeit zu Zeit aktualisieren. Änderungen werden in der App veröffentlicht und treten mit ihrer Veröffentlichung in Kraft.',
        ),
      ],
    ),
  ),
  'ar': LegalContent(
    lastUpdated: 'آخر تحديث',
    contact: 'التواصل',
    visitWebsite: 'زيارة الموقع',
    emailSupport: 'مراسلة الدعم',
    contactSupport: 'التواصل مع الدعم',
    contactFooter:
        'إذا كانت لديك أسئلة حول الخصوصية، تواصل معنا باستخدام الخيارات أعلاه.',
    emailSupportTitle: 'الدعم عبر البريد الإلكتروني',
    emailFallback: 'تعذر فتح تطبيق البريد. يمكنك نسخ بريد الدعم الإلكتروني.',
    copyEmail: 'نسخ البريد الإلكتروني',
    emailCopied: 'تم نسخ بريد الدعم الإلكتروني.',
    close: 'إغلاق',
    couldNotOpenLink: 'تعذر فتح هذا الرابط.',
    privacyEmailSubject: 'طلب خصوصية - $_app',
    termsEmailSubject: 'الشروط والأحكام - $_app',
    privacy: LegalDocumentContent(
      title: 'سياسة الخصوصية',
      sections: [
        _s(
          'نظرة عامة',
          'تدير $_company («نحن») تطبيق $_app للجوال («التطبيق»). تشرح سياسة الخصوصية هذه كيفية جمع المعلومات واستخدامها والإفصاح عنها وحمايتها عند استخدامك للتطبيق.',
        ),
        _s(
          'المعلومات التي نجمعها',
          'بحسب طريقة استخدامك للتطبيق، قد نجمع:\n• معلومات الحساب والنشاط التجاري التي تقدمها، مثل اسم النشاط أو العنوان أو الشعار.\n• بيانات الفواتير التي تنشئها، مثل بيانات العميل والعناصر والمبالغ والضريبة والإكرامية.\n• بيانات الجهاز والاستخدام، مثل تفاعلات التطبيق والتشخيصات وتقارير الأعطال.\n• الوصول الاختياري إلى جهات الاتصال فقط عند اختيار استيراد العملاء من جهات اتصال الهاتف.',
        ),
        _s(
          'خدمات الجهات الخارجية',
          'قد يستخدم التطبيق خدمات خارجية ليعمل بشكل سليم، ومنها Firebase وGoogle Cloud للمصادقة وقاعدة البيانات والتخزين، وGoogle Mobile Ads للإعلانات في النسخة المجانية، وأدوات التشخيص والتحليلات أو تقارير الأعطال لتحسين الاستقرار. وقد يعالج هؤلاء المزوّدون البيانات بموجب سياساتهم الخاصة.',
        ),
        _s(
          'كيفية استخدام المعلومات',
          'نستخدم المعلومات لتقديم ميزات التطبيق وتحسينها، وحفظ تفضيلاتك وإعداداتك، وتقديم الدعم، ومنع الاحتيال أو إساءة الاستخدام، وتطبيق شروطنا، والوفاء بالالتزامات القانونية.',
        ),
        _s(
          'مشاركة البيانات',
          'لا نبيع معلوماتك الشخصية. قد نشارك المعلومات فقط مع مقدمي الخدمات الذين يساعدون في تشغيل التطبيق، أو عندما يقتضي القانون أو طلب قانوني صالح ذلك، أو كجزء من اندماج أو استحواذ أو بيع أصول.',
        ),
        _s(
          'المدفوعات والاشتراكات',
          'إذا اشتريت اشتراكًا، تتم معالجة المدفوعات عبر Apple App Store أو Google Play. لا نتلقى ولا نخزن تفاصيل بطاقتك الكاملة. قد يُستخدم حالة الاشتراك لفتح ميزات Pro.',
        ),
        _s(
          'الإعلانات (النسخة المجانية)',
          'قد تعرض النسخة المجانية إعلانات. قد يجمع شركاء الإعلانات معرّفات محدودة للجهاز لعرض الإعلانات وقياس الأداء. يمكنك إزالة الإعلانات بالترقية إلى Pro عندما يكون هذا الخيار متاحًا.',
        ),
        _s(
          'جهات الاتصال (اختياري)',
          'إذا منحت إذن جهات الاتصال، يمكن للتطبيق قراءة بيانات الاتصال لمساعدتك على اختيار العملاء بسرعة أكبر. يمكنك رفض هذا الإذن أو إلغاؤه في أي وقت من إعدادات الجهاز.',
        ),
        _s(
          'الاحتفاظ بالبيانات',
          'نحتفظ بالمعلومات فقط للمدة اللازمة لتقديم التطبيق ولأغراض مشروعة مثل الامتثال وحل النزاعات وتطبيق السياسات.',
        ),
        _s(
          'الأمان',
          'نستخدم تدابير معقولة لحماية المعلومات. ومع ذلك، لا توجد أي طريقة نقل أو تخزين آمنة تمامًا.',
        ),
        _s(
          'حقوقك',
          'بحسب موقعك، قد يكون لك الحق في الوصول إلى بياناتك أو تصحيحها أو حذفها أو تصديرها. يمكنك حذف حسابك من الإعدادات أو التواصل معنا للحصول على المساعدة.',
        ),
        _s(
          'خصوصية الأطفال',
          'التطبيق غير مخصص للأطفال دون 13 عامًا، ولا نجمع عن علم معلومات شخصية من الأطفال.',
        ),
        _s(
          'التغييرات على هذه السياسة',
          'قد نحدّث سياسة الخصوصية هذه من وقت لآخر. ستُنشر التحديثات في التطبيق أو على موقعنا.',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'الشروط والأحكام',
      sections: [
        _s(
          'قبول الشروط',
          'باستخدام $_app أو شراء اشتراك Pro، فإنك توافق على هذه الشروط وسياسة الخصوصية الخاصة بنا. إذا لم توافق، فلا تستخدم التطبيق ولا تشترِ اشتراكًا.',
        ),
        _s(
          'استخدام التطبيق',
          'يساعد $_app في إنشاء الفواتير والتقارير وعمليات التصدير والمستندات المتعلقة بالأعمال. أنت مسؤول عن مراجعة دقة الفواتير والضرائب والإجماليات والبيانات قبل إرسالها أو استخدامها.',
        ),
        _s(
          'اشتراكات Pro',
          'قد يفتح Pro ميزات مثل إزالة الإعلانات، والفواتير غير المحدودة، والتقارير المتقدمة، والقوالب المميزة، والتصدير، والنسخ الاحتياطي السحابي. تتم معالجة المشتريات عبر Apple App Store أو Google Play. تتجدد الاشتراكات تلقائيًا إلى أن تلغيها من إعدادات حساب المتجر.',
        ),
        _s(
          'مجاني مقابل Pro',
          'قد تتضمن النسخة المجانية إعلانات وحدودًا للاستخدام وميزات أساسية. يزيل Pro الإعلانات ويفتح الميزات الإضافية الموضحة في شاشة الاشتراك.',
        ),
        _s(
          'الإلغاء واسترداد الأموال',
          'يمكنك إلغاء الاشتراك من حساب Apple App Store أو Google Play الخاص بك. تتم معالجة المبالغ المستردة بواسطة المتجر المعني وفقًا لسياساته.',
        ),
        _s(
          'البيانات والخصوصية',
          'يوضح سياسة الخصوصية الخاصة بنا طريقة التعامل مع بياناتك. يجب أن تكون مخولًا لإدخال بيانات العملاء أو الأعمال في التطبيق.',
        ),
        _s(
          'تحديد المسؤولية',
          'يتم تقديم التطبيق «كما هو». إلى الحد الذي يسمح به القانون، لا تتحمل $_company مسؤولية الخسائر غير المباشرة أو أخطاء البيانات أو قرارات الأعمال أو حسابات الضرائب أو إساءة استخدام التطبيق.',
        ),
        _s(
          'التغييرات',
          'قد نحدّث هذه الشروط من وقت لآخر. ستُنشر التغييرات في التطبيق وتصبح سارية عند نشرها.',
        ),
      ],
    ),
  ),
  'hi': LegalContent(
    lastUpdated: 'अंतिम अपडेट',
    contact: 'संपर्क',
    visitWebsite: 'वेबसाइट देखें',
    emailSupport: 'सहायता को ईमेल करें',
    contactSupport: 'सहायता से संपर्क करें',
    contactFooter:
        'गोपनीयता से जुड़े प्रश्नों के लिए ऊपर दिए गए विकल्पों से हमसे संपर्क करें।',
    emailSupportTitle: 'ईमेल सहायता',
    emailFallback:
        'ईमेल ऐप नहीं खुल सका। आप हमारा सहायता ईमेल कॉपी कर सकते हैं।',
    copyEmail: 'ईमेल कॉपी करें',
    emailCopied: 'सहायता ईमेल कॉपी हो गया।',
    close: 'बंद करें',
    couldNotOpenLink: 'यह लिंक नहीं खुल सका।',
    privacyEmailSubject: 'गोपनीयता अनुरोध - $_app',
    termsEmailSubject: 'नियम और शर्तें - $_app',
    privacy: LegalDocumentContent(
      title: 'गोपनीयता नीति',
      sections: [
        _s(
          'संक्षिप्त परिचय',
          '$_company ("हम") $_app मोबाइल एप्लिकेशन ("ऐप") संचालित करता है। यह गोपनीयता नीति बताती है कि ऐप इस्तेमाल करने पर हम जानकारी कैसे एकत्र, उपयोग, साझा और सुरक्षित करते हैं।',
        ),
        _s(
          'हम जो जानकारी एकत्र करते हैं',
          'आपके ऐप उपयोग के आधार पर हम यह जानकारी एकत्र कर सकते हैं:\n• आपके द्वारा दी गई खाता और व्यवसाय जानकारी, जैसे व्यवसाय नाम, पता या लोगो।\n• आपके बनाए इनवॉइस का डेटा, जैसे ग्राहक विवरण, आइटम, राशि, कर और टिप।\n• डिवाइस और उपयोग डेटा, जैसे ऐप इंटरैक्शन, निदान और क्रैश रिपोर्ट।\n• संपर्कों तक वैकल्पिक पहुँच, केवल तब जब आप फोन संपर्कों से ग्राहक आयात करना चुनते हैं।',
        ),
        _s(
          'तृतीय-पक्ष सेवाएँ',
          'ऐप सही ढंग से काम करने के लिए तृतीय-पक्ष सेवाओं का उपयोग कर सकता है, जिनमें प्रमाणीकरण, डेटाबेस और स्टोरेज के लिए Firebase और Google Cloud; मुफ्त संस्करण में विज्ञापनों के लिए Google Mobile Ads; तथा स्थिरता सुधारने के लिए निदान, विश्लेषण या क्रैश रिपोर्टिंग टूल शामिल हैं। ये प्रदाता अपनी नीतियों के अनुसार डेटा संसाधित कर सकते हैं।',
        ),
        _s(
          'जानकारी का उपयोग',
          'हम जानकारी का उपयोग ऐप सुविधाएँ देने और सुधारने, आपकी प्राथमिकताएँ और सेटिंग्स सहेजने, सहायता देने, धोखाधड़ी या दुरुपयोग रोकने, हमारी शर्तें लागू करने और कानूनी दायित्वों का पालन करने के लिए करते हैं।',
        ),
        _s(
          'डेटा साझा करना',
          'हम आपकी व्यक्तिगत जानकारी नहीं बेचते। हम जानकारी केवल ऐप चलाने में मदद करने वाले सेवा प्रदाताओं के साथ, कानून या वैध कानूनी अनुरोध की आवश्यकता होने पर, या विलय, अधिग्रहण अथवा संपत्ति बिक्री के भाग के रूप में साझा कर सकते हैं।',
        ),
        _s(
          'भुगतान और सदस्यताएँ',
          'यदि आप सदस्यता खरीदते हैं, तो भुगतान Apple App Store या Google Play द्वारा संसाधित होते हैं। हम आपके पूरे कार्ड विवरण प्राप्त या संग्रहीत नहीं करते। सदस्यता स्थिति का उपयोग Pro सुविधाएँ खोलने के लिए किया जा सकता है।',
        ),
        _s(
          'विज्ञापन (मुफ्त संस्करण)',
          'मुफ्त संस्करण में विज्ञापन दिख सकते हैं। विज्ञापन भागीदार विज्ञापन दिखाने और प्रदर्शन मापने के लिए सीमित डिवाइस पहचानकर्ता एकत्र कर सकते हैं। विकल्प उपलब्ध होने पर आप Pro में अपग्रेड करके विज्ञापन हटा सकते हैं।',
        ),
        _s(
          'संपर्क (वैकल्पिक)',
          'यदि आप संपर्क अनुमति देते हैं, तो ऐप ग्राहकों को जल्दी चुनने में सहायता के लिए संपर्क डेटा पढ़ सकता है। आप डिवाइस सेटिंग्स में किसी भी समय यह अनुमति अस्वीकार या रद्द कर सकते हैं।',
        ),
        _s(
          'डेटा प्रतिधारण',
          'हम जानकारी केवल ऐप देने के लिए आवश्यक अवधि और अनुपालन, विवाद समाधान तथा नीति लागू करने जैसे वैध उद्देश्यों के लिए रखते हैं।',
        ),
        _s(
          'सुरक्षा',
          'हम जानकारी की सुरक्षा के लिए उचित उपाय अपनाते हैं। फिर भी, संचरण या भंडारण की कोई भी विधि पूरी तरह सुरक्षित नहीं होती।',
        ),
        _s(
          'आपके अधिकार',
          'आपके स्थान के आधार पर आपको अपने डेटा तक पहुँचने, सुधारने, हटाने या निर्यात करने का अधिकार हो सकता है। आप सेटिंग्स से अपना खाता हटा सकते हैं या मदद के लिए हमसे संपर्क कर सकते हैं।',
        ),
        _s(
          'बच्चों की गोपनीयता',
          'ऐप 13 वर्ष से कम उम्र के बच्चों के लिए नहीं है और हम जानबूझकर बच्चों की व्यक्तिगत जानकारी एकत्र नहीं करते।',
        ),
        _s(
          'इस नीति में बदलाव',
          'हम समय-समय पर इस गोपनीयता नीति को अपडेट कर सकते हैं। अपडेट ऐप या हमारी वेबसाइट पर प्रकाशित किए जाएंगे।',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'नियम और शर्तें',
      sections: [
        _s(
          'शर्तों की स्वीकृति',
          '$_app का उपयोग करने या Pro सदस्यता खरीदने पर आप इन शर्तों और हमारी गोपनीयता नीति से सहमत होते हैं। यदि आप सहमत नहीं हैं, तो ऐप का उपयोग न करें और सदस्यता न खरीदें।',
        ),
        _s(
          'ऐप का उपयोग',
          '$_app इनवॉइस, रिपोर्ट, निर्यात और व्यवसाय-संबंधित दस्तावेज़ बनाने में मदद करता है। उन्हें भेजने या उपयोग करने से पहले इनवॉइस, कर, कुल राशि और डेटा की सटीकता जाँचना आपकी जिम्मेदारी है।',
        ),
        _s(
          'Pro सदस्यताएँ',
          'Pro विज्ञापन हटाने, असीमित इनवॉइस, उन्नत रिपोर्ट, प्रीमियम टेम्पलेट, निर्यात और क्लाउड बैकअप जैसी सुविधाएँ खोल सकता है। खरीद Apple App Store या Google Play से संसाधित होती है। स्टोर खाता सेटिंग्स से रद्द करने तक सदस्यताएँ अपने आप नवीनीकृत होती हैं।',
        ),
        _s(
          'मुफ्त बनाम Pro',
          'मुफ्त संस्करण में विज्ञापन, उपयोग सीमाएँ और बुनियादी सुविधाएँ हो सकती हैं। Pro विज्ञापन हटाता है और सदस्यता स्क्रीन पर दिखाई गई अतिरिक्त सुविधाएँ खोलता है।',
        ),
        _s(
          'रद्दीकरण और रिफंड',
          'आप अपने Apple App Store या Google Play खाते से सदस्यता रद्द कर सकते हैं। रिफंड संबंधित स्टोर की नीतियों के अनुसार उसी स्टोर द्वारा संभाले जाते हैं।',
        ),
        _s(
          'डेटा और गोपनीयता',
          'आपके डेटा का प्रबंधन हमारी गोपनीयता नीति में बताया गया है। आपके पास ऐप में ग्राहक या व्यवसाय डेटा दर्ज करने की अनुमति होनी चाहिए।',
        ),
        _s(
          'दायित्व की सीमा',
          'ऐप “जैसा है” आधार पर दिया जाता है। कानून द्वारा अनुमत सीमा तक, $_company अप्रत्यक्ष हानि, डेटा त्रुटि, व्यावसायिक निर्णय, कर गणना या ऐप के दुरुपयोग के लिए उत्तरदायी नहीं है।',
        ),
        _s(
          'बदलाव',
          'हम समय-समय पर इन शर्तों को अपडेट कर सकते हैं। बदलाव ऐप में प्रकाशित होंगे और प्रकाशित होने पर प्रभावी होंगे।',
        ),
      ],
    ),
  ),
  'ja': LegalContent(
    lastUpdated: '最終更新',
    contact: 'お問い合わせ',
    visitWebsite: 'ウェブサイトを見る',
    emailSupport: 'サポートにメールする',
    contactSupport: 'サポートに問い合わせる',
    contactFooter: 'プライバシーに関するご質問は、上記の方法でお問い合わせください。',
    emailSupportTitle: 'メールサポート',
    emailFallback: 'メールアプリを開けませんでした。サポート用メールアドレスをコピーできます。',
    copyEmail: 'メールをコピー',
    emailCopied: 'サポート用メールアドレスをコピーしました。',
    close: '閉じる',
    couldNotOpenLink: 'このリンクを開けませんでした。',
    privacyEmailSubject: 'プライバシーに関するお問い合わせ - $_app',
    termsEmailSubject: '利用規約 - $_app',
    privacy: LegalDocumentContent(
      title: 'プライバシーポリシー',
      sections: [
        _s(
          '概要',
          '$_company（以下「当社」）は、$_app モバイルアプリケーション（以下「本アプリ」）を運営しています。本ポリシーでは、本アプリの利用時に情報を収集、利用、開示、保護する方法を説明します。',
        ),
        _s(
          '収集する情報',
          '本アプリの利用方法に応じて、次の情報を収集する場合があります。\n• 会社名、住所、ロゴなど、お客様が提供するアカウントおよび事業情報。\n• 顧客情報、項目、金額、税金、チップなど、お客様が作成する請求書データ。\n• アプリ操作、診断情報、クラッシュレポートなどの端末および利用データ。\n• 電話帳から顧客をインポートすることを選択した場合に限る、任意の連絡先アクセス。',
        ),
        _s(
          '第三者サービス',
          '本アプリは適切に動作するため、認証、データベース、ストレージに Firebase および Google Cloud、無料版の広告に Google Mobile Ads、安定性向上のための診断、分析、クラッシュレポートツールなどの第三者サービスを使用する場合があります。これらの提供者は独自のポリシーに従ってデータを処理することがあります。',
        ),
        _s(
          '情報の利用方法',
          '当社は、アプリ機能の提供と改善、設定の保存、サポートの提供、不正行為や乱用の防止、利用規約の執行、法的義務の履行のために情報を使用します。',
        ),
        _s(
          'データの共有',
          '当社は個人情報を販売しません。情報は、本アプリの運営を支援するサービス提供者、法律または有効な法的要請で必要な場合、または合併、買収、資産売却の一部としてのみ共有することがあります。',
        ),
        _s(
          '支払いとサブスクリプション',
          'サブスクリプションを購入する場合、支払いは Apple App Store または Google Play によって処理されます。当社はカードの完全な情報を受け取ったり保存したりしません。サブスクリプションの状態は Pro 機能の解除に使用される場合があります。',
        ),
        _s(
          '広告（無料版）',
          '無料版では広告が表示される場合があります。広告パートナーは、広告の表示と成果測定のために限定的な端末識別子を収集する場合があります。利用可能な場合は Pro にアップグレードして広告を削除できます。',
        ),
        _s(
          '連絡先（任意）',
          '連絡先の権限を許可すると、顧客をより早く選択できるよう、本アプリが連絡先データを読み取ることがあります。この権限は端末の設定でいつでも拒否または取り消しできます。',
        ),
        _s(
          'データの保持',
          '当社は、本アプリの提供およびコンプライアンス、紛争解決、ポリシーの執行などの正当な目的に必要な期間だけ情報を保持します。',
        ),
        _s(
          'セキュリティ',
          '当社は情報を保護するために合理的な安全対策を講じます。ただし、送信または保存の方法に完全に安全なものはありません。',
        ),
        _s(
          'お客様の権利',
          'お住まいの地域によっては、データへのアクセス、訂正、削除、エクスポートを求める権利があります。設定からアカウントを削除するか、データに関するサポートをお問い合わせください。',
        ),
        _s('子どものプライバシー', '本アプリは 13 歳未満の子どもを対象としておらず、子どもの個人情報を故意に収集することはありません。'),
        _s(
          '本ポリシーの変更',
          '当社は本プライバシーポリシーを随時更新する場合があります。更新は本アプリまたは当社ウェブサイトに掲載されます。',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: '利用規約',
      sections: [
        _s(
          '規約への同意',
          '$_app を使用する、または Pro サブスクリプションを購入することで、お客様は本規約およびプライバシーポリシーに同意したものとみなされます。同意しない場合は、本アプリを使用せず、サブスクリプションを購入しないでください。',
        ),
        _s(
          '本アプリの利用',
          '$_app は請求書、レポート、エクスポート、事業関連書類の作成を支援します。送信または使用する前に、請求書、税金、合計、データの正確性を確認する責任はお客様にあります。',
        ),
        _s(
          'Pro サブスクリプション',
          'Pro では、広告の削除、無制限の請求書、高度なレポート、プレミアムテンプレート、エクスポート、クラウドバックアップなどの機能が解除される場合があります。購入は Apple App Store または Google Play で処理されます。ストアアカウントの設定でキャンセルするまで、サブスクリプションは自動更新されます。',
        ),
        _s(
          '無料版と Pro',
          '無料版には広告、利用制限、基本機能が含まれる場合があります。Pro は広告を削除し、サブスクリプション画面に表示される追加機能を解除します。',
        ),
        _s(
          'キャンセルと返金',
          'Apple App Store または Google Play のアカウントからサブスクリプションをキャンセルできます。返金は、該当するストアのポリシーに従って処理されます。',
        ),
        _s(
          'データとプライバシー',
          'データの取り扱いはプライバシーポリシーに記載されています。お客様は、顧客または事業データを本アプリに入力するための権限を持っている必要があります。',
        ),
        _s(
          '責任の制限',
          '本アプリは「現状有姿」で提供されます。法律で許される範囲で、$_company は間接的な損失、データエラー、事業上の判断、税計算、または本アプリの不正使用について責任を負いません。',
        ),
        _s('変更', '当社は本規約を随時更新する場合があります。変更は本アプリに掲載され、掲載時に発効します。'),
      ],
    ),
  ),
  'ru': LegalContent(
    lastUpdated: 'Последнее обновление',
    contact: 'Контакты',
    visitWebsite: 'Открыть сайт',
    emailSupport: 'Написать в поддержку',
    contactSupport: 'Связаться с поддержкой',
    contactFooter:
        'Если у вас есть вопросы о конфиденциальности, свяжитесь с нами указанным выше способом.',
    emailSupportTitle: 'Поддержка по электронной почте',
    emailFallback:
        'Не удалось открыть почтовое приложение. Вы можете скопировать адрес поддержки.',
    copyEmail: 'Копировать e-mail',
    emailCopied: 'Адрес поддержки скопирован.',
    close: 'Закрыть',
    couldNotOpenLink: 'Не удалось открыть эту ссылку.',
    privacyEmailSubject: 'Запрос о конфиденциальности — $_app',
    termsEmailSubject: 'Условия использования — $_app',
    privacy: LegalDocumentContent(
      title: 'Политика конфиденциальности',
      sections: [
        _s(
          'Обзор',
          '$_company («мы») управляет мобильным приложением $_app («Приложение»). Эта Политика конфиденциальности объясняет, как мы собираем, используем, раскрываем и защищаем информацию при использовании Приложения.',
        ),
        _s(
          'Информация, которую мы собираем',
          'В зависимости от того, как вы используете Приложение, мы можем собирать:\n• Предоставленные вами данные учетной записи и бизнеса, например название, адрес или логотип.\n• Созданные вами данные счетов, например данные клиента, позиции, суммы, налог и чаевые.\n• Данные об устройстве и использовании, например взаимодействия с приложением, диагностику и отчеты о сбоях.\n• Необязательный доступ к контактам только если вы решили импортировать клиентов из контактов телефона.',
        ),
        _s(
          'Сторонние сервисы',
          'Для корректной работы Приложение может использовать сторонние сервисы, включая Firebase и Google Cloud для аутентификации, базы данных и хранения; Google Mobile Ads для рекламы в бесплатной версии; а также инструменты диагностики, аналитики и отчетов о сбоях. Эти поставщики могут обрабатывать данные в соответствии со своими политиками.',
        ),
        _s(
          'Как мы используем информацию',
          'Мы используем информацию для предоставления и улучшения функций Приложения, сохранения ваших предпочтений и настроек, оказания поддержки, предотвращения мошенничества или злоупотреблений, применения наших условий и выполнения юридических обязанностей.',
        ),
        _s(
          'Передача данных',
          'Мы не продаем ваши персональные данные. Мы можем передавать информацию только поставщикам, которые помогают работать Приложению, когда это требуется законом или действительным юридическим запросом, либо в рамках слияния, приобретения или продажи активов.',
        ),
        _s(
          'Платежи и подписки',
          'Если вы покупаете подписку, платежи обрабатываются Apple App Store или Google Play. Мы не получаем и не храним полные данные вашей карты. Статус подписки может использоваться для открытия функций Pro.',
        ),
        _s(
          'Реклама (бесплатная версия)',
          'В бесплатной версии может показываться реклама. Рекламные партнеры могут собирать ограниченные идентификаторы устройства для показа рекламы и измерения эффективности. Вы можете убрать рекламу, перейдя на Pro, если эта возможность доступна.',
        ),
        _s(
          'Контакты (необязательно)',
          'Если вы разрешите доступ к контактам, Приложение может читать данные контактов, чтобы помочь быстрее выбирать клиентов. Это разрешение можно отклонить или отозвать в любой момент в настройках устройства.',
        ),
        _s(
          'Хранение данных',
          'Мы храним информацию только столько, сколько необходимо для работы Приложения и законных целей, таких как соблюдение требований, разрешение споров и применение политик.',
        ),
        _s(
          'Безопасность',
          'Мы применяем разумные меры защиты информации. Однако ни один способ передачи или хранения не является полностью безопасным.',
        ),
        _s(
          'Ваши права',
          'В зависимости от вашего местонахождения вы можете иметь право на доступ, исправление, удаление или экспорт своих данных. Вы можете удалить учетную запись в настройках или обратиться к нам за помощью.',
        ),
        _s(
          'Конфиденциальность детей',
          'Приложение не предназначено для детей младше 13 лет, и мы сознательно не собираем их персональные данные.',
        ),
        _s(
          'Изменения этой политики',
          'Мы можем периодически обновлять эту Политику конфиденциальности. Обновления будут опубликованы в Приложении или на нашем сайте.',
        ),
      ],
    ),
    terms: LegalDocumentContent(
      title: 'Условия использования',
      sections: [
        _s(
          'Принятие условий',
          'Используя $_app или приобретая подписку Pro, вы соглашаетесь с этими Условиями и нашей Политикой конфиденциальности. Если вы не согласны, не используйте Приложение и не покупайте подписку.',
        ),
        _s(
          'Использование Приложения',
          '$_app помогает создавать счета, отчеты, экспортировать данные и создавать деловые документы. Вы несете ответственность за проверку точности счетов, налогов, итогов и данных перед отправкой или использованием.',
        ),
        _s(
          'Подписки Pro',
          'Pro может открывать такие функции, как отключение рекламы, неограниченное число счетов, расширенные отчеты, премиум-шаблоны, экспорт и облачное резервное копирование. Покупки обрабатываются Apple App Store или Google Play. Подписки автоматически продлеваются, пока вы не отмените их в настройках учетной записи магазина.',
        ),
        _s(
          'Бесплатная версия и Pro',
          'Бесплатная версия может включать рекламу, ограничения использования и базовые функции. Pro отключает рекламу и открывает дополнительные функции, показанные на экране подписки.',
        ),
        _s(
          'Отмена и возвраты',
          'Вы можете отменить подписку в учетной записи Apple App Store или Google Play. Возвраты обрабатываются соответствующим магазином в соответствии с его политикой.',
        ),
        _s(
          'Данные и конфиденциальность',
          'Обработка ваших данных описана в нашей Политике конфиденциальности. У вас должно быть разрешение на ввод данных клиентов или бизнеса в Приложение.',
        ),
        _s(
          'Ограничение ответственности',
          'Приложение предоставляется «как есть». В пределах, разрешенных законом, $_company не несет ответственности за косвенные убытки, ошибки данных, деловые решения, налоговые расчеты или неправильное использование Приложения.',
        ),
        _s(
          'Изменения',
          'Мы можем периодически обновлять эти Условия. Изменения будут опубликованы в Приложении и вступят в силу после публикации.',
        ),
      ],
    ),
  ),
  'zh': LegalContent(
    lastUpdated: '最后更新',
    contact: '联系我们',
    visitWebsite: '访问网站',
    emailSupport: '发送支持邮件',
    contactSupport: '联系支持团队',
    contactFooter: '如有隐私相关问题，请通过以上方式联系我们。',
    emailSupportTitle: '电子邮件支持',
    emailFallback: '无法打开邮件应用。您可以复制我们的支持邮箱。',
    copyEmail: '复制邮箱',
    emailCopied: '已复制支持邮箱。',
    close: '关闭',
    couldNotOpenLink: '无法打开此链接。',
    privacyEmailSubject: '隐私请求 - $_app',
    termsEmailSubject: '条款与条件 - $_app',
    privacy: LegalDocumentContent(
      title: '隐私政策',
      sections: [
        _s(
          '概述',
          '$_company（“我们”）运营 $_app 移动应用程序（“本应用”）。本隐私政策说明您使用本应用时，我们如何收集、使用、披露和保护信息。',
        ),
        _s(
          '我们收集的信息',
          '根据您使用本应用的方式，我们可能收集：\n• 您提供的帐户和企业信息，例如企业名称、地址或徽标。\n• 您创建的发票数据，例如客户信息、项目、金额、税费和小费。\n• 设备和使用数据，例如应用交互、诊断信息和崩溃报告。\n• 仅在您选择从手机联系人导入客户时才访问联系人的可选权限。',
        ),
        _s(
          '第三方服务',
          '为正常运行，本应用可能使用第三方服务，包括用于身份验证、数据库和存储的 Firebase 和 Google Cloud；免费版本中用于广告的 Google Mobile Ads；以及用于提升稳定性的诊断、分析或崩溃报告工具。这些提供商可能会根据其自身政策处理数据。',
        ),
        _s(
          '我们如何使用信息',
          '我们使用信息来提供和改进应用功能、保存您的偏好和设置、提供支持、防止欺诈或滥用、执行我们的条款以及履行法律义务。',
        ),
        _s(
          '数据共享',
          '我们不会出售您的个人信息。我们仅会与帮助运营本应用的服务提供商共享信息，在法律或有效法律请求要求时共享，或在合并、收购或资产出售中共享。',
        ),
        _s(
          '付款与订阅',
          '如果您购买订阅，付款将由 Apple App Store 或 Google Play 处理。我们不会接收或存储完整的银行卡信息。订阅状态可能用于解锁 Pro 功能。',
        ),
        _s(
          '广告（免费版本）',
          '免费版本可能显示广告。广告合作伙伴可能收集有限的设备标识符以展示广告并衡量效果。您可以在该选项可用时升级到 Pro 以移除广告。',
        ),
        _s(
          '联系人（可选）',
          '如果您授予联系人权限，本应用可以读取联系人数据，以帮助您更快选择客户。您可以随时在设备设置中拒绝或撤销该权限。',
        ),
        _s('数据保留', '我们仅在提供本应用和用于合规、争议解决及政策执行等合法目的所需的期限内保留信息。'),
        _s('安全', '我们采取合理措施保护信息。但是，没有任何传输或存储方法是完全安全的。'),
        _s('您的权利', '根据您所在的位置，您可能有权访问、更正、删除或导出您的数据。您可以在设置中删除帐户，或联系我们获取数据帮助。'),
        _s('儿童隐私', '本应用不面向 13 岁以下儿童，我们不会故意收集儿童的个人信息。'),
        _s('本政策的变更', '我们可能不时更新本隐私政策。更新将在本应用或我们的网站上发布。'),
      ],
    ),
    terms: LegalDocumentContent(
      title: '条款与条件',
      sections: [
        _s(
          '接受条款',
          '使用 $_app 或购买 Pro 订阅，即表示您同意这些条款和我们的隐私政策。如果您不同意，请勿使用本应用或购买订阅。',
        ),
        _s(
          '使用本应用',
          '$_app 可帮助创建发票、报告、导出和业务相关文档。您有责任在发送或使用发票、税费、总额和数据之前核对其准确性。',
        ),
        _s(
          'Pro 订阅',
          'Pro 可能解锁移除广告、无限发票、高级报告、高级模板、导出和云备份等功能。购买由 Apple App Store 或 Google Play 处理。订阅会自动续订，直到您在商店帐户设置中取消。',
        ),
        _s('免费版与 Pro', '免费版本可能包含广告、使用限制和基本功能。Pro 会移除广告，并解锁订阅页面中显示的其他功能。'),
        _s(
          '取消与退款',
          '您可以从 Apple App Store 或 Google Play 帐户取消订阅。退款由相应商店根据其政策处理。',
        ),
        _s('数据与隐私', '您的数据处理方式在我们的隐私政策中说明。您必须有权在本应用中输入客户或企业数据。'),
        _s(
          '责任限制',
          '本应用按“现状”提供。在法律允许的范围内，$_company 不对间接损失、数据错误、商业决策、税务计算或不当使用本应用负责。',
        ),
        _s('变更', '我们可能会不时更新这些条款。变更会在本应用中发布，并在发布时生效。'),
      ],
    ),
  ),
};
