import 'package:sippt/shop.dart';
import 'package:test/test.dart';

void main() {

  test('supplying integers successfully makes double using Shop.fromJson', () {
    const data = {
      'id': 1,
      'name': 'My Cozy Cafe',
      'address': '800 Boylston St., Boston, MA, 02199',
      'lat': 42.22,
      'long': 79,
    };

    final shop = Shop.fromJson(data);

    expect(shop.long, isA<double>());
    expect(shop.long, equals(79.0));
  });

  test('every json value maps properly to the Shop fields', () {
    const data = {
      'id': 1,
      'name': 'My Cozy Cafe',
      'address': '800 Boylston St., Boston, MA, 02199',
      'lat': 42.22,
      'long': 79.91,
    };

    final shop = Shop.fromJson(data);

    expect(shop.id, equals(1));
    expect(shop.name, equals('My Cozy Cafe'));
    expect(shop.address, equals('800 Boylston St., Boston, MA, 02199'));
    expect(shop.lat, equals(42.22));
    expect(shop.long, equals(79.91));
  });
}