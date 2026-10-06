import 'dart:async';
import 'package:flutter/foundation.dart';

/// Coalesces edits, but never lets an older acknowledgement clear newer edits.
/// Writers should enqueue their durable/offline write before awaiting the server.
class ProfileAutosave extends ChangeNotifier {
  ProfileAutosave(this.write, {this.delay = const Duration(milliseconds: 500)});

  final Future<void> Function(Map<String, dynamic>) write;
  final Duration delay;
  final Map<String, dynamic> _pending = {};
  final Map<String, int> _versions = {};
  Timer? _timer;
  int _revision = 0;
  bool _disposed = false;
  bool hasError = false;
  bool get hasPending => _pending.isNotEmpty;

  void change(Map<String, dynamic> fields) {
    for (final entry in fields.entries) {
      _pending[entry.key] = entry.value;
      _versions[entry.key] = ++_revision;
    }
    hasError = false;
    _timer?.cancel();
    _timer = Timer(delay, flush);
    _notify();
  }

  Future<void> flush() async {
    _timer?.cancel();
    if (_pending.isEmpty) return;
    final fields = Map<String, dynamic>.from(_pending);
    final versions = Map<String, int>.from(_versions);
    try {
      await write(fields);
      for (final key in fields.keys) {
        if (_versions[key] == versions[key]) {
          _pending.remove(key);
          _versions.remove(key);
        }
      }
      if (_pending.isEmpty) hasError = false;
    } catch (_) {
      // Keep the newest values for retry, including edits made during this write.
      if (versions.entries.any((e) => _versions[e.key] == e.value)) {
        hasError = true;
      }
    }
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    unawaited(flush());
    super.dispose();
  }
}
