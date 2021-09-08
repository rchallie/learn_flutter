import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/identify.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Amplitude analytics = Amplitude.getInstance(instanceName: "test");

  @override
  initState() {
    super.initState();
    exampleForAmplitude();
  }

  Future<void> exampleForAmplitude() async {
    // Create the instance
    

    // Initialize SDK
    await analytics.init(""); //API KEY !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    // Log an event
    await analytics.logEvent('SUPER_TEST', eventProperties: {
      'integer_test': 10,
      'bool_test': true
    });

    await analytics.uploadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LandingPage(analytics),
        '/registration': (context) => Registration(analytics),
        '/board': (context) => Board(analytics),
      }
    );
  }
}

class LandingPage extends StatelessWidget {

  LandingPage(this.analytics);

  final Amplitude analytics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            children: [
              Container(
                height: 100,
                child: Text('Welcome to amplitude test', style: Theme.of(context).textTheme.headline2),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/registration'); 
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                child: Text('Registration'),
              )
            ],
          ),
        ),
      )
    );
  }
}

class Board extends StatelessWidget {

  final Amplitude analytics;

  Board(this.analytics) {
    //Amplitude.getInstance().trackingSessionEvents(false);
    print("Flush");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            children: [
              Container(
                child: Text("End. Flushed.", style: Theme.of(context).textTheme.headline2)
              ),
            ],
          )
        ),
      ),
    );
  }
}

class RegistrationInput extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  RegistrationInput({
    required this.text,
    required this.controller,
  });

  @override
  _RegistrationInput createState() => _RegistrationInput();
}

class _RegistrationInput extends State<RegistrationInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.text),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(hintText: widget.text),
        ),
      ],
    );
  }
}

class Registration extends StatefulWidget {

  Registration(this.analytics);
  final Amplitude analytics;

  @override
  _Registration createState() => _Registration();
}

class _Registration extends State<Registration> {

  // User
  Identify identify = Identify();

  final _genderTextController = TextEditingController();
  final _ageTextController = TextEditingController();
  final _foodTextController = TextEditingController();
  final _animalTextController = TextEditingController();

  late int step;
  late String text;
  late TextEditingController actifController;
  
  _Registration() {
    step = 0;
    text = "Gender";
    actifController = _genderTextController;
    //widget.analytics.trackingSessionEvents(true);
    //widget.analytics.setUserId("test_user_id");
  }

  void _nextStep() {
 
    String _text = text;
    TextEditingController _actifController = actifController;

    switch (step + 1) {
      case 1:
        _text = "Age";
        identify.set('gender', _actifController.value);
        _actifController = _ageTextController;
        break;
      case 2:
        _text = "Favorite food";
        identify.set('age', _actifController.value);
        _actifController = _foodTextController;
        break;
      case 3:
        _text = "Dog or cat ?";
        identify.set('favorite_food', _actifController.value);
        _actifController = _animalTextController;
        break;
    }

    if (step + 1 >= 4)
    {
      identify.set('dog_cat', _actifController.value);
      Navigator.of(context).pushNamed('/board');
      return;
    }

    setState(() {
      step += 1;
      text = _text;
      actifController = _actifController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          child: Column(
            children: [
              Container(
                height: 100,
                child: Text("Registration ($step)", style: Theme.of(context).textTheme.headline2)
              ),
              SizedBox(
                width: 400,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RegistrationInput(text: text, controller: actifController,),
                ),
              ),
              ElevatedButton(
                onPressed: () { widget.analytics.logEvent('BUTTON_CLICKED', eventProperties: {"step": step, "text": text}); widget.analytics.uploadEvents(); _nextStep(); },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                child: Text('Next step'),
              )
            ],
          ),
        )
      ),
    );
  }
}
