import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_first/dreamlog_page.dart';

class DreamDetails extends StatefulWidget {
  const DreamDetails({super.key, required this.title, required this.email, required this.description, required this.dreamtitle, required this.date});

  final String title;
  final String email;
  final String description;
  final String dreamtitle;
  final String date;

  @override
  State<DreamDetails> createState() => _DreamDetailsState();
}

class _DreamDetailsState extends State<DreamDetails> {

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
                width: 380,
                height: 680,
                child: Card(
                  child: Container (
                    width: 330,
                    child: Column (
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 10),
                          child: Text(widget.dreamtitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35.0,
                                color: Colors.blue,
                              )
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: Text(widget.date),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 30, right: 30),
                              child: Text(widget.description),
                            ),
                          ),
                      ],
                    ),
                  )
                )
            )

          ],
        ),
      ),
    );
  }
}