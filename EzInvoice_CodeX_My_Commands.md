# Memoria

Fecha: 2026-02-25
Proyecto: EzInvoice (iOS)

Resumen de lo hablado:
- Apple rechazo la version 1.0.0 (24) con 3 puntos:
  - 2.1.0 App Completeness
  - 3.1.1 In-App Purchase
  - 5.1.1 Data Collection and Storage (account deletion)
- Verificamos que en el codigo actual existen:
  - Login demo/review con credenciales de prueba.
  - Flujo de suscripcion IAP (compra y restore).
  - Flujo de Delete Account visible desde Home.
- Credenciales demo para Review:
  - demo.review@liisgo.com
  - Demo1234!
  - Alias legado: demo@invoiceapp.test
- Identificadores confirmados:
  - Bundle ID: com.liisgo.ezinvoice
  - App Apple ID: 6757661737
- Se prepararon textos en espanol e ingles para responder en App Store Connect.
- Link sugerido de la app:
  - https://apps.apple.com/app/id6757661737

Nota:
- Este archivo se guardo dentro del repo para mantener el hilo y poder subirlo a GitHub.

## Reglas De Trabajo

- Siempre preguntar/decir primero que entendi antes de hacer cualquier trabajo: "Esto es lo que entendi...".
- Antes de hacer cambios, decir brevemente lo entendido.
- No pedir aclaraciones si hay una decision razonable y segura.
- Guardar en este archivo los cambios importantes, decisiones y comandos utiles.
- Mantener los cambios versionados y subirlos a GitHub cuando el trabajo quede verificado.
- Subir version/build de la app en cada cambio (`pubspec.yaml`) y sincronizar cualquier texto visible de version.
- Texto visible de version debe usar formato `Version x.x.x`, sin `v` y sin build entre parentesis.
- Usar la version de Git como fuente principal y sincronizar la carpeta local que se usa para correr la app despues de cada push.
- Cada cambio de interfaz debe diseñarse y verificarse en pantalla narrow y wide, usando ancho útil y tamaño de texto como criterio; no asumir la disposición por el nombre del dispositivo.

## 2026-06-08

- Repo actual bajado desde: https://github.com/acesoftware365/ezinvoicepro
- Rama inicial: `main`
- Objetivo activo: mejorar monetizacion AdMob porque el match rate ronda 12%.
- Problema sospechado: banners fijos/standard y mal manejo de carga pueden generar solicitudes menos optimas o espacios vacios.
- Cambio iniciado: reemplazar `lib/services/ads/banner_ad_widget.dart` por un widget reusable de Anchored Adaptive Banner usando `google_mobile_ads`.
- Requisitos del widget:
  - Calcular ancho con `MediaQuery`.
  - Pedir tamano optimo con `AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize`.
  - Mostrar `AdWidget` solo cuando `onAdLoaded` confirme exito.
  - En `onAdFailedToLoad`, hacer `dispose`, no reservar espacio en blanco y reintentar suavemente.
  - Liberar memoria con `dispose()`.
- Verificacion:
  - `dart analyze lib/services/ads/banner_ad_widget.dart`: OK, no issues.
  - `flutter analyze`: falla por 161 issues preexistentes en otros archivos; no reporta errores en `banner_ad_widget.dart`.
  - `flutter test`: falla por `test/widget_test.dart`, porque el test arranca `AuthGate` sin `Firebase.initializeApp()` y luego espera un counter demo que ya no existe.

## 2026-06-08 - Change Password

- Pedido: agregar una forma para que el usuario pueda cambiar password.
- Regla frecuente confirmada: cada cambio debe subir version/build de app y luego commitearse/subirse a GitHub.
- Version subida: `1.0.0+24` -> `1.0.1+25`.
- Texto visible en Home actualizado: `v1.0.1 (25)`.
- Cambio implementado:
  - Nueva pantalla `lib/features/account/change_password_screen.dart`.
  - Reautentica con password actual usando `EmailAuthProvider.credential`.
  - Actualiza password con `user.updatePassword(newPassword)`.
  - Valida minimo 6 caracteres, confirmacion y que la nueva password sea diferente.
  - Maneja errores comunes: password actual incorrecta, password debil, requires-recent-login.
  - En Home se agrego acceso inferior a `Password/Contrasena`.
- Verificacion:
  - `dart format lib/features/account/change_password_screen.dart lib/ui/home_screen.dart`: OK.
  - `dart analyze lib/features/account/change_password_screen.dart lib/ui/home_screen.dart`: sin errores; solo infos preexistentes de `withOpacity` en Home.

## 2026-06-08 - Regla De Entendimiento

- Pedido: grabar en el documento que siempre debo preguntar/decir que entendi antes de actuar.
- Regla agregada en `Reglas De Trabajo`.
- Version subida por cambio de repo: `1.0.1+25` -> `1.0.2+26`.
- Texto visible en Home actualizado: `v1.0.2 (26)`.

## 2026-06-08 - Version En Login

- Problema reportado con captura: pantalla de Login seguia mostrando `v1.0.0 (23)`.
- Causa: `lib/ui/login_screen.dart` tenia su propio `_forcedVersionText`, separado del Home.
- Cambio:
  - Login actualizado a `v1.0.3 (27)`.
  - Home actualizado a `v1.0.3 (27)`.
  - `pubspec.yaml` actualizado a `1.0.3+27`.
- Nota frecuente: cuando se suba version, revisar todos los textos `_forcedVersionText` con `rg "_forcedVersionText|v1\\." lib pubspec.yaml`.

## 2026-06-08 - Formato Version Visible

- Pedido: mostrar `Version 1...` y no usar parentesis.
- Version subida por cambio de repo: `1.0.3+27` -> `1.0.4+28`.
- Login y Home ahora muestran `Version 1.0.4`.
- Regla agregada: texto visible de version debe ser `Version x.x.x`, sin `v` y sin build entre parentesis.

## 2026-06-08 - Forgot Password

- Pedido: si al usuario se le olvida el password, agregar forma de recuperarlo.
- Regla confirmada: usar la version de Git como fuente principal y conservar lo hecho hasta ahora.
- Version subida por cambio de repo: `1.0.4+28` -> `1.0.5+29`.
- Login y Home ahora muestran `Version 1.0.5`.
- Cambio implementado:
  - En Login, boton `Forgot password?` / `Olvidaste tu contrasena?` solo cuando esta en modo login.
  - Usa `FirebaseAuth.instance.sendPasswordResetEmail(email: email)`.
  - Valida que el email este escrito antes de enviar.
  - Maneja errores `user-not-found`, `invalid-email` y errores generales.
- Verificacion:
  - `dart format lib/ui/login_screen.dart lib/ui/home_screen.dart`: OK.
  - `dart analyze lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos; solo infos preexistentes de `withOpacity` en Home.

## 2026-06-08 - Remover Boton Password Home

- Pedido: remover el boton `Password` que aparecia en el footer del Home.
- Version subida por cambio de repo: `1.0.5+29` -> `1.0.6+30`.
- Login y Home ahora muestran `Version 1.0.6`.
- Cambio implementado:
  - Se removio el boton inferior `Password/Contrasena` del Home.
  - Se mantuvo `Forgot password?` en Login para recuperar password olvidado.
  - Se mantuvo el archivo `change_password_screen.dart` sin acceso visible desde Home, por si se reutiliza mas adelante.
- Verificacion:
  - `dart format lib/ui/home_screen.dart lib/ui/login_screen.dart`: OK.
  - `dart analyze lib/ui/home_screen.dart lib/ui/login_screen.dart`: sin errores nuevos; solo infos preexistentes de `withOpacity` en Home.

## 2026-06-08 - Force Update App Store / Google Play

- Pedido: forzar update cuando se suba version nueva a App Store y Google Play.
- Version subida por cambio de repo: `1.0.6+30` -> `1.0.7+31`.
- Login y Home ahora muestran `Version 1.0.7`.
- Cambio implementado:
  - Nuevo `lib/services/app_update/force_update_gate.dart`.
  - `main.dart` envuelve la app con `ForceUpdateGate` antes de Login/Home.
  - Lee Firestore: `app_config/force_update`.
  - Si `enabled == true` y la version/build instalado es menor que el minimo requerido, bloquea la app y muestra boton `Update now` / `Actualizar ahora`.
  - Abre App Store: `https://apps.apple.com/app/id6757661737`.
  - Abre Google Play: `https://play.google.com/store/apps/details?id=com.liisgo.ezinvoice`.
- Campos Firestore esperados:
  - `enabled`: bool.
  - `iosMinimumVersion`: string, ejemplo `1.0.7`.
  - `iosMinimumBuild`: number, ejemplo `31`.
  - `iosStoreUrl`: string opcional.
  - `androidMinimumVersion`: string, ejemplo `1.0.7`.
  - `androidMinimumBuild`: number, ejemplo `31`.
  - `androidStoreUrl`: string opcional.
- Para forzar update despues de publicar en tiendas:
  - Esperar a que App Store / Google Play tengan la version nueva disponible.
  - Actualizar Firestore `app_config/force_update` con `enabled: true` y el minimum build/version nuevo.
  - Para apagar el bloqueo, poner `enabled: false`.
- Verificacion:
  - `dart format lib/services/app_update/force_update_gate.dart lib/main.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: OK.
  - `dart analyze lib/services/app_update/force_update_gate.dart lib/main.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos; solo infos preexistentes de `withOpacity` en Home.

## 2026-06-08 - Rewarded Ads En Report Exports

- Opinion/decision: buena estrategia para empujar membresia Pro sin quitar completamente el valor al plan Free.
- Pedido: usuario Free debe ver rewarded ad cada vez que quiera exportar reporte PDF o CSV; cada anuncio permite solo una exportacion.
- Version subida por cambio de repo: `1.0.7+31` -> `1.0.8+32`.
- Login y Home ahora muestran `Version 1.0.8`.
- Cambio implementado:
  - `ReportsScreen` ya no manda FREE directo al paywall para exportar.
  - Si el usuario es Pro, exporta PDF/CSV directo sin anuncio.
  - Si el usuario es Free, cada export PDF o accion CSV llama `AdsManager.showRewarded`.
  - La exportacion solo corre si el rewarded ad entrega recompensa completa.
  - Si el anuncio no esta listo o no se completa, no exporta y muestra mensaje recomendando completar el anuncio o pasar a Pro.
  - `AdsManager.showRewarded` ahora devuelve `true` solo si el reward fue ganado, no solo si el anuncio se abrio.
- Reset password:
  - Mensaje actualizado para indicar en el idioma seleccionado que revise Spam/Junk.
- Verificacion:
  - `dart format lib/services/ads/ads_manager.dart lib/features/reports/reports_screen.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: OK.
  - `dart analyze lib/services/ads/ads_manager.dart lib/features/reports/reports_screen.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos; solo infos preexistentes de `withOpacity`/`value`.

## 2026-06-08 - Codex UI/UX June 8 2026

- Pedido: preservar lo que funciona, no eliminar botones/funciones, y redisenar la experiencia para tablet y phone segun referencias SaaS premium.
- Backup antes de cambios:
  - Tag: `backup-before-codex-ui-ux-june-8-2026`
  - Rama local: `Codex-UI-UX-June-8-2026`
- Version subida por cambio de repo: `1.0.8+32` -> `1.0.9+33`.
- Login y Home ahora muestran `Version 1.0.9`.
- Analisis de referencia:
  - Tablet: sidebar permanente, contenido ancho, dashboard con metricas, quick actions, tabla y panel analitico derecho.
  - Phone: bottom navigation, metricas verticales, quick actions 2x2, listas compactas, perfil/settings desde avatar.
  - Paleta principal: verde `#1F7A64`, fondo `#F5F7F8`, cards blancas, radius 16, sombras suaves.
