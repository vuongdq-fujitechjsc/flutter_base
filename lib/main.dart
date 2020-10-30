import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //init state
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //detect life cycle state
  @override
  void didChangeAppLifecycleState(AppLifecycleState appCycleState) {
    super.didChangeAppLifecycleState(appCycleState);

    switch (appCycleState) {
      //inactive (IOS only)
      case AppLifecycleState.inactive:
        print("App LifeCycle State current is InActive");
        break;
      //paused (background)
      case AppLifecycleState.paused:
        print("App LifeCycle State current is Background");
        break;
      //resumed (foreground)
      case AppLifecycleState.resumed:
        print("App LifeCycle State current is Foreground");
        break;
      //detached
      case AppLifecycleState.detached:
        print("App LifeCycle State current is Detached");
        break;
      default:
    }
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
