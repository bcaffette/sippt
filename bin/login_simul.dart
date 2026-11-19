import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

final env = DotEnv()..load();

Future<void> main() async {
  final SupabaseClient supabase = SupabaseClient(
    env['SUPABASE_URL']!,
    env['SUPABASE_PUBLISHABLE_KEY']!,
  );

  final res = await supabase.auth.signInWithPassword(email: env['SIMUL_EMAIL']!, password: env['SIMUL_PW']!);
  final uid = res.user!.id;

  final profile = await supabase
      .from('profiles')
      .select()
      .eq('id', uid)
      .maybeSingle();

  print('Logged in as ${profile!['username']}');

  await supabase.dispose();
}
