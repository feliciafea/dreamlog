import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'new_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  final emailController = TextEditingController();
  final passController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpPage(title: "Sign Up")),
      );
    });
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
      backgroundColor: Colors.white,
      //appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(widget.title),
      //),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Container(
                  height: 300,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Image(
                    image: NetworkImage('https://media.istockphoto.com/id/1362561518/vector/printmoon-icon-outline-moon-with-star-crescent-for-night-pictogram-symbol-for-sky-light.jpg?s=612x612&w=0&k=20&c=bKgpH-718TDzKnU6k7vkepA1QGuWmWMAFvY5yyGvBm4='),
                  ),
                ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                    ),
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                 width: 320,
                 child: TextField(
                   controller: emailController,
                    decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                width: 320,
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(emailController.text);
                    print(passController.text);
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text)
                        .then((value) {
                      print('Login');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MySecondPage(title: "Dreams", email: emailController.text)),
                      );
                    }).catchError((error) {
                      print('Failed');
                      print(error.toString());
                    });
                  },
                  child: Text ('Log-in')),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage(title: "SignUp")),
                    );
                  },
                  child: Text ('Sign-up')),
            ],
          ),
        ),
      ),
    );
  }
}
