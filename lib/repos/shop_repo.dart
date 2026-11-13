import 'package:sippt/shop.dart';
import 'package:supabase/supabase.dart';

class ShopRepo {
  final SupabaseClient client;

  ShopRepo({required this.client});

  Future<List<Shop>> getAllShops() async {
    final List<Shop> shops = [];

    final rows = await client.from('shops').select();
    for (final s in rows) {
      final shop = Shop.fromJson(s);
      shops.add(shop);
    }

    return shops;
  }
}
