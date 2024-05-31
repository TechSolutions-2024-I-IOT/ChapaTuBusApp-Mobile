import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlansAvailableView extends StatelessWidget {
  const PlansAvailableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Planes disponibles',
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
              _buildPlanCard(
                planName: 'Premium',
                features: [
                  '1 cuenta Premium',
                  'Navega sin anuncios',
                  'Añade cuantas líneas quieras a tus\nfavoritos',
                  'Recibe notificaciones de tus líneas\nfavoritas',
                  'Información actualizada sobre el\nestado de los próximos buses más\ncercanos a tu ubicación',
                ],
              ),
              const SizedBox(height: 16),
              _buildPlanCard(
                planName: 'Estudiantes',
                features: [
                  '1 cuenta Premium verificada',
                  'Descuento para estudiantes',
                  'Navega sin anuncios',
                  'Añade hasta 5 líneas a tus favoritos',
                  'Información actualizada sobre el estado de los\npróximos buses más cercanos a tu ubicación',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPlanCard({
    required String planName,
    required List<String> features,
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
            planName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map((feature) => Text(
                      '• $feature',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }