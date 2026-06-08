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
