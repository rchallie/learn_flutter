import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyCounter()),
    ],
    child: MyApp(),
  ),
);

class MyCounter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: Scaffold(
        body: Center(
          child: Container(
            height: 150,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text("${context.watch<MyCounter>().count}"),
                ),
                FloatingActionButton(
                  onPressed: () => context.read<MyCounter>().increment(),
                  child: Icon(Icons.plus_one),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}