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
