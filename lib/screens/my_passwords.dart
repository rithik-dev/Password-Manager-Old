import 'package:flutter/material.dart';
import 'package:password_manager/screens/add_details.dart';
import 'package:password_manager/screens/edit_details.dart';
import 'package:password_manager/widgets/my_card.dart';

class MyPasswords extends StatefulWidget {
  @override
  _MyPasswordsState createState() => _MyPasswordsState();
}

class _MyPasswordsState extends State<MyPasswords> {
  List<Widget> cards = [];

  List<Widget> getCardsList() {
    cards = [];

    // TODO: read from file here passwords and generate list cards

    cards.addAll([
      MyCard(fields: {
        "Title": "Gmail",
        "Email": "email1",
        "Password": "pass1",
      }),
      MyCard(fields: {
        "Title": "Instagram",
        "Username": "user1",
        "Email": "email2",
        "Password": "pass2",
      }),
    ]);
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scaffold(
        body: ListView(
          children: getCardsList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddDetails()));
          },
          child: Icon(Icons.add, size: 30.0),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
