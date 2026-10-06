import 'package:ezinvoice/services/navigation/quick_access_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'starts with invoicing first and promotes destinations by use',
    () async {
      expect(await QuickAccessService.load(userId: 'ana'), [2, 1, 3, 4]);

      expect(await QuickAccessService.record(destination: 3, userId: 'ana'), [
        3,
        2,
        1,
        4,
      ]);
      expect(await QuickAccessService.record(destination: 1, userId: 'ana'), [
        1,
        3,
        2,
        4,
      ]);
      expect(await QuickAccessService.record(destination: 3, userId: 'ana'), [
        3,
        1,
        2,
        4,
      ]);
    },
  );

  test('keeps quick access separate for each signed-in user', () async {
    await QuickAccessService.record(destination: 4, userId: 'ana');

    expect(await QuickAccessService.load(userId: 'ana'), [4, 2, 1, 3]);
    expect(await QuickAccessService.load(userId: 'bruno'), [2, 1, 3, 4]);
  });
}
