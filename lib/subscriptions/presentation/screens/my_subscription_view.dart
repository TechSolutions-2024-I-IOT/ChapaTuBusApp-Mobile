import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MySubscriptionView extends StatelessWidget {
  const MySubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi suscripción'),
        leading: IconButton(
          icon: const Icon( Icons.arrow_back_ios ), 
          onPressed: () {
            context.go('/home/3');
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubscriptionItem(
                icon: Icons.directions_bus,
                title: 'Premium',
                status: 'Activo',
                color: Colors.blue[100]!,
                iconColor: Colors.blue,
                onTap: () {
                  context.go('/home/3/subscriptions/description-plan');
                },
              ),
              const SizedBox(height: 16),
              _buildSubscriptionItem(
                icon: Icons.search,
                title: 'Ver planes disponibles',
                subtitle: 'Premium, Estudiantes',
                color: Colors.white,
                iconColor: Colors.grey,
                onTap: () {
                  context.go('/home/3/subscriptions/plans-available');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 Widget _buildSubscriptionItem({
    required IconData icon,
    required String title,
    String status = '',
    String subtitle = '',
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: iconColor,
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (status.isNotEmpty)
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }