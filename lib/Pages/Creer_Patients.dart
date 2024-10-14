import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class CreerPatients extends StatefulWidget {
  const CreerPatients({super.key});

  @override
  State<CreerPatients> createState() => _CreerPatientsState();
}

class _CreerPatientsState extends State<CreerPatients> {
  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  final ageController = TextEditingController();
  final adresseController = TextEditingController();
  final telephoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire

  void _submitForm() async {
    if (_formKey.currentState!.validate()) { // Validation du formulaire
      String prenom = prenomController.text;
      String nom = nomController.text;
      int age = int.parse(ageController.text);
      String adresse = adresseController.text;
      int telephone = int.parse(telephoneController.text);

      try {
        await FirebaseFirestore.instance.collection('patients').add({
          'prenom': prenom,
          'nom': nom,
          'age': age,
          'adresse': adresse,
          'telephone': telephone,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient ajouté avec succès')),
        );

        // Effacer les champs après l'ajout
        prenomController.clear();
        nomController.clear();
        ageController.clear();
        adresseController.clear();
        telephoneController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'ajout : $e')),
        );
      }
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
            IconButton(
              icon: Image.asset(
                'assets/images/001-left-arrow.png',
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, // Utiliser la clé pour le formulaire
            child: SingleChildScrollView( // Ici
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF8EDBFF),
                    radius: 80,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Champ pour le prénom
                  TextFormField(
                    controller: prenomController,
                    decoration: const InputDecoration(
                      hintText: 'Prenom',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un prénom';
                      }
                      return null; // Valide
                    },
                  ),
                  const SizedBox(height: 20),
                  // Champ pour le nom
                  TextFormField(
                    controller: nomController,
                    decoration: const InputDecoration(
                      hintText: 'Nom',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom';
                      }
                      return null; // Valide
                    },
                  ),
                  const SizedBox(height: 20),
                  // Champ pour l'âge
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un âge';
                      }
                      // Vérifier si l'âge est un entier
                      if (int.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide pour l\'âge';
                      }
                      return null; // Valide
                    },
                  ),
                  const SizedBox(height: 20),
                  // Champ pour l'adresse
                  TextFormField(
                    controller: adresseController,
                    decoration: const InputDecoration(
                      hintText: 'Adresse',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une adresse';
                      }
                      return null; // Valide
                    },
                  ),
                  const SizedBox(height: 20),
                  // Champ pour le téléphone
                  TextFormField(
                    controller: telephoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Téléphone',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un numéro de téléphone';
                      }
                      // Vérifier si le téléphone est un entier
                      if (int.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide pour le téléphone';
                      }
                      return null; // Valide
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity, // Ajuster à la largeur de l'écran
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1998D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: _submitForm,
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
        ),
      ),
    );
  }
}
