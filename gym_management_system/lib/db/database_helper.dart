import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/member.dart';
import '../models/payment.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  // In-memory fallback stores for web (sqflite isn't supported on web)
  final List<Map<String, dynamic>> _membersStore = [];
  final List<Map<String, dynamic>> _paymentsStore = [];
  int _memberAutoId = 1;
  int _paymentAutoId = 1;

  Future<Database> get database async {
    if (kIsWeb) {
      throw StateError(
        'Database not available on web; use repository methods directly.',
      );
    }
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'gym_management.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE members(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT,
        plan TEXT,
        joinDate TEXT,
        attendanceCount INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE payments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        memberId INTEGER,
        amount REAL,
        date TEXT,
        status TEXT,
        notes TEXT,
        FOREIGN KEY(memberId) REFERENCES members(id) ON DELETE CASCADE
      )
    ''');
  }

  // Member CRUD
  Future<int> insertMember(Member member) async {
    if (kIsWeb) {
      final map = member.toMap();
      map['id'] = _memberAutoId++;
      _membersStore.add(map);
      return map['id'] as int;
    }
    final dbClient = await database;
    return await dbClient.insert('members', member.toMap());
  }

  Future<int> updateMember(Member member) async {
    if (kIsWeb) {
      final idx = _membersStore.indexWhere((m) => m['id'] == member.id);
      if (idx == -1) return 0;
      _membersStore[idx] = member.toMap();
      return 1;
    }
    final dbClient = await database;
    return await dbClient.update(
      'members',
      member.toMap(),
      where: 'id = ?',
      whereArgs: [member.id],
    );
  }

  Future<int> deleteMember(int id) async {
    if (kIsWeb) {
      _membersStore.removeWhere((m) => m['id'] == id);
      _paymentsStore.removeWhere((p) => p['memberId'] == id);
      return 1;
    }
    final dbClient = await database;
    return await dbClient.delete('members', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Member>> getAllMembers() async {
    if (kIsWeb) {
      final maps = List<Map<String, dynamic>>.from(_membersStore);
      maps.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
      return maps.map((m) => Member.fromMap(m)).toList();
    }
    final dbClient = await database;
    final maps = await dbClient.query('members', orderBy: 'name ASC');
    return maps.map((m) => Member.fromMap(m)).toList();
  }

  Future<Member?> getMemberById(int id) async {
    if (kIsWeb) {
      final maps = _membersStore.where((m) => m['id'] == id).toList();
      if (maps.isNotEmpty) return Member.fromMap(maps.first);
      return null;
    }
    final dbClient = await database;
    final maps = await dbClient.query(
      'members',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) return Member.fromMap(maps.first);
    return null;
  }

  // Payment CRUD
  Future<int> insertPayment(Payment payment) async {
    if (kIsWeb) {
      final map = payment.toMap();
      map['id'] = _paymentAutoId++;
      _paymentsStore.add(map);
      return map['id'] as int;
    }
    final dbClient = await database;
    return await dbClient.insert('payments', payment.toMap());
  }

  Future<List<Payment>> getPaymentsForMember(int memberId) async {
    if (memberId == -1) {
      if (kIsWeb) {
        final maps = List<Map<String, dynamic>>.from(_paymentsStore);
        maps.sort(
          (a, b) => (b['date'] as String).compareTo(a['date'] as String),
        );
        return maps.map((m) => Payment.fromMap(m)).toList();
      }
      final dbClient = await database;
      final maps = await dbClient.query('payments', orderBy: 'date DESC');
      return maps.map((m) => Payment.fromMap(m)).toList();
    }
    if (kIsWeb) {
      final maps = _paymentsStore
          .where((p) => p['memberId'] == memberId)
          .toList();
      maps.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));
      return maps.map((m) => Payment.fromMap(m)).toList();
    }
    final dbClient = await database;
    final maps = await dbClient.query(
      'payments',
      where: 'memberId = ?',
      whereArgs: [memberId],
      orderBy: 'date DESC',
    );
    return maps.map((m) => Payment.fromMap(m)).toList();
  }

  Future<int> updatePayment(Payment payment) async {
    if (kIsWeb) {
      final idx = _paymentsStore.indexWhere((p) => p['id'] == payment.id);
      if (idx == -1) return 0;
      _paymentsStore[idx] = payment.toMap();
      return 1;
    }
    final dbClient = await database;
    return await dbClient.update(
      'payments',
      payment.toMap(),
      where: 'id = ?',
      whereArgs: [payment.id],
    );
  }

  Future<int> deletePayment(int id) async {
    if (kIsWeb) {
      _paymentsStore.removeWhere((p) => p['id'] == id);
      return 1;
    }
    final dbClient = await database;
    return await dbClient.delete('payments', where: 'id = ?', whereArgs: [id]);
  }
}
