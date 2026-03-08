import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAdminCategory(
            context,
            title: 'Expense Management',
            subtitle: 'Add or modify expense records',
            icon: LucideIcons.receipt,
            color: Colors.orangeAccent,
            onTap: () => context.push('/add_expenses'),
          ),
          const SizedBox(height: 16),
          _buildAdminCategory(
            context,
            title: 'Workout Database',
            subtitle: 'Manage exercises and workout history',
            icon: LucideIcons.dumbbell,
            color: Colors.blueAccent,
            onTap: () => context.push('/workouts'),
          ),
          const SizedBox(height: 16),
          _buildAdminCategory(
            context,
            title: 'Weight Records',
            subtitle: 'View and edit weight logs',
            icon: LucideIcons.scale,
            color: Colors.greenAccent,
            onTap: () => context.push('/health'),
          ),
          const SizedBox(height: 16),
          _buildAdminCategory(
            context,
            title: 'User Profile',
            subtitle: 'Manage app security and bio',
            icon: LucideIcons.user,
            color: Colors.purpleAccent,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCategory(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(LucideIcons.chevronRight, size: 16),
        onTap: onTap,
      ),
    );
  }
}
