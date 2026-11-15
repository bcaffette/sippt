import 'package:sippt/profile.dart';
import 'package:test/test.dart';

void main() {
  test('null pfp_url stays null', () {
    const data = {
      'id': 'xyz',
      'username': 'coffeedrinker',
      'pfp_url': null,
      'created_at': '2026-11-14T17:00:00Z',
    };

    final profile = Profile.fromJson(data);

    expect(profile.pfpUrl, isNull);
  });

  test('datetime is the same from a string, and is in utc', () {
    const dateStr = '2026-11-14T17:00:00Z';
    final manualDate = DateTime.utc(2026, 11, 14, 17, 0, 0);
    const data = {
      'id': 'xyz',
      'username': 'coffeedrinker',
      'pfp_url': null,
      'created_at': dateStr,
    };

    final profile = Profile.fromJson(data);
    
    expect(profile.createdAt, equals(manualDate));
    expect(profile.createdAt.isUtc, isTrue);
  });
}