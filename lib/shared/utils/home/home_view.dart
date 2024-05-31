import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  static const name = 'Home';
  static String getViewName() => name;
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onTap: () {
                context.go('/home/0/search');
              },
              decoration: InputDecoration(
                hintText: 'Busca una linea',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 1.0,
                  ),
                ),
                filled: true,
                fillColor: const Color.fromARGB(
                    255, 249, 246, 246), // Light grey background
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0), // Add vertical padding
            child: Container(
              height: 130.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://elcomercio.pe/resizer/cQldVjFH-mDVWbJHJ2SqWAjsaI8=/580x330/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/3UV4OIX2A5BTRDHLKF3QLWOUHA.jpg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  'Empieza tu prueba gratuita',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Líneas frecuentes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: busLines.length,
              itemBuilder: (context, index) {
                return BusLineCardHome(busLine: busLines[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BusLine {
  final int id;
  final String code;
  final String name;
  final String imagePath;

  BusLine({
    required this.id,
    required this.code,
    required this.name,
    required this.imagePath,
  });
}

final List<BusLine> busLines = [
    BusLine(
      id: 1,
      code: '[209]',
      name: 'Ate - San Miguel',
      imagePath:
          'https://upload.wikimedia.org/wikipedia/commons/5/59/Linea_7_-_Lima.jpg',
    ),
    BusLine(
      id: 2,
      code: '[CR71]',
      name: 'Ate - San Martin de Porres',
      imagePath:
          'https://upload.wikimedia.org/wikipedia/commons/5/59/Linea_7_-_Lima.jpg',
    ),
    BusLine(
      id: 3,
      code: '[CR07]',
      name: 'Callao - La Perla',
      imagePath:
          'https://upload.wikimedia.org/wikipedia/commons/5/59/Linea_7_-_Lima.jpg',
    ),
  ];

class BusLineCardHome extends StatelessWidget {
  final BusLine busLine;

  const BusLineCardHome({super.key, required this.busLine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/home/1/line/${busLine.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          color: Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(busLine.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        busLine.code,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: busLine.name,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
