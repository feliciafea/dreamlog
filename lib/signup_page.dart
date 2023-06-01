import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});
  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                margin: const EdgeInsets.only(bottom: 80),
                child: const Image(
                  image: NetworkImage('https://media.istockphoto.com/id/1362561518/vector/printmoon-icon-outline-moon-with-star-crescent-for-night-pictogram-symbol-for-sky-light.jpg?s=612x612&w=0&k=20&c=bKgpH-718TDzKnU6k7vkepA1QGuWmWMAFvY5yyGvBm4='),
                ),
              ),
              Text(
                'Sign-up',

                style: Theme.of(context).textTheme.headline4,
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
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
                margin: EdgeInsets.only(top: 10, bottom: 10),
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
                    final data = {"title": "My First Dream",
                      "description": "I was frolicking through a meadow of beautiful flowers, enjoying the warm breeze and sunshine. The birds were chirping and I felt so happy!",
                      'date': '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}'};
                    FirebaseFirestore.instance.collection('users').doc(emailController.text).collection("dreamList").add(data).then((documentSnapshot) =>
                        print("Added Data with ID: ${documentSnapshot.id}"));

                    // FirebaseFirestore.instance.collection('users').doc(emailController.text).set({'Dreams': {'title': 'My First Dream!', 'description': "I dreamed about unicorns and rainbows! It was a fantastic dream!", 'date': '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}'}})
                    //     .then((value) => print("User Updated"))
                    //     .catchError((error) => print("Failed to setup user: $error"));
                    //     .set({
                    //   "name": "Los Angeles",
                    //   "state": "CA",
                    //   "country": "USA"
                    // }).onError((error, stackTrace) => print("add failed"));
                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passController.text).then((value) {
                      print("Signed up");
                    }).catchError((error) {
                      print("Failed to sign up");
                      print(error.toString());
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home")),
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
