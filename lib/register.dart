// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_care_system/shared/constant.dart';
import 'main.dart';

void main() {
  runApp(const Register());
}

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register New Plant',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.green),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are sure to exit?'),
                  content: const Text(
                      'You will lose your input data once you close this page.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                        );
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          title: const Text('Register New Plant',
              style: TextStyle(color: Color.fromARGB(255, 14, 199, 70))),
          elevation: 0,
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  var plantName = '';
  var plantVariety = '';
  var plantSpecie = '';
  var plantAge = 0;
  var plantHeight = 0;
  var numOfLeaves = 0;
  var shortDesc = '';

  final _formKey = GlobalKey<FormState>();
  List<String> varieties = [
    'Alocasia',
    'Anthurium',
    'Calathea',
    'Monstera',
    'Philodendron',
    'Rhaphidophora'
  ];
  List<String> alocasiaSpecies = [
    'Alocasia Azlanii',
    'Alocasia Black Velvet',
    'Alocasia Lutea Golden',
    'Alocasia Pink Dragon',
    'Alocasia Polly',
    'Alocasia Purple Sword'
  ];
  List<String> anthuriumSpecies = [
    'Anthurium Big and Bold',
    'Anthurium Pink',
    'Anthurium Red',
    'Anthurium Ruffles'
  ];
  List<String> calatheaSpecies = [
    'Calathea Beauty Star',
    'Calathea Dottie',
    'Calathea Freddie',
    'Calathea Medallion',
    'Calathea Misto',
    'Calathea Musaica',
    'Goeppertia orbifolia',
    'Calathea Peacock',
    'Calathea Pinstripe',
    'Calathea Rattlesnake',
    'Calathea Rosy Roseo',
    'Calathea Vittata',
    'Calathea White Flame',
    'Calathea Zebra'
  ];
  List<String> monsteraSpecies = [
    'Monstera',
    'Monstera Adansonii',
    'Monstera sp. (Peru)',
    'Monstera Dubia'
  ];
  List<String> philodendronSpecies = [
    'Philodendron Birkin',
    'Philodendron Brandi',
    'Philodendron Brasil',
    'Philodendron Heartleaf',
    'Philodendron Hope Selloum',
    'Philodendron Lemon Lime',
    'Philodendron Little Hope',
    'Philodendron Micans Velvet',
    'Philodendron Pink Princess',
    'Philodendron Prince of Orange',
    'Philodendron Shangri La',
    'Philodendron Velvet',
    'Philodendron Xanadu'
  ];
  List<String> rhaphidophoraSpecies = ['Rhaphidophora'];
  List<String> species = [];
  String? _selectedVarieties;
  String? _selectedSpecies;

  @override
  Widget build(BuildContext context) {
    CollectionReference plants =
        FirebaseFirestore.instance.collection('PLANTS');
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//Plant Name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Plant Name',
                    hintText: 'ex. Plant 1, Anthurium 1, etc...',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    plantName = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Plant Variety',
                    hintText: 'Select Plant Variety',
                  ),
                  value: _selectedVarieties,
                  items: varieties.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (varieties) {
                    if (varieties == 'Alocasia') {
                      species = alocasiaSpecies;
                    } else if (varieties == 'Anthurium') {
                      species = anthuriumSpecies;
                    } else if (varieties == 'Calathea') {
                      species = calatheaSpecies;
                    } else if (varieties == 'Monstera') {
                      species = monsteraSpecies;
                    } else if (varieties == 'Philodendron') {
                      species = philodendronSpecies;
                    } else if (varieties == 'Rhaphidophora') {
                      species = rhaphidophoraSpecies;
                    } else {
                      species = [];
                    }
                    setState(() {
                      _selectedSpecies = null;
                      _selectedVarieties = varieties;
                    });
                    plantVariety = varieties!;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Plant Specie',
                    hintText: 'Select Plant Specie',
                  ),
                  value: _selectedSpecies,
                  items: species.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? specie) {
                    setState(() {
                      plantSpecie = specie!;
                    });
                  },
                ),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty.';
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Plant Height (inches)',
                        hintText: 'Enter plant height',
                      ),
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontFamily: 'AvenirLight'),
                      onChanged: (value) {
                        plantHeight = int.parse(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 32, 8),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty.';
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Plant Age (months)',
                        hintText: 'Enter plant age',
                      ),
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontFamily: 'AvenirLight'),
                      onChanged: (value) {
                        plantAge = int.parse(value);
                      },
                    ),
                  ),
                ),
              ]),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Number of Leaves',
                    hintText: 'Count the number of leaves',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    numOfLeaves = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  maxLines: 4,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Short Description',
                    hintText: 'Tell something about your plant...',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    shortDesc = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                      child: const Text(
                        'Save and Generate QR Code',
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
                              vertical: 20, horizontal: 50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                        plants
                            .add({
                              'Plant_Name': plantName,
                              'Plant_Variety': plantVariety,
                              'Plant_Specie': plantSpecie,
                              'Plant_Height': plantHeight,
                              'Plant_Age': plantAge,
                              'Num_of_Leaves': numOfLeaves,
                              'Short_Desc': shortDesc,
                            })
                            .then((value) => print('User is added'))
                            .catchError(
                                (error) => print('Failed to add user: $error'));
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
