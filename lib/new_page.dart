import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'additem_page.dart';
import 'dreamdetails.dart';
import 'main.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key, required this.title, required this.email});

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
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
   //List<dynamic> dreamList = [];
   late final _dreamStream = FirebaseFirestore.instance.collection('users').doc(widget.email).collection("dreamList").snapshots();

  // Future getData() async {
  //   FieldPath path = new FieldPath(['title']);
  //   await FirebaseFirestore.instance.collection('users').doc(widget.email).collection("dreamList").get()
  //       .then((querySnapshot) {
  //         print("Successfully completed");
  //         for (var docSnapshot in querySnapshot.docs) {
  //           print('${docSnapshot.id} => ${docSnapshot.data()}');
  //           dreamList.add(docSnapshot.data());
  //           print(docSnapshot.data());
  //         }
  //       },
  //           onError: (e) => print("Error completing: $e"),
  //         // Map<String, dynamic> data = snapshot.data() as Map<String,dynamic>;
  //         // print('Title: ${data['dreams'].get(path)}');
  //         // dreamList.add(data['dreams'].get(path));
  //       //}
  //   );
  // }

  void _addItem() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddItem(title: "Add Item", email: widget.email)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home")),
            );
          },
          tooltip: 'logout',
          icon: Icon(Icons.logout),
        ),
      ),

      body: Center(
        // child: FutureBuilder(
        //   future: FirebaseFirestore.instance.collection('users').doc(widget.email).get(),
        //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //   if (snapshot.hasError) {
        //     return Text("Something went wrong");
        //   }
        //   if (snapshot.hasData && !snapshot.data!.exists) {
        //     return Text("Document does not exist");
        //   }
        //
        //   if (snapshot.connectionState == ConnectionState.done) {
        //     //print(snapshot.toString());
        //     //snapshot.get('dreams');
        //     Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        //     dreamList = data["Dreams"];
        //     //print(dreamList.length);
        //   }

          child: StreamBuilder(
            stream: _dreamStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error');
              }
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }
              var dreamList = snapshot.data!.docs;
              return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: dreamList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              leading: const Image(
                                image: NetworkImage('https://media.istockphoto.com/id/1362561518/vector/printmoon-icon-outline-moon-with-star-crescent-for-night-pictogram-symbol-for-sky-light.jpg?s=612x612&w=0&k=20&c=bKgpH-718TDzKnU6k7vkepA1QGuWmWMAFvY5yyGvBm4='),
                              ),
                              title: Text(dreamList[index]["title"].toString()),
                              subtitle: Text('${dreamList[index]["date"].toString()}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DreamDetails(
                                      title: "Dream Details",
                                      email: widget.email,
                                      description: dreamList[index]["description"].toString(),
                                      dreamtitle: dreamList[index]["title"].toString(),
                                      date: dreamList[index]["date"].toString())
                                  ),
                                );
                              },
                              trailing: PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      FirebaseFirestore.instance.collection('users').doc(widget.email).collection("dreamList")
                                          .doc(dreamList[index].id).delete().then(
                                            (doc) => print("Document deleted"),
                                        onError: (e) => print("Error updating document $e"),
                                      );

                                      //reload
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MySecondPage(title: "Dream Log", email: widget.email)),
                                      );
                                      // docRef.update({
                                      //   "Dreams": FieldValue.arrayRemove([{
                                      //     'date': dreamList[index]["date"].toString(),
                                      //     'description': dreamList[index]["description"].toString(),
                                      //     'title': dreamList[index]["title"].toString()
                                      //   }])
                                      // });
                                      // dreamList.removeAt(index);
                                    },
                                    child: Text('Delete')
                                  ),
                                  PopupMenuItem(child: Text('Edit')),
                                ],
                              )
                            ),
                          );
                        },
                      );
            },
          )
          // }, FB
        // ), FB
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add Dream',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}