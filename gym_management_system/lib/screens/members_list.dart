import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/member_provider.dart';
import 'member_details.dart';

class MembersList extends StatefulWidget {
  const MembersList({super.key});

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MemberProvider>(context, listen: false);
      if (provider.members.isEmpty) provider.loadMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Current Members')),
      body: provider.members.isEmpty
          ? const Center(child: Text('No members yet'))
          : ListView.builder(
              itemCount: provider.members.length,
              itemBuilder: (context, idx) {
                final m = provider.members[idx];
                final joinDate = m.joinDate.toLocal().toString().split(' ')[0];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(m.attendanceCount.toString()),
                  ),
                  title: Text(m.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${m.plan} • ${m.phone}'),
                      const SizedBox(height: 4),
                      FutureBuilder<bool>(
                        future: Provider.of<MemberProvider>(
                          context,
                          listen: false,
                        ).isMemberPaid(m),
                        builder: (context, snap) {
                          if (!snap.hasData) return const SizedBox.shrink();
                          return Text(
                            snap.data! ? 'Paid' : 'Pending',
                            style: TextStyle(
                              color: snap.data! ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(joinDate),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () async {
                          if (m.id == null) return;
                          await Provider.of<MemberProvider>(
                            context,
                            listen: false,
                          ).incrementAttendance(m.id!);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          if (m.id == null) return;
                          await Provider.of<MemberProvider>(
                            context,
                            listen: false,
                          ).decrementAttendance(m.id!);
                        },
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => MemberDetails(member: m)),
                  ),
                );
              },
            ),
    );
  }
}