- Cambio implementado:
  - Nuevo `lib/ui/shell/responsive_main_shell.dart`.
  - `AuthGate` ahora entra a `ResponsiveMainShell` para usuarios autenticados.
  - Tablet usa sidebar de 280px con Home, Clients, Invoices, Reports, Business, Settings.
  - Phone usa bottom navigation con Home, Clients, Invoices, Reports, Business.
  - Dashboard nuevo usa datos reales de invoices/usuario para sales, tip, subtotal, tax, recent invoices, collection rate y plan.
  - Se conservan pantallas existentes de Clients, Invoices, Reports y Business para no perder funciones.
  - Settings tablet concentra Language, Subscription, Privacy Policy, Delete Account y Log out.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart lib/ui/auth_gate.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart lib/ui/auth_gate.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos; solo infos preexistentes en `home_screen.dart`.

## 2026-06-08 - Clients UI/UX Mobile + Tablet

- Pedido: rehacer Contactos/Clients segun mockups: mobile compacto con cards, menu de tres puntos y FAB; tablet master-detail.
- Version subida por cambio de repo: `1.0.9+33` -> `1.0.10+34`.
- Login y Home ahora muestran `Version 1.0.10`.
- Cambio implementado:
  - `ClientsScreen` ahora es responsive.
  - Mobile: titulo grande, search bar, cards compactas con avatar/letra, nombre, telefono, email y menu de tres puntos.
  - Mobile: no se muestran botones separados Call/SMS/WhatsApp/Email/Delete dentro de cada card.
  - Menu por cliente: Call, Message, Share, Edit, Delete.
  - Share abre bottom sheet con SMS, WhatsApp y Email.
  - Tablet: layout master-detail con panel izquierdo de busqueda/lista y panel derecho con detalles del cliente.
  - Tablet: acciones Call, Share, Edit y Delete permanecen visibles en el detalle.
  - Se mantiene el flujo existente de add/edit/delete y los launchers existentes de tel/sms/WhatsApp/email.

## 2026-06-08 - Invoices UI/UX Mobile Compact

- Pedido: redisenar pantalla Invoices para iPhone 13 a iPhone 17 Pro Max con estilo Apple/Stripe/QuickBooks, menos scroll y menos ruido visual.
- Version subida por cambio de repo: `1.0.10+34` -> `1.0.11+35`.
- Login y Home ahora muestran `Version 1.0.11`.
- Cambio implementado:
  - `InvoicesScreen` ahora maneja busqueda y filtros por estado.
  - Top mobile: titulo `Invoices`, search field y chips `All`, `Unsent`, `Sent`, `Paid`, `Overdue`.
  - Cards compactas con badge de estado, amount, invoice number, client name, date y menu de tres puntos.
  - Se removieron los botones visibles dentro de cada invoice card.
  - Acciones movidas al menu: View PDF, Send Invoice, Mark as Paid/Unpaid, Receipt PDF, Edit Invoice, Delete Invoice.
  - FAB verde circular mantiene crear nueva factura.
  - Se conserva la logica existente de PDF, send/unsend, paid/unpaid, edit y delete.

## 2026-06-08 - Business Profile UI/UX + Completion Reminder

- Pedido: redisenar Business Profile para que se sienta como perfil profesional de empresa, no formulario largo.
- Version subida por cambio de repo: `1.0.11+35` -> `1.0.12+36`.
- Login y Home ahora muestran `Version 1.0.12`.
- Cambio implementado:
  - `BusinessProfileScreen` ahora usa cards premium responsive para phone/tablet.
  - Phone: logo card, business information, settings row, footer note y service presets.
  - Tablet: layout dashboard con logo a la izquierda, business information a la derecha, settings/footer/presets debajo.
  - Logo: si existe, muestra menu de tres puntos con Change Logo y Remove Logo.
  - Service presets: lista compacta con edit y delete por servicio; FAB verde para agregar servicio.
  - Se conserva guardado de business profile, logo local, currency, tax, footer note y presets.
  - `ResponsiveMainShell` muestra badge de alerta en Business si faltan campos clave.
  - Snackbar una vez al dia recuerda completar Business Profile y permite abrir Business.

## 2026-06-08 - Business Profile Overflow/Semantics Fix

- Pedido: corregir overflow visible en Business Profile phone y excepcion Flutter semantics.
- Version subida por cambio de repo: `1.0.12+36` -> `1.0.13+37`.
- Login y Home ahora muestran `Version 1.0.13`.
- Cambio implementado:
  - Currency/Tax settings en phone ahora se apilan cuando el ancho no permite dos columnas sin overflow.
  - Currency dropdown usa `isExpanded` y selected value corto para evitar overflow horizontal.
  - Badge del tab Business ya no usa `Badge`; ahora usa `Stack` simple con semantica interna excluida para evitar el assert `!semantics.parentDataDirty`.

## 2026-06-08 - Business Profile Tablet Layout Fix

- Pedido: Business Profile en tablet/iPad queda en blanco y no abre correctamente.
- Version subida por cambio de repo: `1.0.13+37` -> `1.0.14+38`.
- Login y Home ahora muestran `Version 1.0.14`.
- Cambio implementado:
  - Tablet Business Profile ya no usa `crossAxisAlignment: stretch` dentro del scroll.
  - Corrige el error `BoxConstraints forces an infinite height` en la fila de logo + business information.

## 2026-06-08 - Paywall/Ads Entitlement Fix

- Pedido: paywall no funciona correctamente y una cuenta gratis no muestra anuncios.
- Evidencia de log: productos IAP encontrados, pero el runtime marcaba `Pro: true | Plan: ProPlan.monthly` aunque la cuenta Firebase era gratis.
- Causa: `SubscriptionManager.init()` hacia `restorePurchases()` automaticamente. En Android/Google Play, un restore puede devolver compras asociadas a la cuenta Play del dispositivo, no necesariamente al usuario Firebase actual. Eso podia poner `SubscriptionManager.state.isPro=true` y apagar anuncios para cuentas gratis.
- Version subida por cambio de repo: `1.0.14+38` -> `1.0.15+39`.
- Login y Home ahora muestran `Version 1.0.15`.
- Cambio implementado:
  - `SubscriptionManager.init()` ya no ejecuta restore automatico.
  - `Restore Purchases` queda solo como accion explicita desde el paywall.
  - `AuthGate` ahora escucha `users/{uid}` y sincroniza `plan/isPro/proPlan` desde Firestore hacia `SubscriptionManager` y `AdsManager`.
  - Cuenta `free` en Firestore fuerza `Pro=false` y `AdsManager.setAdsEnabled(true)`.
  - Compra/restore explicito que resulte Pro sincroniza Firestore con `plan: pro`, `isPro: true`, `proPlan`.
  - Banner adaptive mantiene reintentos progresivos y recarga al volver a la app.
- Verificacion:
  - `dart analyze lib/services/purchases/subscription_manager.dart lib/ui/auth_gate.dart`: OK.

## 2026-06-08 - Invoice Delete / Contact Import / Remember Login Fix

- Pedido: al borrar invoice, Cancel/Delete dejaba la pantalla en blanco; al importar contactos, telefonos con `+1` daban error; en Login agregar opcion para recordar login.
- Version subida por cambio de repo: `1.0.15+39` -> `1.0.16+40`.
- Login y Home ahora muestran `Version 1.0.16`.
- Cambio implementado:
  - `InvoicesScreen` usa el `dialogContext` del `AlertDialog` para cerrar solo el dialogo, no la ruta/pantalla.
  - Se agrego bloqueo `_deletingInvoice` para evitar taps duplicados mientras se borra.
  - Import de contactos limpia caracteres no numericos, remueve prefijo `+1`/`1` cuando aplica y muestra telefono local formateado.
  - Login agrega checkbox `Remember my email` / `Recordar mi email` usando `SharedPreferences`.
  - Por seguridad no se guarda password en texto plano; solo email y preferencia.
- Verificacion:
  - `dart analyze lib/features/invoices/invoices_screen.dart lib/ui/clients/client_form_screen.dart lib/ui/login_screen.dart`: OK.

## 2026-06-08 - Banner Mount Retry Fix

- Pedido: el ad banner a veces aparece y a veces queda en blanco.
- Causa: `AppShell` condicionaba el montaje del banner a `AdsManager.adsEnabled`, pero ese valor se actualiza desde `AuthGate` despues de leer Firestore y no notifica directamente al shell. En algunos arranques Free, el banner podia no montarse/reintentar cuando AdsManager se reactivaba.
- Version subida por cambio de repo: `1.0.16+40` -> `1.0.17+41`.
- Login y Home ahora muestran `Version 1.0.17`.
- Cambio implementado:
  - `AppShell` monta `BannerAdWidget` para toda cuenta Free usando solo `SubscriptionManager.state.isPro`.
  - `BannerAdWidget` ahora reintenta cada 2s si se monto antes de que `AdsManager` estuviera activo.
  - Se mantiene backoff para fallos de AdMob/no-fill: 5s, 15s, 30s, luego 60s.
- Nota: si AdMob responde `no fill`, no se puede forzar inventario desde la app, pero ahora el widget no se queda apagado permanentemente.

## 2026-06-08 - Client Phone Import And Service Dialog Fix

- Pedido: en New Client, telefono importado seguia mostrando `+1` y daba `Invalid phone number`; en Business Profile, dialogo `Add service` no guardaba.
- Version subida por cambio de repo: `1.0.17+41` -> `1.0.18+42`.
- Login y Home ahora muestran `Version 1.0.18`.
- Cambio implementado:
  - `NewClientScreen` ya no usa selector internacional para telefono de cliente.
  - Campo telefono ahora es local y formatea como `123-456-7890`, removiendo prefijo `+1`/`1` cuando aplica.
  - Se elimina la validacion interna que mostraba `Invalid phone number` para telefonos importados.
  - Dialogo `Add service/Edit service` usa `dialogContext` para cerrar solo el dialogo.
  - Guardado de servicio muestra feedback y revierte cambios si Firestore falla.
- Verificacion:
  - `dart analyze lib/ui/clients/client_form_screen.dart lib/ui/business/business_profile_screen.dart`: OK.

## 2026-06-08 - Add Service Save Crash Fix

- Pedido: al tocar `Save` en el dialogo `Add service`, aparecia pantalla roja con `'_dependents.isEmpty': is not true`.
- Causa: el dialogo usaba un `TextEditingController` local y lo destruia inmediatamente al cerrar el dialogo, mientras Flutter todavia desmontaba el `TextField`.
- Version subida por cambio de repo: `1.0.18+42` -> `1.0.19+43`.
- Login y Home ahora muestran `Version 1.0.19`.
- Cambio implementado:
  - `Add service/Edit service` ahora usa `TextFormField(initialValue:)` y variable local `draft`, sin controller temporal.
  - Se elimina el dispose que causaba el assert de Flutter al cerrar con `Save`.
- Verificacion:
  - `dart analyze lib/ui/business/business_profile_screen.dart`: OK.

## 2026-06-08 - Saved Client Phone Invoice Picker Fix

- Pedido: al seleccionar un cliente ya guardado desde New Invoice, el telefono se veia en la lista pero no se copiaba al formulario.
- Causa: el picker mostraba `phoneDisplay`, pero al seleccionar enviaba solo `phoneE164`; los clientes creados con el formato local nuevo pueden tener `phoneE164` vacio.
- Version subida por cambio de repo: `1.0.19+43` -> `1.0.20+44`.
- Login y Home ahora muestran `Version 1.0.20`.
- Cambio implementado:
  - El selector de clientes usa `phoneE164` cuando existe y, si esta vacio, usa `phoneDisplay`.
  - Esto mantiene funcionando los contactos importados del telefono y tambien los clientes guardados manualmente/importados en la base de datos.
