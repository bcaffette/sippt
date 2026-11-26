import 'package:sippt/models/shop.dart';
import 'package:supabase/supabase.dart';

class ShopRepo {
  final SupabaseClient client;

  ShopRepo({required this.client});

  Future<List<Shop>> getAllShopsByPartnerId(int pId) async {
    final List<Shop> shops = [];
    final res = await client
        .from('shops')
        .select('id, address, lat, long, partners(name)')
        .eq('partner_id', pId);

    for (final sMap in res) {
      final shop = Shop.fromJson(sMap);
      shops.add(shop);
    }

    return shops;
  }
}
