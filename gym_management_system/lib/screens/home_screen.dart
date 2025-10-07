import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/member_provider.dart';
import 'member_form.dart';
import 'fees_screen.dart';
import 'members_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProvider>(context, listen: false).loadMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Gym Management Dashboard')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.receipt_long, size: 28),
                label: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Fees Management',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 60),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const FeesScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add, size: 26),
                label: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Add New Member', style: TextStyle(fontSize: 16)),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(180, 54),
                ),
                onPressed: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(builder: (c) => const MemberForm()),
                  );
                  if (result == true) await provider.loadMembers();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.group, size: 26),
                label: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Current Members',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(180, 54),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const MembersList()),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text('Total members: ${provider.members.length}'),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