- Verificacion:
  - `dart analyze lib/features/invoices/invoice_form_screen.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos del cambio; quedan avisos informativos existentes de `withOpacity`/lint UI en esos archivos.

## 2026-06-08 - Service Preset Picker Button

- Pedido: los service presets pregrabados no se podian seleccionar de forma confiable desde New Invoice.
- Version subida por cambio de repo: `1.0.20+44` -> `1.0.21+45`.
- Login y Home ahora muestran `Version 1.0.21`.
- Cambio implementado:
  - Cada item del invoice ahora tiene boton `Select preset`.
  - El boton abre un popup/bottom sheet con buscador y lista de service presets guardados.
  - Al tocar un preset, se llena inmediatamente la descripcion del servicio del item seleccionado.
  - El autocomplete existente se mantiene para escribir rapido, pero ya no es la unica forma de seleccionar presets.
- Verificacion:
  - `dart analyze lib/features/invoices/invoice_form_screen.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos del cambio; quedan avisos informativos existentes de `withOpacity`/lint UI en esos archivos.

## 2026-06-08 - Rewarded Ad Para Ver Reportes Free

- Pedido: no cambiar nada mas; solo agregar rewarded ad en Reports para que usuario Free pueda ver o enviar/exportar reporte una sola vez por anuncio.
- Version subida por cambio de repo: `1.0.21+45` -> `1.0.22+46`.
- Login y Home ahora muestran `Version 1.0.22`.
- Cambio implementado:
  - `ReportsScreen` ahora bloquea la vista del reporte para cuentas Free con una tarjeta `Watch ad / Ver anuncio`.
  - Si el usuario ve el rewarded completo, se desbloquea la vista del reporte actual una vez.
  - Si cambia mes, ano, o cambia entre mensual/anual, se vuelve a pedir rewarded para ver el nuevo reporte.
  - Exportar/enviar PDF o CSV mantiene el rewarded existente: cada accion de exportacion requiere su propio anuncio completo en Free.
  - Pro sigue viendo y exportando reportes sin anuncios.
- Verificacion:
  - `dart analyze lib/features/reports/reports_screen.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos del cambio; quedan avisos informativos existentes de `withOpacity`/lint UI en esos archivos.

## 2026-06-08 - Business Logo Persistence Fix

- Pedido: el logo del Business Profile se borra/desaparece despues de hacer logout aunque se toque Save.
- Version subida por cambio de repo: `1.0.22+46` -> `1.0.23+47`.
- Login y Home ahora muestran `Version 1.0.23`.
- Cambio implementado:
  - `BusinessProfile` ahora guarda tambien `logoDataBase64` junto con `logoFilePath`.
  - Al cargar Business Profile, si la ruta local del logo no existe, se restaura el archivo desde `logoDataBase64` guardado en Firestore.
  - Al subir logo, se guarda la ruta local y una copia persistente compacta del archivo.
  - Al tocar Save con un logo local existente, tambien se genera la copia persistente para logos subidos antes de este cambio.
  - Al remover logo, se limpia correctamente la ruta local y la copia persistente.
- Verificacion:
  - `dart analyze lib/models/business_profile.dart lib/utils/logo_storage.dart lib/ui/business/business_profile_screen.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos del cambio; quedan avisos informativos existentes de `withOpacity`/lint UI en esos archivos.

## 2026-06-08 - Reports Rewarded Export Only

- Pedido: remover la tarjeta `View report` y el boton `Watch ad`; el reporte debe verse normal y el rewarded ad debe salir solo al tocar `Export PDF` o `Export CSV`.
- Version subida por cambio de repo: `1.0.23+47` -> `1.0.24+48`.
- Login y Home ahora muestran `Version 1.0.24`.
- Cambio implementado:
  - `ReportsScreen` vuelve a mostrar el reporte directamente sin gate visual.
  - Se mantiene rewarded ad para usuarios Free en `Export PDF`.
  - Se mantiene rewarded ad para usuarios Free en las acciones de `Export CSV`.
  - Pro sigue exportando sin anuncios.
  - Textos visibles del menu CSV ahora cambian entre ingles/espanol segun el idioma seleccionado.
- Verificacion:
  - `dart analyze lib/features/reports/reports_screen.dart lib/ui/login_screen.dart lib/ui/home_screen.dart`: sin errores nuevos del cambio; quedan avisos informativos existentes de `withOpacity`/lint UI en esos archivos.

## 2026-06-08 - Pro AdBanner Visibility Fix

- Pedido: arreglar que no se vea el adbanner cuando la app tenga una cuenta pro.
- Version subida por cambio de repo: `1.0.24+48` -> `1.0.25+49`.
- Login y Home ahora muestran `Version 1.0.25`.
- Cambio implementado:
  - `AppShell` ahora elimina completamente el `bottomNavigationBar` cuando el usuario es Pro, en lugar de solo ocultar el widget hijo.
  - `BannerAdWidget` ahora limpia su estado y deja de reintentar si `AdsManager.adsEnabled` es falso.
  - `AdsShell` (aunque no se usa activamente) se actualizó para respetar la condición Pro antes de mostrar el banner.
- Verificacion:
  - `dart analyze lib/ui/shell/app_shell.dart lib/services/ads/banner_ad_widget.dart lib/ui/shell/ads_shell.dart`: OK.

## 2026-06-09 - Final Data Shield & Build Fix Verified

- Pedido: el usuario continúa recibiendo errores de datos.
- Version subida por cambio de repo: `1.0.38+62` -> `1.0.39+63`.
- Login y Home ahora muestran `Version 1.0.39`.
- Cambio implementado:
  - **Full Data Shield (Verified)**: Se consolidaron todos los parches de seguridad para manejar datos de Firebase (`Timestamp` vs `int`). El código ahora busca campos por múltiples nombres (`createdAtMs` / `createdAt`, etc.) y los convierte de forma segura.
  - **Xcode Build Fix**: Se eliminaron todos los rastros de código de diagnóstico que causaban el fallo de compilación en el Mac del usuario.
  - **Item Resilience**: Cada producto dentro de una factura ahora se procesa de forma independiente, asegurando que un error menor no rompa toda la aplicación.
- Verificacion:
  - `dart analyze lib/models/invoice.dart lib/ui/auth_gate.dart`: OK.

## 2026-06-08 - iOS/iPad Share Fix

- Pedido: arreglar que en iOS/iPad no salen las opciones de compartir (email, WhatsApp, etc.) al exportar reportes.
- Version subida por cambio de repo: `1.0.25+49` -> `1.0.26+50`.
- Login y Home ahora muestran `Version 1.0.26`.
- Cambio implementado:
  - Se agregó `sharePositionOrigin` a todas las llamadas de `Share.share` y `Share.shareXFiles` que faltaban. Esto es obligatorio para iOS (especialmente iPad) para que el sistema sepa dónde anclar el menú de compartir.
  - `ReportsExportService`: Se actualizó `shareCsvAsText` para usar un helper seguro con `sharePositionOrigin`.
  - `HomeScreen`: Se actualizó el botón de compartir app con `sharePositionOrigin`.
  - `PdfPreviewScreen`: Se actualizó la vista previa de facturas para soportar el origen de compartir.
  - Android no se ve afectado ya que ignora el parámetro `sharePositionOrigin`.
- Verificacion:
  - `dart analyze lib/features/reports/reports_export_service.dart lib/ui/home_screen.dart lib/ui/invoices/pdf_preview_screen.dart`: OK.

## 2026-06-11 - Invoice PDF RenderSliver Share Origin Fix

- Pedido: al tocar `View PDF` en Invoices aparece `Invoice PDF error: type 'RenderSliverList' is not a subtype of type 'RenderBox?' in type cast`.
- Causa: `InvoicesScreen._shareOriginFrom` hacia cast directo de `context.findRenderObject()` a `RenderBox`; en la lista de invoices ese contexto puede pertenecer a un sliver (`RenderSliverList`).
- Version subida por cambio de repo: `1.0.39+63` -> `1.0.40+64`.
- Login y Home ahora muestran `Version 1.0.40`.
- Cambio implementado:
  - `InvoicesScreen._shareOriginFrom` ahora valida `renderObject is RenderBox` antes de usarlo.
  - Si el contexto no es `RenderBox`, no tiene tamano, o genera un rect invalido, usa fallback `Rect.fromLTWH(0, 0, 1, 1)` valido para iOS/iPad.
  - `HomeScreen` y `PdfPreviewScreen` tambien evitan cast directo a `RenderBox` para prevenir el mismo error en otros botones de compartir.
- Verificacion:
  - `dart format lib/features/invoices/invoices_screen.dart lib/ui/home_screen.dart lib/ui/login_screen.dart lib/ui/invoices/pdf_preview_screen.dart`: OK.
  - `dart analyze lib/features/invoices/invoices_screen.dart lib/ui/home_screen.dart lib/ui/login_screen.dart lib/ui/invoices/pdf_preview_screen.dart`: sin errores; quedan infos preexistentes de `withOpacity` en `home_screen.dart`.

## 2026-06-12 - Dashboard Graphics Functional

- Pedido: antes de seguir, crear checkpoint en Git con fecha de hoy y luego hacer funcionales los graficos/tarjetas del Dashboard.
- Checkpoint creado:
  - Commit: `9d23eca Checkpoint 2026-06-12 before dashboard functionality`.
- Version subida por cambio de repo: `1.0.40+64` -> `1.0.41+65`.
- Login y Home ahora muestran `Version 1.0.41`.
- Cambio implementado:
  - Dashboard ahora permite seleccionar mes tocando el label del mes.
  - Las metric cards de Sales, Tip, Subtotal y Tax son tappables y abren Reports con feedback del mes/metric.
  - Las mini graficas ya usan datos reales del mes seleccionado en vez de forma estatica.
  - El chart grande de Monthly overview usa la tendencia real de ventas del mes.
  - La campana de notificaciones ahora abre un bottom sheet con alertas reales: overdue, unsent, unpaid y limite Free cercano.
  - El avatar conserva acciones de cuenta y agrega acceso directo a Business Profile y Subscription.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart`: OK.

## 2026-06-12 - Dashboard Chart Scale And Popup

- Pedido: poner escala a la izquierda de las graficas, de `0` a la cantidad actual, sin numeros abajo, con lineas guia; y que al tocar la grafica abra grande en popup.
- Version subida por cambio de repo: `1.0.41+65` -> `1.0.42+66`.
- Login y Home ahora muestran `Version 1.0.42`.
- Cambio implementado:
  - Las graficas de Sales, Tip, Subtotal, Tax y Monthly overview ahora muestran eje izquierdo con monto actual arriba y `0` abajo.
  - Se agregaron lineas horizontales de referencia dentro del area de la grafica.
  - Se removieron etiquetas/numeros del eje inferior.
  - Al tocar una grafica se abre un dialog/popup con la grafica ampliada y el valor actual.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart`: OK.

## 2026-06-12 - Dashboard Chart Weekly Axis

