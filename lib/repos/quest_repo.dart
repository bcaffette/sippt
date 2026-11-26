import 'package:sippt/models/quest.dart';
import 'package:supabase/supabase.dart';

class QuestRepo {
  final SupabaseClient client;

  QuestRepo({required this.client});

  Future<List<Quest>> fetchActiveQuests() async {
    final List<Quest> quests = [];
    final res = await client
        .from('quests')
        .select('partner_id, value, expires_at, partners(name)')
        .gt('expires_at', DateTime.now().toUtc().toIso8601String());

    for (final qMap in res) {
      final quest = Quest.fromJson(qMap);
      quests.add(quest);
    }

    return quests;
  }
}
