class Member {
  int? id;
  String name;
  String email;
  String phone;
  String plan;
  DateTime joinDate;
  int attendanceCount;

  Member({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.plan,
    DateTime? joinDate,
    this.attendanceCount = 0,
  }) : joinDate = joinDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'plan': plan,
      'joinDate': joinDate.toIso8601String(),
      'attendanceCount': attendanceCount,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      plan: map['plan'] as String? ?? '',
      joinDate:
          DateTime.tryParse(map['joinDate'] as String? ?? '') ?? DateTime.now(),
      attendanceCount: map['attendanceCount'] as int? ?? 0,
    );
  }
}