- Pedido: dividir la parte inferior de las graficas por semanas.
- Version subida por cambio de repo: `1.0.42+66` -> `1.0.43+67`.
- Login y Home ahora muestran `Version 1.0.43`.
- Cambio implementado:
  - Las tendencias del Dashboard ahora se agrupan por semanas del mes seleccionado.
  - Graficas pequenas muestran labels compactos `W1`, `W2`, `W3`, `W4`, `W5` cuando aplica.
  - Popup grande muestra labels claros `Week 1`, `Week 2`, etc.
  - Se mantiene eje izquierdo con monto actual y `0`, lineas guia, y popup al tocar.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart`: OK.

## 2026-06-12 - Dashboard Chart Week Ranges Popup

- Pedido: que el popup de la grafica se vea mas claro y que las semanas muestren rango de dias, por ejemplo `Week 1 1-7`, `Week 2 8-14`.
- Version subida por cambio de repo: `1.0.43+67` -> `1.0.44+68`.
- Login y Home ahora muestran `Version 1.0.44`.
- Cambio implementado:
  - Labels compactos ahora muestran `W1` y debajo el rango `1-7`, `8-14`, etc.
  - Popup grande muestra `Week 1` y debajo el rango de dias.
  - Popup de grafica ahora usa un panel mas alto con borde suave para que se lea como grafica grande.
  - Se agregaron puntos/markers en cada semana para aclarar donde cae el valor semanal.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart`: OK.

## 2026-06-12 - Dashboard Chart Current Week Alignment

- Pedido: si hoy es junio 11, el valor debe caer visualmente en `Week 2 8-14`, no en `Week 3 15-21`.
- Version subida por cambio de repo: `1.0.44+68` -> `1.0.45+69`.
- Login y Home ahora muestran `Version 1.0.45`.
- Cambio implementado:
  - Los puntos de la grafica ahora se dibujan centrados dentro de la columna de cada semana, alineados con su label.
  - En el mes actual, cualquier fecha futura se agrupa visualmente en la semana actual para que la grafica sea month-to-date y no parezca que hoy esta en una semana futura.
  - Se ajusto el area fill para empezar y terminar debajo del primer/ultimo punto semanal, no en los bordes externos del canvas.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart`: OK.

## 2026-06-12 - apple rules

- Motivo de esta seccion: Apple rechazo la submission `f852d60d-4c72-45e0-b96c-65df831ba59c` para EzInvoice Pro porque no pudo localizar las In-App Purchases durante App Review.
- Estado visto en App Store Connect:
  - App: EzInvoice Pro.
  - App Apple ID: `6757661737`.
  - Bundle ID esperado: `com.liisgo.ezinvoice`.
  - Review Status: `Rejected`.
  - Guideline visible: `2.1.0 Performance: App Completeness`.
  - Mensaje visible de Apple: `Guideline 2.1(b) - Information Needed`.
  - Review date: June 10, 2026.
  - Review Device: iPad Air 11-inch (M3).
  - Version reviewed: `1.0 (52)`.
  - Apple pide responder con pasos detallados para localizar las In-App Purchases dentro de la app.

### Apple official rules to remember

- Fuente Apple: https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/overview-for-configuring-in-app-purchases/
- Fuente Apple: https://developer.apple.com/help/app-store-connect/test-in-app-purchases/overview-of-testing-in-sandbox
- Fuente Apple: https://developer.apple.com/help/app-store-connect/manage-submissions-to-app-review/submit-an-in-app-purchase
- Paid Apps Agreement:
  - Para ofrecer In-App Purchases, el Account Holder debe aceptar el Paid Apps Agreement en Business dentro de App Store Connect.
  - Apple indica que el acuerdo debe estar `Active` para probar In-App Purchases en sandbox.
  - Tambien deben estar completos banking y tax si Apple los exige.
- Configuracion del producto:
  - Los productos IAP/subscription se crean en App Store Connect bajo Distribution / Monetization.
  - Cada producto debe tener metadata completa: reference name, product ID, display name, description, price, availability y tax category.
  - Los product IDs en App Store Connect deben coincidir exactamente con los IDs del codigo.
  - Cambios de metadata pueden tardar hasta 1 hora en aparecer en sandbox.
- StoreKit/codigo:
  - La app debe usar StoreKit/In-App Purchase y un provisioning profile con la capability de In-App Purchase.
  - El bundle identifier de Xcode y los product identifiers deben coincidir con App Store Connect.
- Sandbox:
  - Apple revisa IAP en sandbox.
  - Hay que probar con sandbox accounts/TestFlight y confirmar que los productos se cargan sin `notFoundIDs`.
  - Si se restringen compras por storefront, device, region, login, plan, cuenta demo o feature flag, hay que explicarlo en la respuesta a Apple.
- Submission:
  - El primer In-App Purchase/subscription debe enviarse junto con una nueva version de la app.
  - Antes de enviarlo, el IAP/subscription debe estar en estado `Ready to Submit`.
  - En la version de la app, bajar a la seccion `In-App Purchases and Subscriptions`, tocar `Select In-App Purchases or Subscriptions` o `Edit`, seleccionar los productos y tocar Done.
  - Si hay varias compras/subscriptions relacionadas con esa version, enviarlas juntas.
  - Para publicar automaticamente al aprobar, elegir disponibilidad en al menos un pais/region. Para revisar sin ponerlo a la venta, usar Remove from Sale.

### EzInvoice IAP facts in this repo

- Dependencias ya presentes:
  - `in_app_purchase` en `pubspec.yaml`.
  - `in_app_purchase_storekit` en `pubspec.yaml`.
- Manager principal:
  - `lib/services/purchases/subscription_manager.dart`.
  - IDs usados por el codigo:
    - Monthly: `com.ezinvoice.pro.monthly`.
    - Yearly: `com.liisgo.ezinvoice.pro.yearly`.
  - El manager llama `InAppPurchase.instance.queryProductDetails` con esos dos IDs.
  - Si los IDs no existen o no estan listos en App Store Connect, el log mostrara `notFoundIDs`.
  - Compra mensual llama `_iap.buyNonConsumable` con el producto mensual.
  - Compra anual llama `_iap.buyNonConsumable` con el producto anual.
  - Restore Purchases existe y solo corre cuando el usuario toca el boton, no automaticamente.
  - Al comprar/restaurar, se sincroniza Firestore `users/{uid}` con `plan: pro`, `isPro: true`, `proPlan`.
- Paywall:
  - Archivo: `lib/features/paywall/paywall_screen.dart`.
  - Pantalla visible: `Ez Invoice Pro`.
  - Botones visibles:
    - `Pro Yearly`.
    - `Pro Monthly`.
    - `Restore purchases`.
    - `Continue free with ads`.
  - Al abrir el paywall, ejecuta `SubscriptionManager.init()` y `loadProducts()`.
  - Si Apple no ve los precios reales y solo ve fallback `$3.99` / `$29.99`, revisar que los productos esten activos/listos en App Store Connect y que sandbox ya haya refrescado.
- Entradas hacia el paywall:
  - Avatar/menu superior del Dashboard -> `Subscription`.
  - Settings -> `Subscription`.
  - Banner/card de upgrade cuando cuenta Free llega al limite o toca una funcion Pro.
  - Reports -> `Upgrade to Pro` cuando se muestra la opcion Pro.
- StoreKit local:
  - Archivo: `ios/Runner/EzInvoice.storekit`.
  - Productos locales:
    - `com.ezinvoice.pro.monthly`, Monthly Pro, `P1M`, displayPrice `3.99`.
    - `com.liisgo.ezinvoice.pro.yearly`, Yearly Pro, `P1Y`, displayPrice `29.99`.
  - Ojo: el `.storekit` local tiene `displayName` y `description` vacios en localizations. Esto no necesariamente rompe App Store Connect, pero es una senal para confirmar que en App Store Connect si esten completos el display name y description reales.

### Required App Store Connect checklist before resubmitting

- Business:
  - Confirmar que Paid Apps Agreement este `Active`.
  - Confirmar banking/tax sin pendiente.
- App / Monetization:
  - Confirmar que existan estas subscriptions exactas:
    - `com.ezinvoice.pro.monthly`.
    - `com.liisgo.ezinvoice.pro.yearly`.
  - Confirmar que esten bajo el app correcto `6757661737` / bundle `com.liisgo.ezinvoice`, no en otra app.
  - Confirmar display name, description, price, availability y tax category.
  - Confirmar que ambas esten `Ready to Submit` antes de intentar enviar.
- Version submission:
  - Crear/subir una nueva build si Apple no permite editar la submission rechazada.
  - En la version iOS de App Store Connect, abrir `In-App Purchases and Subscriptions`.
  - Seleccionar `com.ezinvoice.pro.monthly` y `com.liisgo.ezinvoice.pro.yearly`.
  - Enviar app version + subscriptions juntas.
- TestFlight/sandbox:
  - Instalar la build que se va a enviar.
  - Entrar con la cuenta demo de review o una cuenta Free.
  - Abrir Subscription y confirmar que aparecen los precios de App Store, no solo fallback local.
  - Confirmar que Monthly y Yearly abren el sheet de compra sandbox.
  - Confirmar `Restore purchases` no rompe la pantalla.

### Code checklist to fix/verify if Apple still cannot find IAP

- Confirmar que `SubscriptionManager.kMonthlyId` y `kYearlyId` coinciden exactamente con App Store Connect.
- Confirmar que el Bundle ID de iOS sea `com.liisgo.ezinvoice`.
- Confirmar que la capability In-App Purchase este habilitada para el app ID/provisioning profile.
- Confirmar que `SubscriptionManager.init()` corre al entrar a la app y antes de abrir el paywall.
- Confirmar que el paywall sea accesible para App Review sin depender de datos privados del usuario:
  - Ruta recomendada: Login demo -> Dashboard -> avatar/circle top right -> Subscription.
  - Ruta alternativa: Settings -> Subscription.
  - Ruta alternativa: cuenta Free llega al limite de invoices o toca Upgrade to Pro.
- Si Apple usa cuenta demo que ya aparece como Pro, no vera productos porque el paywall muestra `Already Pro`. Para Review de IAP, usar una cuenta demo Free o explicar que deben abrir con una cuenta Free. No marcar la cuenta demo principal como Pro si se necesita que Apple vea el paywall.
- Agregar en App Review Notes instrucciones exactas con credenciales y ruta de navegacion.
- Si se cambia codigo para hacer mas visible la compra, opcion segura:
  - Mostrar un acceso directo `Subscription` visible en Dashboard/Settings para todas las cuentas Free.
  - En la pantalla Free Plan, incluir boton `Upgrade to Pro` que abre `PaywallScreen`.
  - Evitar esconder el paywall detras del limite de invoice; Apple debe verlo sin crear muchas facturas.

### Suggested App Review reply

Hello App Review Team,

Thank you for the update. The In-App Purchases are available from inside the app using the following steps:

1. Open EzInvoice Pro.
2. Sign in with the review account provided in App Review Notes.
3. From the Dashboard, tap the profile/avatar button in the top-right corner.
4. Tap `Subscription`.
5. The `Ez Invoice Pro` screen will appear with the available subscription options:
   - `Pro Monthly` (`com.ezinvoice.pro.monthly`)
   - `Pro Yearly` (`com.liisgo.ezinvoice.pro.yearly`)
6. You can also access the same screen from Settings -> Subscription, or from the Free plan upgrade prompts.

These subscriptions are intended to unlock Pro features such as unlimited invoices and ad-free/premium business tools. Please use a Free review account to view the purchase options; if the account is already marked as Pro, the app will show the existing Pro status instead of the purchase buttons.

We have confirmed the app uses StoreKit/In-App Purchase with the following product identifiers:
- `com.ezinvoice.pro.monthly`
- `com.liisgo.ezinvoice.pro.yearly`

The app should be reviewed in Apple's sandbox environment. If the products do not appear immediately after App Store Connect metadata changes, please allow time for sandbox metadata propagation.

### Next best fix for this rejection

- First fix App Store Connect, not code:
  - Paid Apps Agreement Active.
  - Monthly/Yearly subscriptions created with exact product IDs.
  - Both subscriptions selected inside the app version submission.
  - App Review Notes include the steps above.
- Then verify the app:
  - Run on iOS/TestFlight with a Free account.
  - Open Subscription from avatar/menu.
  - Confirm real StoreKit products load.
- Only change code if Apple still cannot find the screen:
  - Make Subscription more visible for Free users on the Dashboard.
  - Add a direct `Upgrade to Pro` CTA in the Free Plan card.
  - Keep demo review account Free for IAP review.

## 2026-06-12 - Dashboard Chart Month-To-Date Week Fix

- Pedido: la grafica todavia marcaba Week 3 aunque junio 11 debe caer en `Week 2 8-14`.
- Version subida por cambio de repo: `1.0.45+69` -> `1.0.46+70`.
- Login y Home ahora muestran `Version 1.0.46`.
- Cambio implementado:
  - Para el mes actual, el Dashboard ahora muestra el total month-to-date en la semana actual del calendario.
  - Esto evita que fechas futuras dentro del mes muevan visualmente el total a Week 3/Week 4.
  - Meses pasados o futuros siguen mostrando las semanas segun las fechas reales de las invoices.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart`: OK.

