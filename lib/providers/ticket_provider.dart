import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsav_app/models/ticket_model.dart';
import 'package:utsav_app/providers/supabase_provider.dart';

class TicketNotifier extends AsyncNotifier<List<Ticket>> {
  @override
  Future<List<Ticket>> build() => _fetchTickets();

  Future<List<Ticket>> _fetchTickets() async {
    final rows = await ref.read(supabaseProvider).from('tickets').select().order(
          'created_at',
          ascending: false,
        );
    return (rows as List)
        .map((row) => Ticket.fromJson(Map<String, dynamic>.from(row as Map)))
        .toList();
  }

  Future<void> refreshTickets() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchTickets);
  }
}

final ticketProvider =
    AsyncNotifierProvider<TicketNotifier, List<Ticket>>(TicketNotifier.new);
