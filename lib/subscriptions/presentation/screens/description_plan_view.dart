import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DescriptionPlanView extends StatelessWidget {
  const DescriptionPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Descripción general\ndel plan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () {
            context.go('/home/3/subscriptions');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlanInfoCard(
                icon: Icons.directions_bus,
                planName: 'Premium',
                status: 'Activo',
                renewalDate: '20/05/24',
                color: Colors.blue[100]!,
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 16),
              _buildPlanDetailsCard(
                title: 'Esto es lo que incluye el plan',
                details: [
                  '1 cuenta Premium',
                  'Navega sin anuncios',
                  'Añade cuantas líneas quieras a tus favoritos',
                  'Recibe notificaciones de tus líneas favoritas',
                  'Información actualizada sobre el estado de\nlos próximos buses más cercanos a tu\nubicación',
                ],
                buttonText: 'Ver todos los planes', 
                onPressed: () { 
                  context.go('/home/3/subscriptions/plans-available');
                },
              ),
            ],
          ),
        ),
      ),);
  }
}

Widget _buildPlanInfoCard({
    required IconData icon,
    required String planName,
    required String status,
    required String renewalDate,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
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
                  planName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu plan actual se renueva el\n$renewalDate',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanDetailsCard({
    required String title,
    required List<String> details,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
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
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details
                .map((detail) => Text(
                      '• $detail',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC4B5FD),
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