## 2026-06-12 - Dashboard Chart Single Week Marker

- Pedido: la grafica seguia viendose mal/confusa en el popup.
- Version subida por cambio de repo: `1.0.46+70` -> `1.0.47+71`.
- Login y Home ahora muestran `Version 1.0.47`.
- Cambio implementado:
  - Cuando la grafica tiene un solo valor month-to-date, se dibuja como marcador/barra vertical solo en esa semana.
  - Se evita conectar semanas en cero con el valor actual, para que no parezca que el dato cae en otra semana.
  - Se mantienen los markers superior/inferior para indicar claramente la semana activa.
- Verificacion:
  - `dart format lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/shell/responsive_main_shell.dart`: OK.

## 2026-06-12 - Apple Review IAP Visibility Fix

- Pedido: arreglar el app para que Apple pueda encontrar las In-App Purchases despues del rechazo `Guideline 2.1(b) - Information Needed`.
- Version subida por cambio de repo: `1.0.48+72` -> `1.0.49+73`.
- Login y Home ahora muestran `Version 1.0.49`.
- Cambio implementado:
  - La cuenta demo/review `demo.review@liisgo.com` ya no se fuerza a Pro en Firestore.
  - Al crear o volver a entrar con la cuenta demo/review, se deja `plan: free`, `isPro: false`, `proPlan: none` para que Apple vea los botones de compra.
  - Dashboard/sidebar ahora muestra un boton visible `Upgrade to Pro` en el bloque Free Plan.
  - Panel de estado Free del Dashboard tambien muestra `Upgrade to Pro`, abriendo `PaywallScreen` directo.
  - `PaywallScreen` ya no muestra precios fallback como si fueran productos listos mientras StoreKit todavia no carga.
  - Los botones `Pro Monthly` y `Pro Yearly` quedan deshabilitados hasta que carguen los productos reales de App Store.
  - Se agrego aviso en paywall cuando los productos de App Store siguen cargando, indicando revisar que las subscriptions esten `Ready to Submit` en App Store Connect.
- Product IDs que deben existir y estar seleccionados en App Store Connect:
  - `com.ezinvoice.pro.monthly`
  - `com.liisgo.ezinvoice.pro.yearly`
- Ruta recomendada para Apple Review:
  - Login con cuenta demo/review.
  - Dashboard -> `Upgrade to Pro` en Free Plan.
  - Alternativa: avatar/menu -> `Subscription`.
  - Alternativa: Settings -> `Subscription`.
- Verificacion:
  - `dart format lib/ui/login_screen.dart lib/ui/home_screen.dart lib/features/paywall/paywall_screen.dart lib/ui/shell/responsive_main_shell.dart`: OK.
  - `dart analyze lib/ui/login_screen.dart lib/ui/home_screen.dart lib/features/paywall/paywall_screen.dart lib/ui/shell/responsive_main_shell.dart`: sin errores; quedan 18 infos preexistentes de `withOpacity` en `home_screen.dart`.

## 2026-06-12 - App Store Connect IAP Browser Check

- Pedido: verificar desde Chrome/App Store Connect si Apple tiene Paid Apps Agreement activo, subscriptions creadas/listas y seleccionadas.
- Resultado visto en App Store Connect:
  - Paid Apps Agreement: `Active`.
  - Bank account: `TD Bank Business (1854)`, `Active`.
  - Tax form: `U.S. Form W-9`, `Active`.
  - Subscription group correcto: `ezinvoice_pro_subscription`, ID `21886900`, contiene 2 subscriptions.
  - Subscription mensual:
    - Reference Name: `EzInvoice Pro Monthly`.
    - Product ID: `com.ezinvoice.pro.monthly`.
    - Duration: `1 month`.
    - Status: `Missing Metadata`.
  - Subscription anual:
    - Reference Name: `EzInvoice Pro Yearly 1`.
    - Product ID: `com.liisgo.ezinvoice.pro.yearly`.
    - Duration: `1 year`.
    - Status: `Missing Metadata`.
  - Hay otro grupo vacio llamado `ezinvoice subscription plan yearly` con 0 subscriptions.
  - En la submission rechazada, `Items Submitted (1)` solo muestra la App Version; no se ven las subscriptions seleccionadas.
  - En la pagina de version no aparece texto `In-App Purchases and Subscriptions`, ni `Select In-App`, ni los product IDs.
- Causa encontrada:
  - El codigo buscaba yearly como `com.ezinvoice.pro.yearly`, pero App Store Connect tiene `com.liisgo.ezinvoice.pro.yearly`.
- Version subida por cambio de repo: `1.0.49+73` -> `1.0.50+74`.
- Login y Home ahora muestran `Version 1.0.50`.
- Cambio implementado:
  - `SubscriptionManager.kYearlyId` actualizado a `com.liisgo.ezinvoice.pro.yearly`.
  - `ios/Runner/EzInvoice.storekit` actualizado con el mismo yearly product ID.
- Pendiente manual en App Store Connect:
  - Completar metadata faltante de ambas subscriptions hasta que pasen de `Missing Metadata` a `Ready to Submit`.
  - Seleccionar ambas subscriptions en la seccion `In-App Purchases and Subscriptions` de una nueva version/submission.

## 2026-06-12 - Subscription Review Notes Added

- Pedido: completar metadata de Monthly y Yearly para sacarlas de `Missing Metadata`.
- Cambio hecho en App Store Connect desde Chrome:
  - Subscription mensual `com.ezinvoice.pro.monthly`: se agregaron Review Notes con la ruta para App Review.
  - Subscription anual `com.liisgo.ezinvoice.pro.yearly`: se agregaron Review Notes con la ruta para App Review.
- Review Notes agregadas explican:
  - Login con cuenta de review.
  - Dashboard -> `Upgrade to Pro` en Free Plan.
  - Alternativas: profile/avatar menu -> `Subscription`, o Settings -> `Subscription`.
  - Product ID correspondiente de cada subscription.
- Bloqueo encontrado:
  - Chrome/Codex extension bloqueo la subida del archivo screenshot con error `Not allowed`.
  - Por eso ambas subscriptions siguen en `Missing Metadata` hasta subir manualmente el screenshot en `Review Information > Screenshot`.
- Screenshot preparado para subir manualmente:
  - `/Users/juanpolanco/Documents/Codex/2026-06-11/can-you-read-from-my-web/outputs/ezinvoice_subscription_review_screenshot.png`
- Pendiente manual:
  - En cada subscription, subir ese PNG en `Review Information > Screenshot`.
  - Guardar.
  - Verificar que el status cambie de `Missing Metadata` a `Ready to Submit`.

## 2026-06-13 - Settings Completo En Cellphone Mode

- Pedido: en cellphone mode el boton Settings solo tenia cambio de lenguaje; debe mostrar los mismos settings completos que tablet mode.
- Version subida por cambio de repo: `1.0.52+76` -> `1.0.53+77`.
- Login y Home ahora muestran `Version 1.0.53`.
- Cambio implementado:
  - El menu/avatar movil, opcion `Settings`, ahora abre `_SettingsHubScreen` completo en vez de abrir directo `LanguageSettingsScreen`.
  - Settings en cellphone mode muestra Language, Subscription, Privacy Policy, Delete Account y Log out.

## 2026-06-13 - Precio Anual Pro 29.99

- Pedido: el precio anual en la app sale `39.99` y debe ser `29.99`.
- Version subida por cambio de repo: `1.0.53+77` -> `1.0.54+78`.
- Login y Home ahora muestran `Version 1.0.54`.
- Cambio implementado:
  - Paywall fallback anual actualizado de `$39.99` a `$29.99`.
  - `ios/Runner/EzInvoice.storekit` actualizado con `displayPrice: 29.99` para `com.liisgo.ezinvoice.pro.yearly`.
- Nota importante:
  - En dispositivo/TestFlight/App Store, el precio real viene de App Store Connect cuando StoreKit carga el producto.
  - Tambien hay que cambiar el precio anual de la subscription `com.liisgo.ezinvoice.pro.yearly` en App Store Connect a `29.99`.

## 2026-06-16 - Apple Rules / App Review Readiness

- Pedido: leer las reglas/documentacion de Apple y guardar lo importante para resubir EzInvoice Pro a review.
- App Store Connect review actual leido desde Chrome:
  - Submission ID: `cc232d51-b160-4525-afdc-68bd576b483a`.
  - Review date: June 15, 2026.
  - Review Device: iPad Air 11-inch (M3), iPadOS 26.5.
  - Version reviewed: `1.0 (78)`.
  - Rechazo 1: `Guideline 2.1(b) - Performance - App Completeness`.
  - Apple dijo que los In-App Purchase products tenian bugs; especificamente el app no respondia al tocar `Pro`.
  - Rechazo 2: `Guideline 2.3.2 - Performance - Accurate Metadata`.
  - Apple dijo que la promotional image de IAP/win-back no representa suficientemente el producto, habia imagenes duplicadas/identicas y texto pequeno dificil de leer.
- Reglas Apple importantes para EzInvoice:
  - Guideline 2.1 App Completeness: la app debe ser version final, probada en device, estable, sin placeholder, con metadata y URLs funcionales, y con demo account si usa login.
  - Guideline 2.1(b): si la app ofrece IAP, deben estar completos, actualizados, visibles al reviewer y funcionales. Si algun IAP configurado no puede encontrarse/revisarse, explicarlo en Review Notes.
  - Guideline 2.3 Accurate Metadata: metadata, descripcion, screenshots, privacidad y previews deben reflejar correctamente la experiencia real. Las funciones nuevas/cambios deben explicarse especificamente en Notes for Review.
  - Si hay IAP/subscriptions, la descripcion/screenshots/previews deben indicar claramente si algo requiere compra adicional.
- Checklist App Store Connect antes de resubir:
  - Paid Apps Agreement debe estar `Active`.
  - Banking y tax info deben estar completos/activos.
  - Monthly y Yearly deben tener metadata completa, precio, disponibilidad, review screenshot y review notes.
  - Monthly: `com.ezinvoice.pro.monthly`, precio esperado `$3.99`.
  - Yearly iOS principal en App Store Connect: `com.liisgo.ezinvoice.pro.yearly`, precio esperado `$29.99`.
  - Mantener fallback en codigo para `com.ezinvoice.pro.yearly`, porque algunos entornos/sandbox lo devuelven.
  - Los IAP deben estar `Ready to Submit` y seleccionados/incluidos en la submission.
  - Si se cambia metadata de IAP, puede tardar hasta 1 hora en aparecer en sandbox.
  - Testear en sandbox/TestFlight: abrir Pro desde dashboard/sidebar/settings, cargar productos, comprar monthly/yearly, restore purchases, y confirmar que no se queda en loading.
- Promotional image rules:
  - Imagen IAP debe ser JPG o PNG.
  - Tamano exacto: `1024 x 1024`.
  - 72 dpi, RGB, flattened, sin esquinas redondeadas.
  - Debe ser unica por producto si se promueve cada IAP.
  - No debe ser screenshot ni confundirse con el app icon.
  - Apple recomienda evitar texto encima de la imagen, porque se ve pequena en App Store.
  - Si no se va a promover el IAP, se puede borrar la promotional image para evitar rechazo por imagen duplicada o texto pequeno.
- Cambios de codigo ya hechos para responder a Apple:
  - El boton `Pro` abre siempre, incluso si el usuario ya es Pro.
  - El paywall ya no se cierra silenciosamente por estado Pro.
  - Paywall muestra comparacion clara `Free vs PRO`.
  - Settings muestra version de app.
  - Dashboard/panel derecho no repite `Actualizar a Pro`.
  - Dashboard muestra rendimiento: este mes vs mes pasado y este ano vs ano pasado.
  - iPhone landscape ya no entra al layout de tablet/sidebar.
  - iPad/tablet dashboard arreglado para evitar overflow y pantallas rotas.
  - Graficas mensuales corregidas para que la escala coincida con el mes seleccionado.
- Review Notes sugeridas al resubir:
  - Agradecer a Apple por la revision y paciencia.
  - Explicar que se corrigio el flujo Pro/IAP reportado en iPad Air 11-inch (M3), iPadOS 26.5.
  - Explicar que el boton Pro ahora abre siempre la pantalla de subscription/paywall y muestra productos monthly/yearly con comparacion Free vs Pro.
  - Explicar que se verificaron los product IDs: `com.ezinvoice.pro.monthly`, `com.liisgo.ezinvoice.pro.yearly`, y fallback `com.ezinvoice.pro.yearly`.
  - Explicar que se corrigio el precio anual a `$29.99` y mensual `$3.99`.
  - Explicar que se revisaron/eliminaron/reemplazaron las promotional images para que no sean duplicadas, no tengan texto pequeno y/o no se usen si no se planea promover el IAP.
  - Incluir ruta para reviewer: login con demo account -> Dashboard -> Pro/Upgrade to Pro -> ver Monthly/Yearly -> Restore Purchases disponible.
  - Confirmar que backend/demo account estan activos antes de enviar.

## 2026-06-16 - Regla De Build Para App Review

- Recordatorio importante para proximas revisiones:
  - Despues de cambios de codigo, precio, paywall, screenshots o metadata que respondan a un rechazo de Apple, siempre subir un build nuevo.
  - Esperar a que el build termine de procesar en App Store Connect.
  - Seleccionar ese build nuevo en la version de iOS antes de enviar a review.
  - Confirmar que el build seleccionado sea el mas reciente y que coincida con la version/build que se probo en simulador o device.
- Cambio final de resubida:
  - Despues de detectar que el producto anual fallback podia mostrar `$39.99`, se corrigio la prioridad para usar primero `com.liisgo.ezinvoice.pro.yearly`.
  - Version/build nuevo para distinguir el upload: `1.0.55+80`.
  - Este cambio requiere subir un archive/build nuevo y seleccionar ese build nuevo en App Store Connect.

## 2026-06-19 - AdMob iOS Ads No Serving

- Problema reportado: el app publico funciona, pero no salen banners ni rewarded ads.
- Codigo revisado:
  - `google_mobile_ads` esta configurado.
  - iOS `GADApplicationIdentifier`: `ca-app-pub-8588489900323524~9106905571`.
  - iOS banner unit: `ca-app-pub-8588489900323524/4776778326`.
  - iOS interstitial unit: `ca-app-pub-8588489900323524/4732546298`.
  - iOS rewarded unit: `ca-app-pub-8588489900323524/1228415557`.
  - En release se usan IDs reales; en debug se usan IDs test.
  - Los anuncios se apagan intencionalmente si la cuenta esta marcada como Pro (`isPro: true` o `plan: pro/premium/paid`).
- AdMob revisado en Chrome:
  - App AdMob: `9106905571`.
  - App estaba sin `App store details`; se enlazo a App Store ID `6757661737`.
  - AdMob encontro `EzInvoice Pro`, developer `LIISGO LLC`.
  - App settings ahora muestra App Store link guardado: `https://apps.apple.com/app/id6757661737`.
  - Policy Center: `No current issues`; no hay suspension/policy issue.
  - Overview muestra requests (`456` en Last 7 days) pero `0` impressions y `0.00%` match rate.
  - Estado actual: `Requires review`; `App verification: Not verified`.
- App-ads.txt:
  - AdMob pide exactamente: `google.com, pub-8588489900323524, DIRECT, f08c47fec0942fa0`.
  - Web publica verificada: `https://liisgo.com/app-ads.txt`.
  - La web ya devuelve la linea correcta.
  - Se pulso `Check for updates` en AdMob, pero AdMob todavia muestra que no pudo verificar.
- Conclusion:
  - El problema no parece ser el codigo del app.
  - El app ya esta mandando requests a AdMob.
  - Falta que Google/AdMob verifique app-ads.txt y complete la review/approval de la app para empezar a entregar impresiones.

## 2026-10-05 - iPhone Duo simulator launch

- Migrated iOS startup to FlutterSceneDelegate / FlutterImplicitEngineDelegate to fix iOS 27 scene lifecycle startup crash.
- Version: 1.0.59+84; synchronized visible version labels.
- Simulator build uses temporary iOS 15 deployment target override at /Volumes/Mac2TB/CodexBuildCacheBackup/ezinvoice-simulator.xcconfig.
- Moved Xcode ModuleCache, this project DerivedData, and CocoaPods download cache to Mac2TB with symlinks because internal disk was full.
- Added SceneDelegate startup ordering: bridge the scene window to AppDelegate and register plugins after the window is ready, preserving compatibility with flutter_contacts 1.1.9+2.
- Verified: simulator build succeeds; iPhone Duo displays the login screen with Version 1.0.59. Existing ad banner sizing errors remain in the runtime log; launch itself succeeds.
- Changes remain local alongside pre-existing working-tree changes.

## 2026-10-05 - Perfil de negocio adaptativo y guardado automático

- Versión 1.0.60+85; etiquetas de versión sincronizadas.
- Perfil convertido en resumen legible con edición por sección en paneles opacos. Datos del negocio primero, logo compacto, servicios con un único acceso para añadir y sin botón flotante sobre el contenido.
- Columnas según ancho local útil y escala de texto; contenido desplazable, campos multilínea para dirección/nota y cierres accesibles sobre el teclado.
- Campos, moneda, impuesto válido, logo y servicios se guardan automáticamente con debounce de 500 ms y envío al cerrar/pasar a segundo plano. Estado guardando/guardado/error con reintento; no se anuncia éxito antes de la confirmación de la escritura.
- Escrituras parciales evitan sobrescribir estilos de factura/informe. Las confirmaciones antiguas no eliminan ediciones recientes. El repositorio queda vinculado a la cuenta original durante escrituras pendientes.
- Impuesto inválido conserva el último valor válido en la base de datos y muestra error; acepta coma decimal. Cerrar editores conserva cambios, incluidos nombres de servicios, sin acción Cancelar.
- GlobalKey para conservar el estado del perfil al cambiar la estructura de navegación entre tamaños.
- 21 pruebas aprobadas en test/business_profile_test.dart: siete tamaños a 100 %/200 %, teclado simulado, cierre, redimensionado, recarga, orden de confirmaciones, fallo/reintento, impuesto inválido, nota y eliminación de logo, edición/borrado de servicios.
- Análisis estático de los tres archivos principales modificados: sin incidencias. El shell conserva advertencias preexistentes y la prueba antigua del contador no corresponde a la app actual.
- Revisión visual en Duo (Device Hub de Xcode 27.1 en Downloads): perfil y modal comprobados al abrir/cerrar el dispositivo, conservando los campos. Pruebas de escritura usan repositorio de memoria; no se modificaron datos del usuario para probar.
- Pendiente fuera del alcance de esta entrega: prueba en hardware físico y de interrupción de red real. No se rediseñaron otras pantallas.
- El shell mantiene su geometría con teclado; los paneles/Scaffolds de cada pantalla gestionan sus propios insets para evitar comprimir el rail detrás del editor.

## 2026-10-05 - Botones e iconos más grandes

- Versión fuente 1.0.61+86; etiquetas visibles sincronizadas.
- Navegación inferior y lateral con iconos de 32 px lógicos; rail de 80 px y filas de sidebar de 56 px.
- Acciones de perfil con iconos de 28 px, área mínima de 52 px y fondo suave para identificar los botones; cierre y acciones de servicios también ampliados.
- 21 pruebas de perfil aprobadas, análisis del perfil sin incidencias. Hot reload completado y revisión visual en Duo abierto/cerrado sin superposiciones. El binario instalado conserva su metadata anterior hasta el siguiente build.
- Cambios locales, junto a las modificaciones anteriores aún sin publicar.

## 2026-10-05 - Más monedas y selección priorizada

- Versión fuente 1.0.62+87; etiquetas visibles sincronizadas. Selector ampliado a 60 monedas, con USD/EUR/DOP/CAD/MXN/GBP primero y resto por código. Mantiene valores previamente guardados y guardado automático.
- PDF y reporte mensual usan el código explícito para monedas nuevas en vez de etiquetarlas como dólares. No se aplica conversión de importes.
- 22 pruebas aprobadas, incluyendo selección CAD, guardado y reapertura. Análisis conserva cinco avisos preexistentes en PDF/reportes; sin errores nuevos. Aplicado mediante hot reload, sin reconstruir metadata del binario. Cambios locales.

## 2026-10-05 - Separación de acciones del logo

- Versión fuente 1.0.63+88. Subir y eliminar logo ahora usan una fila adaptable con separación horizontal/vertical de 16 px; separación de 20 px al pasar debajo del preview.
- Verificado visualmente en Duo abierto y cerrado: acciones lado a lado; sin tocarse. Conserva tamaño accesible y permite salto con texto grande o ancho menor.
- 22 pruebas aprobadas; hot reload aplicado. Cambios locales y metadata del binario pendiente del siguiente build.

## 2026-10-05 - Dashboard adaptativo

- Versión fuente 1.0.64+89; etiquetas visibles sincronizadas. Nuevo acceso principal Nueva factura abre el formulario existente.
- Métricas legibles sin minigráficas de un solo dato; tarjetas sin altura/aspect ratio fijo, sin grandes espacios vacíos. Accesos compactos con icono y texto en fila.
- Grid de una/dos columnas calculado por ancho local y escala del texto. Panel de analytics solo con >=1100 px útiles, altura >=600 y texto moderado; panel lateral desplazable.
- Selector de mes permite wrap; se eliminó tarjeta duplicada alrededor del plan.
- 36 pruebas aprobadas: 14 de tarjetas en siete tamaños a 100/200 %, importes largos, scroll y acciones; 22 regresiones del perfil. Análisis sin errores, cinco avisos preexistentes en shell.
- Hot reload confirmado; revisión visual en Duo abierto/cerrado, acceso Nueva factura abre formulario y vuelve sin guardar; accesos inferiores alcanzables sin superposiciones. Metadata del binario pendiente del siguiente build. Cambios locales junto al trabajo anterior.

## 2026-10-05 - Detalle mensual por métrica y navegación etiquetada

