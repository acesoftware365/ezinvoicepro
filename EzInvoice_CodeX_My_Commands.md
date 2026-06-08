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

- Antes de hacer cambios, decir brevemente lo entendido.
- No pedir aclaraciones si hay una decision razonable y segura.
- Guardar en este archivo los cambios importantes, decisiones y comandos utiles.
- Mantener los cambios versionados y subirlos a GitHub cuando el trabajo quede verificado.

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
