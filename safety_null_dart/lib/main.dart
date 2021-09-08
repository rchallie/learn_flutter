import 'package:flutter/material.dart';

main() => runApp(MyApp());

class Meal {
  late String _description;

  set description(String desc) {
    _description = 'Meal description: $desc';
  }

  String get description => _description;
}

class Team {
  late final Coach coach;
}

class Coach {
  late final Team team;
}

int _computeValue() {
  print('In _computeValue...');
  return 3;
}

class CachedValueProvider {
  final _cache = _computeValue();
  int get value => _cache;
}

class MyApp extends StatelessWidget {

  // Non-nullable type
  void non_nullable()
  {
    int a;
    a = 145;
    print('a is $a.');
  }

  // Nullable type
  void nullable()
  {
    int? a;
    a = null;
    print('a is $a');
  }

  void nullable_generic()
  {
    List<String> aListOfStrings = ['one', 'two', 'three'];
    List<String>? aNullableListOfStrings;
    List<String?> aListOfNullableStrings = ['one', null, 'three'];

    print('aListOfStrings is $aListOfStrings.');
    print('aNullableListOfStrings is $aNullableListOfStrings.');
    print('aListOfNullableStrings is $aListOfNullableStrings.');
  }

  int? couldReturnNullButDoesnt() => -3;

  void null_assertion()
  {
    int? couldBeNullButIsnt = 1;
    List<int?> listThatCouldHoldNulls = [2, null, 4];

    int a = couldBeNullButIsnt;
    int b = listThatCouldHoldNulls.first!; // first item in the list
    int c = couldReturnNullButDoesnt()!.abs(); // absolute value

    print('a is $a.');
    print('b is $b.');
    print('c is $c.');
  }

  void definite_assignment()
  {
    String text;

    if (DateTime.now().hour < 12) {
      text = "It's morning! Let's make aloo paratha!";
    } else {
      text = "It's afternoon! Let's make biryani!";
    }

    print(text);
    print(text.length);
  }

  void null_checking()
  {
    int getLength(String? str) {
      // Add null check here

      if (str == null)
      {
         return 0;
      }
      return str.length;
    }

    print(getLength("This is a string!"));
  }

  void promotion_exeptions()
  {
    int getLength(String? str) {
      // Try throwing an exception here if `str` is null.

      if (str == null)
      {
        throw("NULL string");
      }
      return str.length;
    }

    print(getLength(null));
  }

  void using_late()
  {
    final myMeal = Meal();
    myMeal.description = 'Feijoada!';
    print(myMeal.description);
  }

  void late_circular_reference()
  {
    final myTeam = Team();
    final myCoach = Coach();
    myTeam.coach = myCoach;
    myCoach.team = myTeam;

    print('All done!');
  }

  void late_lazy()
  {
    print('Calling constructor...');
    var provider = CachedValueProvider();
    print('Getting value...');
    print('The value is ${provider.value}!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: Scaffold(
        body: Center(
          child: Container(
            height: 300,
            width: 450,
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Non_nullable"),
                    FloatingActionButton(
                      onPressed: non_nullable,
                      child: Icon(Icons.radar),
                    ),
                    Text("Nullable"),
                    FloatingActionButton(
                      onPressed: nullable,
                      child: Icon(Icons.mode_night_outlined),
                    ),
                    Text("Nullable_generic"),
                    FloatingActionButton(
                      onPressed: nullable_generic,
                      child: Icon(Icons.museum_outlined),
                    ),
                    Text("Nullable_assertion"),
                    FloatingActionButton(
                      onPressed: null_assertion,
                      child: Icon(Icons.navigate_before_sharp),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Definite_assignment"),
                    FloatingActionButton(
                      onPressed: definite_assignment,
                      child: Icon(Icons.yard_outlined),
                    ),
                    Text("Null_checking"),
                    FloatingActionButton(
                      onPressed: null_checking,
                      child: Icon(Icons.zoom_in),
                    ),
                    Text("Promotion_exceptions"),
                    FloatingActionButton(
                      onPressed: promotion_exeptions,
                      child: Icon(Icons.voicemail_outlined),
                    ),
                    Text("Using_late"),
                    FloatingActionButton(
                      onPressed: using_late,
                      child: Icon(Icons.view_compact),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Late_reference"),
                    FloatingActionButton(
                      onPressed: late_circular_reference,
                      child: Icon(Icons.video_settings),
                    ),
                    Text("Late_lazy"),
                    FloatingActionButton(
                      onPressed: late_lazy,
                      child: Icon(Icons.vertical_align_center_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}