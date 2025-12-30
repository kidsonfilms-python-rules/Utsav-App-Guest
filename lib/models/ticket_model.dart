
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

  factory Ticket.fromJson(Map<String, Object?> json) {
    return Ticket(
      json['firstName']! as String,
      json['middleName']! as String,
      json['lastName']! as String,
      json['barcode']! as String,
      json['tier']! as String,
      json['venue']! as String,
      json['venueInstructions']! as String,
    );
  }

  
}
