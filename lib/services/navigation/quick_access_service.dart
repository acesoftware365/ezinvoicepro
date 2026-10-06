import 'package:shared_preferences/shared_preferences.dart';

/// Stores each person's most-used navigation destinations on this device.
class QuickAccessService {
  QuickAccessService._();

  static const List<int> defaultOrder = [2, 1, 3, 4];
  static const List<int> _supportedDestinations = [1, 2, 3, 4];
  static const _keyPrefix = 'quick_access_v1';

  static Future<List<int>> load({String? userId}) async {
    final preferences = await SharedPreferences.getInstance();
    return _sorted(preferences, _scope(userId));
  }

  static Future<List<int>> record({
    required int destination,
    String? userId,
  }) async {
    if (!_supportedDestinations.contains(destination)) {
      return load(userId: userId);
    }

    final preferences = await SharedPreferences.getInstance();
    final scope = _scope(userId);
    final countKey = _countKey(scope, destination);
    final currentCount = preferences.getInt(countKey) ?? 0;

    await preferences.setInt(countKey, currentCount + 1);
    await preferences.setInt(
      _lastUsedKey(scope, destination),
      DateTime.now().microsecondsSinceEpoch,
    );

    return _sorted(preferences, scope);
  }

  static List<int> _sorted(SharedPreferences preferences, String scope) {
    final positions = <int, int>{
      for (var position = 0; position < defaultOrder.length; position++)
        defaultOrder[position]: position,
    };

    final destinations = List<int>.from(_supportedDestinations);
    destinations.sort((left, right) {
      final leftCount = preferences.getInt(_countKey(scope, left)) ?? 0;
      final rightCount = preferences.getInt(_countKey(scope, right)) ?? 0;
      final countComparison = rightCount.compareTo(leftCount);
      if (countComparison != 0) return countComparison;

      final leftLastUsed = preferences.getInt(_lastUsedKey(scope, left)) ?? 0;
      final rightLastUsed = preferences.getInt(_lastUsedKey(scope, right)) ?? 0;
      final lastUsedComparison = rightLastUsed.compareTo(leftLastUsed);
      if (lastUsedComparison != 0) return lastUsedComparison;

      return (positions[left] ?? left).compareTo(positions[right] ?? right);
    });
    return destinations;
  }

  static String _scope(String? userId) {
    final normalized = userId?.trim() ?? '';
    return normalized.isEmpty ? 'guest' : normalized;
  }

  static String _countKey(String scope, int destination) =>
      '$_keyPrefix.$scope.$destination.count';

  static String _lastUsedKey(String scope, int destination) =>
      '$_keyPrefix.$scope.$destination.last_used';
}