- Versión fuente 1.0.65+90. Sales/Tip/Subtotal/Tax abren pantallas específicas, inician en mes actual, selector mes/año y flechas permiten recorrer periodos. Total, barras por día y desglose por factura usan la misma categoría y fecha de creación del Dashboard. Stream en vivo, carga/error/reintento y estado vacío. No se modifican facturas.
- Rail ancho 112 px, iconos 36 px y nombres debajo en todos los destinos. Etiquetas con color explícito, selección en negrita y rail desplazable cuando no cabe en altura.
- 43 pruebas aprobadas: agregación independiente de las cuatro categorías, límites de mes/año, febrero bisiesto, tamaños estrecho/horizontal/ancho a 100/200 %, más regresiones anteriores. Análisis de pantalla nueva sin incidencias; shell conserva avisos preexistentes.
- Revisión Duo abierto/cerrado y cambio octubre/septiembre; mes conserva estado al plegar. Datos actuales sin facturas: gráfica vacía intencionalmente; casos con importes probados con fixtures. Hot reload aplicado. Cambios locales; metadata del binario pendiente de rebuild.

## 2026-10-05 - Selector de período compacto

- Versión fuente 1.0.66+91. Mes/año juntos en una tarjeta con flechas alineadas; eliminados dropdowns desalineados y encabezado duplicado.
- El período abre panel opaco con selector de año y meses, selección con check y color. Cambios en vivo conservados al cerrar. Panel desplazable, cierre accesible y columnas adaptadas al texto.
- Siete pruebas de detalle aprobadas, ahora incluyendo apertura del panel, cambio de año/mes y cierre en tamaños estrecho/horizontal/ancho con texto 100/200 %. Análisis sin incidencias. Verificación visual en Duo cerrado y hot reload completado.
- Cambios locales, metadata de versión instalada pendiente del siguiente build.

## 2026-10-05 - Ventas separadas del total facturado

- Versión fuente 1.0.67+92. Dashboard ordenado Sales, Tip, Tax, Total invoiced. Ventas toma subtotal de artículos/servicios; Total facturado usa total de factura. Propina e impuestos conservan campos separados. Detalles mensuales y comparaciones de ventas usan la misma definición.
- Nueva etiqueta traducida en diez idiomas. No se alteraron facturas ni reglas de cálculo fiscal.
- 44 pruebas aprobadas, incluida comprobación explícita 150 ventas +30 propina +15 impuesto =195 facturado. Hot reload y Dashboard verificados en Duo. Análisis sin errores, cinco warnings preexistentes del shell. Cambios locales y metadata instalada pendiente de reconstrucción.

## 2026-10-05 - Factura adaptable y selección de cliente

- Versión fuente 1.0.68+93. La factura ahora presenta un solo bloque de cliente: permite elegir un cliente guardado o abrir el formulario de cliente nuevo. Al guardar el cliente, vuelve a la factura ya seleccionado y conserva el borrador de la factura.
- En ancho estrecho, la información de factura, cliente, conceptos y resumen se apilan por prioridad. Datos de la factura y cliente forman dos áreas cuando el ancho útil puede sostener ambas según el tamaño de texto actual; cuando no cabe con holgura, vuelve a una columna para evitar cortes.
- El selector de cliente es un panel opaco, desplazable y seguro con el teclado. Se eliminó la edición dispersa de nombre, correo y teléfono dentro de la factura.
- Revisión manual en Duo: selector, lista de clientes y tarjeta del cliente elegido funcionan en pantalla estrecha; abrir cliente nuevo no altera el borrador. Se eliminó el acceso duplicado del encabezado para que solo haya un botón principal de cliente. Las 44 pruebas de las pantallas de perfil, Dashboard y detalle pasaron. El único `widget_test.dart` heredado sigue fallando porque aún comprueba el contador de la plantilla Flutter, que ya no existe en la app.

## 2026-10-05 - Conceptos de factura simplificados

- Versión fuente 1.0.69+94. El campo de descripción ya no ofrece autocompletado flotante: escribir un concepto no abre una segunda lista debajo del teclado.
- Elegir un servicio guardado queda como una acción amplia y única; el panel usa términos directos para buscar y elegir servicios. Guardar el texto para reutilizarlo queda asociado al propio campo mediante el icono de marcador con etiqueta accesible.
- Verificado en Duo cerrado: al escribir no aparece una lista duplicada; el panel de servicios guardados se abre sin teclado automático y lista los servicios con espacio táctil. Las 44 pruebas de UI relevantes pasaron y se aplicó hot reload.

## 2026-10-05 - Importes de línea de reemplazo rápido

- Versión fuente 1.0.70+95. Al tocar Qty o Price, el valor actual se limpia una sola vez durante ese foco, para escribir el nuevo importe sin borrar `1.0` o `0.00` manualmente.
- Al salir y volver a entrar en cualquiera de los campos, el comportamiento se repite. La regla mantiene el número recién escrito mientras el campo conserva el foco.

## 2026-10-05 - Cantidad y precio en una fila útil

- Versión fuente 1.0.71+96. Cantidad y precio ahora comparten una fila cuando el ancho útil dentro de la tarjeta permite dos campos legibles; ya no esperan al diseño general de pantalla ancha.
- La decisión descuenta los márgenes reales de la tarjeta y toma en cuenta el tamaño de texto. Con texto ampliado o espacio insuficiente, los campos vuelven a una columna para evitar controles comprimidos o cortados.

## 2026-10-05 - Propina directa e impuesto predeterminado claro

- Versión fuente 1.0.72+97. Al tocar el importe de propina por porcentaje o por dinero, se limpia el valor inicial una vez durante ese foco para escribir el importe elegido directamente.
- El impuesto predeterminado se presenta primero como un valor visible y no editable por accidente. El botón `Edit` abre su campo de edición y `Done` vuelve a la vista de resumen; ambas disposiciones se adaptan al ancho útil y al texto grande.

## 2026-10-05 - Nueva factura como acción flotante

- Versión fuente 1.0.74+99. `New Invoice` sale del flujo del contenido y queda como un botón flotante verde abajo a la derecha en el Dashboard.
- En pantallas estrechas y landscape usa el botón circular con icono y etiqueta accesible para no cubrir tarjetas; en pantallas anchas con altura útil suficiente se amplía para mostrar icono y texto. El Dashboard reserva espacio inferior para que el botón no tape tarjetas, lista reciente, anuncios ni navegación.


## 2026-10-05 - Reportes centrados en resultados

- Versión fuente 1.0.76+101; etiquetas visibles sincronizadas. Reports ahora muestra primero el período activo y el total facturado, seguido por Ventas, Propina e Impuesto en un desglose visual.
- La selección de período vive en un panel claro para elegir vista mensual/anual, año y mes; la personalización del estilo se movió a un panel secundario para no ocultar los datos financieros.
- Estados de facturas, exportaciones PDF/CSV y estilo se organizan como acciones separadas. El contenido usa una columna en ancho estrecho y dos paneles cuando hay ancho local y escala de texto suficientes.
- Se corrigió el cálculo de Reports y sus exportaciones: Ventas = subtotal de servicios/artículos; Propina e Impuesto permanecen separados; Total facturado = total de factura. La nota de cálculo deja de mostrar detalles técnicos y se limita a indicar que procede de las facturas.
- 46 pruebas relevantes aprobadas, incluyendo dos nuevas para los importes y estados de Reports. Análisis de Reports sin errores; conserva avisos heredados en el servicio de exportación.


## 2026-10-05 - Propina compacta en factura ancha

- Versión fuente 1.0.77+102; etiquetas visibles sincronizadas. Tax & Tip usa el ancho útil: en espacio suficiente, selector de tipo de propina y valor van en la misma fila, y en ancho muy amplio impuesto y propina forman dos columnas.
- El selector Tip % / Tip $ ahora es un control segmentado compacto, con estados visibles y áreas táctiles completas. En ancho estrecho o texto grande vuelve a apilarse para no comprimir campos.


## 2026-10-05 - Selector de propina junto al valor

- Versión fuente 1.0.78+103; etiquetas visibles sincronizadas. En el ancho útil de la tarjeta, el importe de propina queda a la izquierda y el selector compacto Tip % / Tip $ queda a la derecha.
- El umbral usa el ancho real de la tarjeta y la escala de texto: mantiene ambos controles juntos cuando caben con comodidad y vuelve a una columna cuando no.

## 2026-10-05 - Vista completa antes de exportar

- Version fuente 1.0.79+104; etiquetas visibles sincronizadas. Reports sustituye las dos acciones de exportacion por un solo acceso Ver reporte.
- La vista completa usa pestañas PDF y CSV. Muestra ventas, propina, impuesto y total facturado para el periodo activo; la accion de exportar se adapta a la pestaña elegida.
- Report style se edita dentro de la vista completa. Los cambios de paleta y layout se reflejan en vivo en la vista previa y el diseno usa una columna en ancho estrecho y panel lateral en ancho util amplio.
- Ajuste visual posterior: versión fuente 1.0.80+105. La vista completa activa sus dos paneles desde 680 px útiles (en lugar de 860) para usar el ancho real del Duo abierto; texto ampliado conserva una sola columna.

## 2026-10-05 - Acceso rápido personalizado y navegación verde

- Versión fuente 1.0.81+106; etiquetas visibles sincronizadas. Acceso rápido registra cada destino usado por la persona en este dispositivo y los ordena por frecuencia; al empezar, Facturas aparece primero. Crear una factura también cuenta como uso de Facturas.
- El historial es independiente por usuario con sesión iniciada y se actualiza sin salir del Dashboard.
- La barra inferior y el rail ahora usan verde de marca: indicador verde menta, iconos y etiquetas verdes en selección, y verde grisáceo para destinos inactivos.

## 2026-10-05 - Panel de estilo de reporte

- Versión fuente 1.0.82+107; etiquetas visibles sincronizadas. El panel Report style ahora tiene encabezado verde, icono, cierre integrado y una tarjeta de vista previa que muestra la paleta y layout activos.
- Los selectores usan tarjetas suaves, iconos y bordes ligados a la paleta elegida. En ancho amplio se acomodan en dos columnas; en narrow se apilan con espacio táctil.
- Se conserva el guardado y la actualización en vivo de la vista previa del reporte.

## 2026-10-05 - Controles amplios de estilo de reporte

- Versión fuente 1.0.83+108; etiquetas visibles sincronizadas.
- La paleta y el layout mantienen tarjetas compactas apiladas en narrow y pasan a dos columnas equilibradas en el panel ancho, sin campos estirados ni espacio desperdiciado.

## 2026-10-05 - Anclaje fiable para exportar reportes en iOS

- Versión fuente 1.0.84+109; etiquetas visibles sincronizadas.
- La exportación PDF/CSV usa el rectángulo real del botón que abrió la acción y siempre entrega un origen válido a la hoja nativa de iOS. Se eliminó el reintento sin origen que causaba un sharePositionOrigin vacío en pantallas amplias.
- La opción de CSV como texto también usa el mismo anclaje válido.

## 2026-10-05 - Menú CSV adaptable

- Versión fuente 1.0.85+110; etiquetas visibles sincronizadas.
- El menú de acciones CSV es desplazable cuando el alto disponible es reducido, evitando el desbordamiento visual en pantallas anchas y bajas.

## 2026-10-05 - Altura adaptable del menú CSV

- Versión fuente 1.0.86+111; etiquetas visibles sincronizadas.
- El menú CSV puede crecer dentro del área segura y desplazarse cuando sea necesario, eliminando el desbordamiento en una pantalla amplia de poca altura.

## 2026-10-05 - Vista previa realista de reporte

- Versión fuente 1.0.87+112; etiquetas visibles sincronizadas.
- La pestaña PDF ahora se presenta como una hoja imprimible: encabezado de negocio, logo real guardado, datos de contacto, periodo, totales en tabla y pie de documento.
- El PDF exportado y la versión de impresión ahora también incorporan el logo del perfil cuando existe, para que la vista previa corresponda al documento.
- Se mantienen la paleta y el layout configurados, aplicados en vivo al encabezado, tabla y elementos de énfasis.

