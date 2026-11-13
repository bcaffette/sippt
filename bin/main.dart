import 'package:dotenv/dotenv.dart';
import 'package:sippt/repos/shop_repo.dart';
import 'package:sippt/shop.dart';
import 'package:supabase/supabase.dart';

final env = DotEnv()..load();

Future<void> main() async {
  final SupabaseClient supabase = SupabaseClient(
    env['SUPABASE_URL']!,
    env['SUPABASE_PUBLISHABLE_KEY']!,
  );

  final shopRepo = ShopRepo(client: supabase);

  final List<Shop> allShops = await shopRepo.getAllShops();
  for (final s in allShops) {
    print(s);
  }

  await supabase.dispose();
}
