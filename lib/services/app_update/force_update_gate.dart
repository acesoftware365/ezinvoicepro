import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateGate extends StatefulWidget {
  final Widget child;

  const ForceUpdateGate({super.key, required this.child});

  @override
  State<ForceUpdateGate> createState() => _ForceUpdateGateState();
}

class _ForceUpdateGateState extends State<ForceUpdateGate> {
  static const String _androidStoreUrl =
      'https://play.google.com/store/apps/details?id=com.liisgo.ezinvoice';
  static const String _iosStoreUrl = 'https://apps.apple.com/app/id6757661737';

  bool _checking = true;
  bool _updateRequired = false;
  String? _storeUrl;

  bool get _isEs {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'es';
  }

  @override
  void initState() {
    super.initState();
    _checkForRequiredUpdate();
  }

  Future<void> _checkForRequiredUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentBuild = int.tryParse(packageInfo.buildNumber) ?? 0;
      final currentVersion = packageInfo.version;

      final doc = await FirebaseFirestore.instance
          .collection('app_config')
          .doc('force_update')
          .get();

      if (!doc.exists) {
        _finishChecking(updateRequired: false);
        return;
      }

      final data = doc.data() ?? const <String, dynamic>{};
      final enabled = data['enabled'] == true;
      if (!enabled) {
        _finishChecking(updateRequired: false);
        return;
      }

      final prefix = Platform.isIOS ? 'ios' : 'android';
      final minBuild = _asInt(data['${prefix}MinimumBuild']);
      final minVersion = (data['${prefix}MinimumVersion'] ?? '').toString();
      final storeUrl = (data['${prefix}StoreUrl'] ?? '').toString().trim();

      final needsBuildUpdate = minBuild != null && currentBuild < minBuild;
      final needsVersionUpdate =
          minVersion.isNotEmpty &&
          _compareVersions(currentVersion, minVersion) < 0;

      _finishChecking(
        updateRequired: needsBuildUpdate || needsVersionUpdate,
        storeUrl: storeUrl.isNotEmpty ? storeUrl : _defaultStoreUrl,
      );
    } catch (_) {
      _finishChecking(updateRequired: false);
    }
  }

  String get _defaultStoreUrl {
    return Platform.isIOS ? _iosStoreUrl : _androidStoreUrl;
  }

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  int _compareVersions(String current, String minimum) {
    final currentParts = _versionParts(current);
    final minimumParts = _versionParts(minimum);
    final length = currentParts.length > minimumParts.length
        ? currentParts.length
        : minimumParts.length;

    for (var i = 0; i < length; i++) {
      final currentPart = i < currentParts.length ? currentParts[i] : 0;
      final minimumPart = i < minimumParts.length ? minimumParts[i] : 0;
      if (currentPart != minimumPart) {
        return currentPart.compareTo(minimumPart);
      }
    }
    return 0;
  }

  List<int> _versionParts(String version) {
    return version
        .split('.')
        .map(
          (part) => int.tryParse(part.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
        )
        .toList();
  }

  void _finishChecking({required bool updateRequired, String? storeUrl}) {
    if (!mounted) return;
    setState(() {
      _checking = false;
      _updateRequired = updateRequired;
      _storeUrl = storeUrl;
    });
  }

  Future<void> _openStore() async {
    final url = _storeUrl ?? _defaultStoreUrl;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_updateRequired) return widget.child;

    final isEs = _isEs;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.system_update_alt,
                    color: Color(0xFF1F6E5C),
                    size: 52,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    isEs ? 'Actualizacion requerida' : 'Update required',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F6E5C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isEs
                        ? 'Hay una version nueva de Ez Invoice. Para continuar, actualiza la app desde la tienda.'
                        : 'A new version of Ez Invoice is available. To continue, update the app from the store.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _openStore,
                    icon: const Icon(Icons.open_in_new),
                    label: Text(isEs ? 'Actualizar ahora' : 'Update now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F6E5C),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
