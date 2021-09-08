import 'package:flutter/material.dart';

main() => runApp(MyApp());

final Future<String> _futureString = Future<String>.delayed(
  const Duration(seconds: 2),
  () => "Super ça fonctionne"
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: Scaffold(
        body: Center(
          child: Container(
            height: 50,
            child: Column(
              children: [
                Text("Et du coup:"),
                FutureBuilder(
                  future: _futureString,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    Text toprint;
                    if (snapshot.hasData)
                    {
                      toprint = Text("${snapshot.data}");
                    }
                    else if (snapshot.hasError)
                    {
                      toprint = Text("Ca bug");
                    }
                    else
                    {
                      toprint = Text("Ca charge");
                    }
                    return toprint;
                  }
                ),
              ],
            )
          )
        )
      ),
    );
  }
}