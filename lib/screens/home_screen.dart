import 'package:flutter/material.dart';
import 'package:project1/screens/SecondScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SecondScreen()
                ),
              );
            },
            child: const Text('Idź do drugiego ekranu'),
          ),

          const SizedBox(height: 40,),

          ListTile(
            title: const Text('Anna'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecondScreen(name: 'Anna'),
                ),
              );
            },
          )
        ]
      ),
    );
  }
}