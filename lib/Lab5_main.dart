import 'package:flutter/material.dart';
import 'widgets/MyStatefulWidget.dart';
import 'widgets/MyStatelessWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programowanie Mobilne',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent.shade400),
      ),
      home: const MyHomePage(title: 'Programowanie Mobilne'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
            fontFamily: 'Playwrite',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('A'),
                const Text('B'),
                const Text('C'),
              ],
            ),

            MyStatelessWidget(),
            const SizedBox(height: 20),

            MyStatefulWidget(),
            const SizedBox(height: 40),

            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 20),

            const Text('To jest tekst z dodaną czcionką', style: TextStyle(fontFamily: 'Playwrite', fontSize: 18),),
            const Text('Adrian'),

            const SizedBox(height: 40),
            ElevatedButton(onPressed: () {
              print('Przycisk został kliknięty!');
            },
              child: const Text('Kliknij mnie'),
            ),
            Container(
              width: 200,
              height: 100,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Center(
                child: Text('To jest kontener'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(color: Colors.red, height: 50),
                ),
                Expanded(
                  flex: 5,
                  child: Container(color: Colors.blue, height: 50),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.deepPurple,
                    height: 50,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton został kliknięty!');
        },
        tooltip: 'Dodaj',
        child: const Icon(Icons.add),
      ),
    );
  }
}
