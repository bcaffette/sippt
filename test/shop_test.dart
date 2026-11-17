import 'package:sippt/shop.dart';
import 'package:test/test.dart';

void main() {
  group('shop init', () {
    test('supplying integers successfully makes double using Shop.fromJson', () {
      const data = {
        'id': 1,
        'name': 'My Cozy Cafe',
        'address': '800 Boylston St., Boston, MA, 02199',
        'lat': 42.22,
        'long': -71,
      };

      final shop = Shop.fromJson(data);

      expect(shop.long, isA<double>());
      expect(shop.long, equals(-71.0));
    });

    test('every json value maps properly to the Shop fields', () {
      const data = {
        'id': 1,
        'name': 'My Cozy Cafe',
        'address': '800 Boylston St., Boston, MA, 02199',
        'lat': 42.22,
        'long': -71.06,
      };

      final shop = Shop.fromJson(data);

      expect(shop.id, equals(1));
      expect(shop.name, equals('My Cozy Cafe'));
      expect(shop.address, equals('800 Boylston St., Boston, MA, 02199'));
      expect(shop.lat, equals(42.22));
      expect(shop.long, equals(-71.06));
    });

    test('missing field throws an error', () {
      const noNameData = {
        'id': 1,
        'address': null,
        'name': 'My Cozy Cafe',
        'lat': 42.22,
        'long': -71.06,
      };

      expect(() => Shop.fromJson(noNameData), throwsA(isA<FormatException>()));
    });
  });
}
