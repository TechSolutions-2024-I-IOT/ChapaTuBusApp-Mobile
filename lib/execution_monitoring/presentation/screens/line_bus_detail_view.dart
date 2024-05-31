import 'package:cached_network_image/cached_network_image.dart';
import 'package:chapa_tu_bus_app/shared/utils/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LineBusDetailView extends StatefulWidget {
  static const name = 'LineBusDetail';
  static String getViewName() => name;
  final int lineId;
  const LineBusDetailView({super.key, required this.lineId});

  @override
  State<LineBusDetailView> createState() => _LineBusDetailViewState();
}

class _LineBusDetailViewState extends State<LineBusDetailView> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final busLine = busLines.firstWhere((line) => line.id == widget.lineId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home/0'),
        ),
        title: Text(busLine.code),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: busLine.imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          busLine.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(busLine.code),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CachedNetworkImage(
                imageUrl: busLine.imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              const Text('Paradero: Plaza Norte',
                  style: TextStyle(fontSize: 16)),
              const Text('Tiempo próximo de llegada: 4 minutos',
                  style: TextStyle(fontSize: 16)),
              const Text('Aforo: 15/30 (50%)', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acción para ver próximos buses
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Ver próximos buses'),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
