import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/member.dart';
import '../models/payment.dart';
import '../providers/member_provider.dart';
import 'add_payment.dart';

class MemberDetails extends StatefulWidget {
  final Member member;
  const MemberDetails({super.key, required this.member});

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  List<Payment> _payments = [];

  Future<void> _loadPayments() async {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    final p = await provider.getPayments(widget.member.id!);
    setState(() => _payments = p);
  }

  @override
  void initState() {
    super.initState();
    if (widget.member.id != null) _loadPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.member.name)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${widget.member.email}'),
            Text('Phone: ${widget.member.phone}'),
            Text('Plan: ${widget.member.plan}'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Attendance: '),
                Text('${widget.member.attendanceCount}'),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  onPressed: () async {
                    if (widget.member.id == null) return;
                    final provider = Provider.of<MemberProvider>(
                      context,
                      listen: false,
                    );
                    await provider.incrementAttendance(widget.member.id!);
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () async {
                    if (widget.member.id == null) return;
                    final provider = Provider.of<MemberProvider>(
                      context,
                      listen: false,
                    );
                    await provider.decrementAttendance(widget.member.id!);
                    setState(() {});
                  },
                ),
              ],
            ),
            Text(
              'Joined: ${widget.member.joinDate.toLocal().toString().split(' ')[0]}',
            ),
            const SizedBox(height: 12),
            const Text(
              'Payments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _payments.isEmpty
                  ? const Center(child: Text('No payments yet'))
                  : ListView.builder(
                      itemCount: _payments.length,
                      itemBuilder: (context, idx) {
                        final pay = _payments[idx];
                        return ListTile(
                          title: Text('\$${pay.amount.toStringAsFixed(2)}'),
                          subtitle: Text(
                            '${pay.status} • ${pay.date.toLocal().toString().split(' ')[0]}',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.payment),
        onPressed: () async {
          final res = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => AddPayment(memberId: widget.member.id!),
            ),
          );
          if (res == true) await _loadPayments();
        },
      ),
    );
  }
}
