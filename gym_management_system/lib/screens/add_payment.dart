import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/payment.dart';
import '../providers/member_provider.dart';

class AddPayment extends StatefulWidget {
  final int memberId;
  const AddPayment({super.key, required this.memberId});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(labelText: 'Amount (INR)'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Enter amount' : null,
              ),
              TextFormField(
                controller: _notesCtrl,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  double amt = double.tryParse(_amountCtrl.text) ?? 0.0;
                  final provider = Provider.of<MemberProvider>(
                    context,
                    listen: false,
                  );
                  if (amt == 0.0) {
                    final found = provider.members.where(
                      (m) => m.id == widget.memberId,
                    );
                    final member = found.isNotEmpty ? found.first : null;
                    final plan = member == null
                        ? 'monthly'
                        : member.plan.toLowerCase();
                    if (plan.contains('year'))
                      amt = 5500.0;
                    else if (plan.contains('quarter'))
                      amt = 1900.0;
                    else
                      amt = 500.0;
                  }
                  final payment = Payment(
                    memberId: widget.memberId,
                    amount: amt,
                    notes: _notesCtrl.text,
                    status: 'paid',
                  );
                  try {
                    await provider.addPayment(payment);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment added')),
                    );
                    Navigator.pop(context, true);
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    if (!mounted) return;
                    Navigator.pop(context, false);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
