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
}