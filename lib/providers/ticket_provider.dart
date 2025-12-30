import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';

class TicketNotifier extends AsyncNotifier<List<Ticket>> {
  
  @override
  Future<List<Ticket>> build() async {
    // This simulates the initial fetch on app launch
    return _fetchDummyTickets();
  }

  Future<List<Ticket>> _fetchDummyTickets() async {
    // Simulating a network delay (e.g., 1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    return [
      Ticket("JOHN", "", "SMITH", "UTSAV-053467-082026-01", "BASIC", "GREAT VENUE", "Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions,Park in the Guest parking lot and some other instructions"),
      Ticket("JANE", "", "SMITH", "UTSAV-053467-082026-02", "BASIC", "GREAT VENUE", "Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions,Park in the Guest parking lot and some other instructions"),
      Ticket("ALEX", "", "JOHNSON", "UTSAV-053467-082026-03", "BASIC", "GREAT VENUE", "Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions,Park in the Guest parking lot and some other instructions"),
      Ticket("MAYA", "APPU", "PATELAKRISNAN", "UTSAV-053467-082026-04", "BASIC", "GREAT VENUE", "Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions, Park in the Guest parking lot and some other instructions,Park in the Guest parking lot and some other instructions"),
    ];
  }

  // A method to manually trigger a refresh (like pull-to-refresh)
  Future<void> refreshTickets() async {
    state = const AsyncValue.loading(); // Set state to loading
    state = await AsyncValue.guard(() => _fetchDummyTickets());
  }

  // Future<void> refreshTickets() async {
  // state = const AsyncValue.loading();
  
  // // AsyncValue.guard will catch this "Exception" and pass it to your UI's error builder
  // state = await AsyncValue.guard(() async {
  //   await Future.delayed(const Duration(seconds: 1)); // Simulating network lag
  //   throw Exception("Could not connect to the serva. Please try again later.");
  // });
// }
}

// Note the change to AsyncNotifierProvider
final ticketProvider = AsyncNotifierProvider<TicketNotifier, List<Ticket>>(TicketNotifier.new);