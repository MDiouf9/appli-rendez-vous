import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_dance/Pages/Creer_rendezvous.dart';

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({super.key});

  @override
  State<RendezVousPage> createState() => _RendezVousPageState();
}

class _RendezVousPageState extends State<RendezVousPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Ajouter un peu de marge autour du champ de texte
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: const Color(0XFF2F2F2F), // Définir la couleur de fond en gris foncé
                borderRadius: BorderRadius.circular(20.0), // Coins arrondis
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Rechercher',
                  hintStyle: TextStyle(color: Colors.white), // Couleur du texte de l'indice
                  prefixIcon: Icon(Icons.search, color: Colors.white), // Icône de recherche
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  border: InputBorder.none, // Supprimer la bordure par défaut
                ),
                style: const TextStyle(color: Colors.white), // Couleur du texte
              ),
            ),
            const SizedBox(height: 40), // Espacement entre les éléments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Mes Rendez-vous',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Personnalisation du style du texte
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreerRendezvous()));
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Color(0xFF1998D3), // Couleur de l'icône
                    size: 24, // Taille de l'icône
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.black,
              thickness: 2, // Épaisseur du séparateur
              indent: 40, // Marges du séparateur à gauche
              endIndent: 0, // Marges du séparateur à droite
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('rendezvous').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var documents = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length, // Nombre d'éléments à afficher
                    itemBuilder: (context, index) {
                      var rendezVous = documents[index].data() as Map<String, dynamic>;

                      // Utilisation de valeurs par défaut si les données sont nulles
                      String date = rendezVous['date'] ?? 'Date non spécifiée';
                      String heure = rendezVous['heure'] ?? 'Heure non spécifiée';
                      String titre = rendezVous['titre'] ?? 'Nom non spécifié';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Date: $date',
                                          style: const TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                        Text(
                                          'Heure: $heure',
                                          style: const TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          titre,
                                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('rendezvous')
                                                .doc(documents[index].id)
                                                .delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (index < documents.length - 1)
                            const Divider(
                              color: Colors.black,
                              thickness: 2,
                              indent: 40,
                              endIndent: 0,
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
