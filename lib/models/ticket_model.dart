
class Ticket {
  final String firstName;
  final String middleName;
  final String lastName;
  final String barcode;
  final String tier;
  final String venue;
  final String venueInstructions;

  Ticket(
    this.firstName,
    this.middleName,
    this.lastName,
    this.barcode,
    this.tier,
    this.venue,
    this.venueInstructions,
  );

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      json['first_name'] as String,
      json['middle_name'] as String? ?? '',
      json['last_name'] as String,
      json['barcode'] as String,
      json['tier'] as String,
      json['venue'] as String,
      json['venue_instructions'] as String? ?? '',
    );
  }
}
