import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_care_system/scanner.dart';
import 'register.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final appTitle = 'Plant App';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.green),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: <Color>[
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ]))),
          title: const Text('Home',
              style: TextStyle(color: Color.fromARGB(255, 14, 199, 70))),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 10, 190, 85),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 55.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                        Color.fromARGB(255, 20, 180, 68),
                        Color.fromARGB(255, 20, 180, 68)
                      ])),
                  child: null,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home,
                    color: Color.fromARGB(255, 255, 255, 255)),
                title: const Text('Home',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.library_books,
                    color: Color.fromARGB(255, 255, 255, 255)),
                title: const Text('Supported Plants',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.construction,
                    color: Color.fromARGB(255, 255, 255, 255)),
                title: const Text('How It Works',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.info,
                    color: Color.fromARGB(255, 255, 255, 255)),
                title: const Text('About',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 500),
                  ElevatedButton(
                    child: const Text(
                      'Scan QR Code',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: const Color.fromARGB(255, 18, 189, 75),
                        elevation: 20,
                        minimumSize: const Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 110)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlantScanner()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text(
                      'Register A Plant',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: const Color.fromARGB(255, 18, 189, 75),
                        elevation: 20,
                        minimumSize: const Size(250, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 100)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                  ),
                ]),
          ),
        ));
  }
}
