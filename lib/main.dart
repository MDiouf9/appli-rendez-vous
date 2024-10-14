import 'package:flutter/material.dart';
import 'package:new_dance/Pages/Inscription.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';





void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: const HomePage(), // Utilisation d'un widget HomePage séparé
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/RVS 1.png',
              height: 140,
              width: 140,
            ),
            const Text(
              "RENDEZ-VOUS",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Image.asset(
              'assets/images/amico.png',
              height: 220,
              width: 220,
            ),
            SizedBox(
              height: 35,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Inscription()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1998D3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text(
                  'Commencer',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
