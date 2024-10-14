import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_dance/Pages/Connexion.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  // Contrôleurs pour les champs de texte
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();

  Future<void> _submitForm() async {
    String nom = nomController.text;
    String prenom = prenomController.text;
    String email = emailController.text;
    String motDePasse = motDePasseController.text;

    // Validation simple des champs
    if (email.isEmpty || motDePasse.isEmpty) {
      // Afficher un message d'erreur si les champs sont vides
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    try {
      // Inscription avec email et mot de passe
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: motDePasse,
      );

      // Si l'inscription réussit, navigue vers la page de connexion
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Connexion()),
      );

      // Optionnel : Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscription réussie')),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Le mot de passe est trop faible')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Un compte existe déjà pour cet email')),
        );

        // Rediriger vers la page de connexion
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Connexion()),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email invalide')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${e.message}')),
        );
      }
    } catch (e) {
      // Gestion des erreurs générales
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur inattendue : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/RVS 1.png'),
                const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                const SizedBox(height: 10),
                // Champ pour le nom
                _buildTextField(nomController, 'Nom'),
                // Champ pour le prénom
                _buildTextField(prenomController, 'Prénom'),
                // Champ pour l'email
                _buildTextField(emailController, 'Email'),
                // Champ pour le mot de passe
                _buildTextField(motDePasseController, 'Mot de passe', obscureText: true),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: 320,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1998D3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Bouton pour aller à la page de connexion
                SizedBox(
                  height: 50,
                  width: 320,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1998D3), // Même couleur que le bouton d'inscription
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Connexion()),
                      );
                    },
                    child: const Text(
                      "Déjà un compte ? Se connecter",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
