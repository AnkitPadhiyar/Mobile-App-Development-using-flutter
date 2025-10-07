import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/member.dart';
import '../models/payment.dart';

class MemberProvider with ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  List<Member> _members = [];
  List<Payment> _payments = [];

  List<Payment> get payments => _payments;

  List<Member> get members => _members;

  Future<void> loadMembers() async {
    _members = await _db.getAllMembers();
    notifyListeners();
  }

  Future<void> addMember(Member m) async {
    try {
      final id = await _db.insertMember(m);
      m.id = id;
      _members.add(m);
      notifyListeners();
      debugPrint('Member added with id: $id');
    } catch (e) {
      debugPrint('Error adding member: $e');
      rethrow;
    }
  }

  Future<void> updateMember(Member m) async {
    await _db.updateMember(m);
    final idx = _members.indexWhere((e) => e.id == m.id);
    if (idx != -1) {
      _members[idx] = m;
      notifyListeners();
    }
  }

  Future<void> incrementAttendance(int memberId) async {
    try {
      final idx = _members.indexWhere((m) => m.id == memberId);
      if (idx == -1) return;
      final m = _members[idx];
      m.attendanceCount = m.attendanceCount + 1;
      await _db.updateMember(m);
      _members[idx] = m;
      notifyListeners();
      debugPrint(
        'Incremented attendance for member $memberId to ${m.attendanceCount}',
      );
    } catch (e) {
      debugPrint('Error incrementing attendance: $e');
      rethrow;
    }
  }

  Future<void> decrementAttendance(int memberId) async {
    try {
      final idx = _members.indexWhere((m) => m.id == memberId);
      if (idx == -1) return;
      final m = _members[idx];
      m.attendanceCount = m.attendanceCount - 1;
      if (m.attendanceCount < 0) m.attendanceCount = 0;
      await _db.updateMember(m);
      _members[idx] = m;
      notifyListeners();
      debugPrint(
        'Decremented attendance for member $memberId to ${m.attendanceCount}',
      );
    } catch (e) {
      debugPrint('Error decrementing attendance: $e');
      rethrow;
    }
  }

  Future<void> deleteMember(int id) async {
    await _db.deleteMember(id);
    _members.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  Future<void> loadAllPayments() async {
    _payments = await _db.getPaymentsForMember(-1).catchError((_) async {
      // fallback: fetch all payments directly from db helper
      return await getAllPayments();
    });
    notifyListeners();
  }

  Future<List<Payment>> getPayments(int memberId) async {
    return await _db.getPaymentsForMember(memberId);
  }

  Future<bool> isMemberPaid(Member m) async {
    if (m.id == null) return false;
    final payments = await getPayments(m.id!);
    if (payments.isEmpty) return false;
    final now = DateTime.now();
    int days = 30;
    if (m.plan.toLowerCase().contains('quarter')) days = 90;
    if (m.plan.toLowerCase().contains('year')) days = 365;
    // consider paid if any payment within the plan window
    for (final p in payments) {
      if (p.status.toLowerCase() == 'paid') {
        final diff = now.difference(p.date).inDays;
        if (diff <= days) return true;
      }
    }
    return false;
  }

  Future<void> addPayment(Payment p) async {
    try {
      final id = await _db.insertPayment(p);
      p.id = id;
      _payments.insert(0, p);
      debugPrint('Payment inserted id=$id for member=${p.memberId}');
      notifyListeners();
    } catch (e) {
      debugPrint('Error inserting payment: $e');
      rethrow;
    }
  }

  Future<List<Payment>> getAllPayments() async {
    // convenience method to fetch all payments for fees management
    final db = await _db.database;
    final maps = await db.query('payments', orderBy: 'date DESC');
    return maps.map((m) => Payment.fromMap(m)).toList();
  }
}
