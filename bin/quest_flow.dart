import 'package:dotenv/dotenv.dart';
import 'package:sippt/repos/quest_repo.dart';
import 'package:sippt/repos/shop_repo.dart';
import 'package:supabase/supabase.dart';

Future<void> main() async {
  final env = DotEnv()..load();
  final url = env['SUPABASE_URL'];
  final key = env['SUPABASE_PUBLISHABLE_KEY'];

  final client = SupabaseClient(url!, key!);

  final qR = QuestRepo(client: client);
  final shR = ShopRepo(client: client);

  final questsToday = await qR.fetchActiveQuests();
  for (final quest in questsToday) {
    final shops = await shR.getAllShopsByPartnerId(quest.partnerId);
    print(quest);
    print('------------------\n------------------');
    print('Find a ${quest.partnerName} near you:');
    print(shops.join('\n'));
  }

  await client.dispose();
}
