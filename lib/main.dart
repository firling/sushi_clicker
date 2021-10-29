import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sushi Clicker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sushi Clicker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _autoClicker = 0;
  int _counterIncrementVar = 1;
  Map<String, int> prices = {
    'autoClicker': 50,
    'clickerMultiplicator': 8
  };


  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) { _incrementCounterTimer(); });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter += _counterIncrementVar;
    });
  }

  void _incrementCounterTimer() {
    setState(() {
      _counter += _autoClicker;
    });
  }

  void _buyAugment(String augment) {
    if (prices[augment] != null && prices[augment]! <= _counter) {
      setState(() {
        _counter -= prices[augment]!;
        _autoClicker++;
        prices[augment] = (prices[augment]! * 1.25).toInt();
      });
    }
  }

  void _buyClickMultiplicator() {
    if (prices["clickerMultiplicator"] != null && prices["clickerMultiplicator"]! <= _counter) {
      setState(() {
        _counter -= prices["clickerMultiplicator"]!;
        _counterIncrementVar++;
        prices["clickerMultiplicator"] = (prices["clickerMultiplicator"]! * 1.25).toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 500,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://screenshot.anquetil.org/static/1x3au.jpg"
                  ),
                  fit: BoxFit.cover
              )
          ),

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.

          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  Text(
                    '+$_autoClicker/s',
                    style: GoogleFonts.mcLaren(),
                  )
                ]
              ),
              const Spacer(),
              IconButton(
                onPressed: _incrementCounter,
                iconSize: 300,
                icon: Image.network(
                  "https://screenshot.anquetil.org/static/qn7yyy.png",
                ),
              ),
              const Spacer(),

              Row(
                children: <Widget> [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      IconButton(
                        onPressed: () => _buyAugment("autoClicker"),
                        iconSize: 50,
                        icon: Image.network("https://screenshot.anquetil.org/static/4zsdh.png"),
                      ),
                      Text(
                        '+1/s',
                        style: GoogleFonts.mcLaren(
                            textStyle: TextStyle(color: Colors.white, letterSpacing: 1)
                        ),
                      ),
                      Row(
                        children: <Widget> [
                          Text(
                            prices["autoClicker"]?.toString() ?? '50',
                            style: GoogleFonts.mcLaren(
                                textStyle: TextStyle(color: Colors.white, letterSpacing: 1)
                            ),
                          ),
                          ImageIcon(
                            NetworkImage("https://screenshot.anquetil.org/static/qn7yyy.png"),
                            color: Colors.yellow,
                          ),
                        ],
                      ),

                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      IconButton(
                        onPressed: _buyClickMultiplicator,
                        iconSize: 50,
                        icon: Image.network("https://screenshot.anquetil.org/static/nuacjg.png"),
                      ),
                      Text(
                        '+1/click',
                        style: GoogleFonts.mcLaren(
                            textStyle: TextStyle(color: Colors.white, letterSpacing: 1)
                        ),
                      ),
                      Row(
                        children: <Widget> [
                          Text(
                              prices["clickerMultiplicator"]?.toString() ?? '8',
                            style: GoogleFonts.mcLaren(
                                textStyle: TextStyle(color: Colors.white, letterSpacing: 1)
                            ),
                          ),
                          ImageIcon(
                            NetworkImage("https://screenshot.anquetil.org/static/qn7yyy.png"),
                            color: Colors.yellow,
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