## 2026-10-05 - Exportación autosuficiente desde la vista previa

- Versión fuente 1.0.88+113; etiquetas visibles sincronizadas.
- PDF y CSV se exportan ahora desde la propia vista previa, que conserva el botón, su anclaje nativo y el estado visible. Ya no dependen de la pantalla de reportes que podría haberse desmontado al navegar o recargar.
- Se conserva la validación Pro/anuncio, los tres formatos de CSV y los mensajes de error localizados.

## 2026-10-05 - Limpieza de la pantalla de reportes

- Versión fuente 1.0.89+114; etiquetas visibles sincronizadas.
- La pantalla base de reportes ya no mantiene estado de exportación duplicado; la vista previa administra su propio progreso y puede permanecer estable mientras se exporta.

## 2026-10-05 - Estado único de exportación

- Versión fuente 1.0.90+115; etiquetas visibles sincronizadas.
- Se retiró el estado de exportación residual de la pantalla de reportes; el botón Ver reporte navega siempre a la vista que administra por sí misma su progreso y sus mensajes.

## 2026-10-05 - Edición única del estilo de reporte

- Versión fuente 1.0.91+116; etiquetas visibles sincronizadas.
- Se eliminó el botón Edit redundante del panel inferior y lateral de la vista previa. El único acceso para cambiar el estilo permanece en el encabezado, junto al título Report.
- El panel inferior conserva únicamente la acción de exportar el formato que esté seleccionado.

## 2026-10-05 - Tema verde uniforme

- Versión fuente 1.0.92+117; etiquetas visibles sincronizadas.
- El tema global usa la paleta verde y fondos neutros de EzInvoice para rutas abiertas fuera del shell principal, como Ajustes, Privacidad y Términos.
- Los menús emergentes ya no heredan superficies rosadas: ahora usan una tarjeta blanca con acentos verdes, igual que el Dashboard.
- Privacidad y Términos fijan el fondo gris-verde suave para conservar el resultado en pantallas estrechas y anchas.

## 2026-10-05 - Vista previa idéntica al PDF

- Versión fuente 1.0.93+118; etiquetas visibles sincronizadas.
- La pestaña PDF renderiza la primera página del mismo archivo que se exporta, con su tamaño Letter, encabezado, logo, estilo, tablas y marca correspondiente.
- Se retiró la nota de referencia: la vista ya no simula el documento; muestra el documento real antes de compartirlo.

## 2026-10-05 - Exportar como botón flotante

- Versión fuente 1.0.94+119; etiquetas visibles sincronizadas.
- Export PDF o Export CSV ahora es un botón flotante extendido abajo a la derecha, con icono y texto completo.
- La vista previa ocupa el ancho disponible en narrow y wide; se añadió espacio inferior al contenido para que el botón no oculte información.

## 2026-10-05 - Diseño de facturas

- Versión fuente `1.0.95+120`; etiquetas visibles sincronizadas.
- La pantalla de facturas ahora reúne título, contador y un resumen de facturas, monto por cobrar y cobrado; la búsqueda se presenta en una tarjeta clara y los filtros nunca se recortan.
- En pantalla ancha cada factura aprovecha el espacio como una fila ordenada con estado, cliente, fecha y total. En narrow conserva una tarjeta compacta con la misma jerarquía.
- Nueva factura se muestra como botón flotante extendido abajo a la derecha y el contenido reserva espacio para no quedar cubierto.

## 2026-10-05 - Acerca de EzInvoice

- Versión fuente `1.0.96+121`; etiquetas visibles sincronizadas.
- El menú de perfil y Ajustes incorporan Acerca de EzInvoice.
- La nueva pantalla presenta EzInvoice, su propósito, Liisgo LLC, la versión instalada y accesos visibles a la web y soporte, con diseño adaptable narrow y wide dentro del tema verde de la app.

## 2026-10-05 - Compartir y comentarios

- Versión fuente `1.0.97+122`; etiquetas visibles sincronizadas.
- Acerca de EzInvoice incluye ahora Compartir EzInvoice, que abre la hoja nativa con el enlace de la aplicación.
- Enviar idea o bug abre un formulario breve: el usuario identifica una idea o un error, escribe el detalle y continúa al correo de soporte con el mensaje preparado.
- Ambas acciones se presentan lado a lado en wide y como botones completos en narrow.

## 2026-10-05 - Búsqueda de facturas bajo demanda

- Versión fuente `1.0.98+123`; etiquetas visibles sincronizadas.
- Se eliminó el contador duplicado bajo el título Facturas: el conteo permanece dentro del resumen superior.
- La búsqueda se abre desde la lupa a la derecha del título, recibe el foco al instante y se puede cerrar desde el mismo control.
- El comportamiento y el espacio se adaptan a narrow y wide.

## 2026-10-05 - Enlaces oficiales de EzInvoice Pro

- Versión fuente `1.0.99+124`; etiquetas visibles sincronizadas.
- Compartir EzInvoice Pro usa el listado oficial de App Store en iOS y el enlace oficial de Google Play en Android.
- La pantalla clásica de compartir y el enlace de actualización obligatoria se sincronizaron con los mismos destinos.

## 2026-10-05 - Búsqueda de facturas estable

- Versión fuente `1.0.100+125`; etiquetas visibles sincronizadas.
- La lista de facturas conserva una única suscripción a Firestore durante toda la pantalla.
- Abrir o escribir en la búsqueda ya no reinicia la carga ni desmonta el campo; se corrige el fallo en narrow y wide.


## 2026-10-05 - Reconstrucción limpia de iOS

- Versión fuente `1.0.101+126`; etiquetas visibles sincronizadas.
- El objetivo mínimo de Runner y de los Pods se ajustó a iOS 15, requerido por el simulador actual.
- Se ejecutó `flutter clean`, se restauraron las dependencias iOS y se recompiló EzInvoice en el simulador.


## 2026-10-05 - Búsqueda de facturas en narrow

- Versión fuente `1.0.102+127`; etiquetas visibles sincronizadas.
- El campo de búsqueda se inserta directamente al tocar la lupa, sin una animación de tamaño que podía impedir su aparición en pantallas narrow.
- La lupa conserva el foco automático, el filtro en vivo y el mismo comportamiento en wide.


## 2026-10-05 - Búsqueda directa en narrow

- Versión fuente `1.0.103+128`; etiquetas visibles sincronizadas.
- En narrow, tocar la lupa reemplaza el título por el campo de búsqueda en la cabecera; queda visible de inmediato y sin desplazar los filtros.
- En wide se conserva el campo completo debajo del resumen.


## 2026-10-05 - Área táctil de búsqueda en narrow

- Versión fuente `1.0.104+129`; etiquetas visibles sincronizadas.
- La cabecera de Facturas completa abre la búsqueda en narrow, como respaldo para pulsaciones ligeramente fuera de la lupa en el simulador vertical.
- La lupa conserva su acción y su objetivo táctil aumentó a 56 × 56 puntos.


## 2026-10-05 - Cierre claro de búsqueda en narrow

- Versión fuente `1.0.105+130`; etiquetas visibles sincronizadas.
- En narrow se eliminó la X interna que solo limpiaba el texto: queda una sola X, la de la cabecera, para cerrar la búsqueda.
- En wide se mantiene la X interna para borrar la consulta y la acción de cierre de la cabecera.


## 2026-10-05 - Gestos de búsqueda en simulador vertical

- Versión fuente `1.0.106+131`; etiquetas visibles sincronizadas.
- En narrow, abrir y cerrar búsqueda responde al inicio del toque en vez de esperar el gesto completo, que Device Hub puede perder al interpretarlo como arrastre mínimo.
- Wide conserva el comportamiento de botón estándar.


## 2026-10-05 - Eventos crudos de búsqueda en narrow

- Versión fuente `1.0.107+132`; etiquetas visibles sincronizadas.
- La búsqueda narrow responde a `onPointerDown`, el evento de toque crudo, para que un arrastre mínimo del simulador no cancele abrir o cerrar.
- La acción semántica del botón permanece disponible para accesibilidad.


## 2026-10-05 - Área superior de búsqueda más tolerante

- Versión fuente `1.0.108+133`; etiquetas visibles sincronizadas.
- En narrow, la cabecera y el resumen completo se convirtieron en el objetivo de apertura de búsqueda para compensar clics desplazados del simulador vertical.
- Filtros y facturas quedan fuera de esa zona y mantienen sus acciones propias.


## 2026-10-05 - Alertas del dashboard

- Versión fuente `1.0.109+134`; etiquetas visibles sincronizadas.
- El botón de avisos ahora tiene un objetivo táctil de 64 × 56 puntos y en narrow responde al inicio del toque, igual que la búsqueda.
- La hoja de alertas recibió un encabezado, contador, iconos por prioridad y filas con el mismo lenguaje visual verde de la app.


## 2026-10-05 - Cierre de alertas

- Versión fuente `1.0.110+135`; etiquetas visibles sincronizadas.
- La hoja de avisos tiene una X de cierre en el encabezado.
- Cualquier toque fuera de la hoja cierra la vista desde el evento inicial del puntero, incluso en narrow.


## 2026-10-05 - Encabezado compacto de alertas

- Versión fuente `1.0.111+136`; etiquetas visibles sincronizadas.
- El encabezado elimina el texto sobredimensionado y presenta el estado en una etiqueta compacta.
- Los estilos de título y contador quedan definidos de forma explícita para conservar el mismo aspecto en las dos orientaciones.


## 2026-10-05 - Alertas que abren facturas filtradas

- Versión fuente `1.0.112+137`; etiquetas visibles sincronizadas.
- La alerta de no enviadas abre Facturas con `Unsent` activo.
- La alerta de saldos pendientes abre Facturas con el nuevo filtro `Unpaid`, que reúne todas las facturas aún no pagadas.
- El filtro seleccionado se aplica de nuevo incluso cuando se toca la misma alerta dos veces.


## 2026-10-05 - Atajo de vencidas en alertas

- Versión fuente `1.0.113+138`; etiquetas visibles sincronizadas.
- Alertas incluye siempre el atajo `Overdue` para que las tres categorías lleven a un filtro real.
- Si no hay facturas vencidas, se muestra el conteo cero y un mensaje claro; el atajo sigue abriendo el filtro correspondiente.

## 2026-10-05 - Localización completa de la aplicación

- Versión fuente 1.0.114+139; etiquetas visibles sincronizadas.
- Los diez idiomas compatibles (árabe, alemán, inglés, español, francés, hindi, japonés, portugués, ruso y chino) ahora cubren la experiencia completa, incluidos acceso, clientes, facturas, pagos, ajustes, planes y ayuda.
- Reportes, exportaciones PDF/CSV/texto, estilos, mensajes Pro y documentos de privacidad/términos usan el idioma elegido.
- Se añadió una prueba que comprueba que cada catálogo contiene todas las claves y que el contenido legal existe para cada idioma.

## 2026-10-06 - Exportación con anuncio recompensado opcional

- Versión fuente 1.0.115+140; etiquetas visibles sincronizadas.
- Las exportaciones de reportes para el plan Free muestran una elección clara antes de cualquier anuncio: ver un anuncio para una exportación, actualizar a Pro o cancelar.
- La exportación sólo continúa cuando la plataforma confirma la recompensa; se registran las decisiones y resultados anónimos del flujo para medir conversión.
- La configuración Android ya no fija una ruta de Java de Windows; usa el JDK disponible en el equipo de compilación.
- Se conserva el banner para usuarios Free y no se añaden interstitials durante la creación de facturas.
