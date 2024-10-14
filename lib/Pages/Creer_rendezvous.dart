import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CreerRendezvous extends StatefulWidget {
  const CreerRendezvous({super.key});

  @override
  State<CreerRendezvous> createState() => _CreerRendezvousState();
}

class _CreerRendezvousState extends State<CreerRendezvous> {
  final titreController = TextEditingController();
  final contactController = TextEditingController();
  final dateController = TextEditingController();
  final heureController = TextEditingController();
  final lieuController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Met à jour le champ de texte avec la date sélectionnée
      dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate); // Formatage de la date
    }
  }

  void _submitForm() async {
    String titre = titreController.text;
    String contact = contactController.text;
    String date = dateController.text; // Utilisation de dateController.text
    String heure = heureController.text; // Correction ici
    String lieu = lieuController.text;

    try {
      await FirebaseFirestore.instance.collection('rendezvous').add({
        'titre': titre,
        'contact': contact,
        'date': date,
        'heure': heure,
        'lieu': lieu,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rendez-vous ajouté avec succès')),
      );

      // Nettoyer les champs
      titreController.clear();
      contactController.clear();
      dateController.clear();
      heureController.clear();
      lieuController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ajout : $e')),
      );
    }
  }

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
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Color(0xFF8EDBFF),
                radius: 80,
                backgroundImage: AssetImage('assets/images/RVS 1.png'),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    children: [
                      // Champ pour le titre du rendez-vous
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: titreController,
                          decoration: const InputDecoration(
                            hintText: 'Titre rendez-vous',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      // Champ pour le contact
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: contactController,
                          decoration: const InputDecoration(
                            hintText: 'AVEC QUI ?',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      // Champ pour la date
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () => _selectDate(context), // Ouvre le sélecteur de date
                          child: AbsorbPointer( // Évite que l'utilisateur tape directement dans le champ
                            child: TextField(
                              controller: dateController,
                              decoration: const InputDecoration(
                                hintText: 'Date Rendez-vous',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Champ pour l'heure
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: heureController,
                          decoration: const InputDecoration(
                            hintText: 'Heure Rendez-vous',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      // Champ pour le lieu
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: lieuController,
                          decoration: const InputDecoration(
                            hintText: 'Lieu Rendez-vous',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      // Bouton pour enregistrer le rendez-vous
                      SizedBox(
                        height: 50,
                        width: 370,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1998D3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onPressed: _submitForm, // Appel de la méthode pour soumettre le formulaire
                          child: const Text(
                            "Enregistrer",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 