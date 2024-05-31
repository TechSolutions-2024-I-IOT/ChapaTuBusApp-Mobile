import 'package:flutter/material.dart';

class LineBusesView extends StatefulWidget {
  static const name = 'Line of buses';
  static String getViewName() => name;
  const LineBusesView({super.key});

  @override
  LineBusesViewState createState() => LineBusesViewState();
}

class LineBusesViewState extends State<LineBusesView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView( // Agrega SingleChildScrollView
              scrollDirection: Axis.horizontal, // Para scroll horizontal
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildFilterButton('Todos', 0),
                  _buildFilterButton('Autobús', 1),
                  _buildFilterButton('Corredor', 2),
                  _buildFilterButton('Metro', 3),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.blue[300],
            child: const Row(
              children: <Widget>[
                Text(
                  'Recientes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildBusLineTile('[AN16]', 'Los Olivos'),
                _buildBusLineTile('[AS04]', 'Villa El Salvador'),
                _buildBusLineTile('[CR07]', 'Callao - La Perla'),
                _buildBusLineTile('[OM09]', 'Callao - Lima'),
                _buildBusLineTile('[CR51]', 'Comas - San Miguel'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  color: Colors.blue[300],
                  child: const Row(
                    children: <Widget>[
                      Text(
                        'Corredor azul',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBusLineTile('[301]', 'Rímac - Barranco'),
                _buildBusLineTile(
                    '[303]', 'San Juan de Lurigancho - Miraflores'),
                _buildBusLineTile('[305]', 'Rímac - Miraflores'),
              ],
            ),
          ),
        ],
    );
  }

  Widget _buildFilterButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
        // Add your filtering logic here based on the index
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedIndex == index ? Colors.blue[300] : Colors.grey[300],
        foregroundColor: _selectedIndex == index ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
      child: Text(
        text,
      ),
    );
  }

  Widget _buildBusLineTile(String code, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            code,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(name),
        ],
      ),
    );
  }
}