import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The single database client used by all remote-data providers.
final supabaseProvider = Provider<SupabaseClient>((ref) => Supabase.instance.client);
