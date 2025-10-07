class Payment {
  int? id;
  int memberId;
  double amount;
  DateTime date;
  String status; // paid / due
  String notes;

  Payment({
    this.id,
    required this.memberId,
    required this.amount,
    DateTime? date,
    this.status = 'paid',
    this.notes = '',
  }) : date = date ?? DateTime.now();

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'memberId': memberId,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
      'notes': notes,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as int?,
      memberId: map['memberId'] as int,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
      status: map['status'] as String? ?? 'paid',
      notes: map['notes'] as String? ?? '',
    );
  }
}
