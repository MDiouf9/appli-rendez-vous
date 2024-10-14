import 'package:flutter/material.dart';
import 'package:new_dance/Pages/PatientsPage.dart';
import 'package:new_dance/Pages/RendezVousPage.dart';



class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    'assets/images/001-left-arrow.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Retour à la page précédente
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/images/menu.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    // Action à réaliser lors de l'appui sur le bouton du menu
                  },
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    'assets/images/text.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    // Action à réaliser lors de l'appui sur ce bouton
                  },
                ),
                const CircleAvatar(
                  
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/Ellipse 1.jpg'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'Bienvenu ! Docteur',
              style: TextStyle(fontSize: 24, color: Color(0xFF1998D3)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Nombre de colonnes
                crossAxisSpacing: 10.0, // Espacement horizontal entre les items
                mainAxisSpacing: 10.0, // Espacement vertical entre les items
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  _buildGridItem('Liste des Rendez-vous', Color(0XFF1998D3), context, RendezVousPage()),
                  _buildGridItem('Liste des Patients', Color(0XFF008E5B), context, PatientsPage()),
                  _buildGridItem('Liste des Rendez-vous', Color(0XFFb2F2F2F), context, RendezVousPage()),
                  _buildGridItem('Liste des Patients', Color(0XFFb8EDBFF), context, PatientsPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String text, Color color, BuildContext context, Widget page) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Row contenant le carré et le cercle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Carré
              Container(
                width: 30,
                height: 30,
                color: Colors.white,
                child: Center(
                  child: const Text(
                    '98',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 0),
              // Cercle avec image
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/RVS 1.png'), // Remplacez par votre image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Texte avec bouton
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page)); // Navigation vers une autre page
            },
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
