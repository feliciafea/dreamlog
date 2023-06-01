import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_first/new_page.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.title, required this.email});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String email;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    descController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
              margin: const EdgeInsets.all(10.0),
              width: 300.0,
              height: 50.0,
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  //hintText: 'give a title to your dream'
                ),
              ),
            ),
              Container(
                margin: const EdgeInsets.all(10.0),
                width: 300.0,
                height: 50.0,
                child: TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      //hintText: 'describe your dream'
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final data = {"title": titleController.text,
                    "description": descController.text,
                    'date': '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}'};
                  FirebaseFirestore.instance.collection('users').doc(widget.email).collection("dreamList").add(data).then((documentSnapshot) =>
                      print("Added Data with ID: ${documentSnapshot.id}"));
                  // FirebaseFirestore.instance.collection('users')
                  //     .doc(widget.email).update({'Dreams': FieldValue.arrayUnion([{
                  //       'title': titleController.text,
                  //       'description': descController.text,
                  //       'date': '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}'}])})
                  //     .then((value) => print("Dream added"))
                  //     .catchError((error) => print("Failed to add dream: $error"));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySecondPage(title: "Dream Log", email: widget.email)),
                  );
                },
                child: const Text('Add'),
              ),
          ],
        ),
       ),
    );
  }
}