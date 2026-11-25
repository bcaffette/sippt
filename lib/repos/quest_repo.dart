import 'package:sippt/models/quest.dart';
import 'package:supabase/supabase.dart';

class QuestRepo {
  final SupabaseClient client;

  QuestRepo({required this.client});

  Future<List<Quest>> fetchActiveQuests() async {
    final List<Quest> quests = [];
    final res = await client
        .from('quests')
        .select('shop_id, value, expires_at, shops(name)')
        .gt('expires_at', DateTime.now().toUtc().toIso8601String());

    for (final Map<String, dynamic> q in res) {
      final quest = Quest.fromJson(q);
      quests.add(quest);
    }

    return quests;
  }
}
