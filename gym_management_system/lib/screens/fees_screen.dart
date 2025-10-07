import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/member_provider.dart';
import '../models/payment.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  List<Payment> _payments = [];

  Future<void> _load() async {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    final p = await provider.getAllPayments();
    setState(() => _payments = p);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    final total = _payments.fold<double>(0.0, (s, p) => s + p.amount);
    return Scaffold(
      appBar: AppBar(title: const Text('Fees')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Total collected: \$${total.toStringAsFixed(2)}'),
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
                          '${pay.date.toLocal().toString().split(' ')[0]} • ${pay.notes}',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
