import 'package:flutter/material.dart';

main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: Scaffold(
        body: Row(
          children: [
            Expanded (
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.red,
                child: Column(

                ),
              ),
            ),
            Expanded (
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.red,
                child: Column(

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}