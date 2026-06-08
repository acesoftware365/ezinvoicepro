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
