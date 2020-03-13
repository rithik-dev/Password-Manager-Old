import 'package:flutter/material.dart';
import 'package:password_manager/widgets/my_card.dart';

class MyPasswords extends StatefulWidget {
  @override
  _MyPasswordsState createState() => _MyPasswordsState();
}

class _MyPasswordsState extends State<MyPasswords> {
  List<Widget> cards = [];

  List<Widget> getCardsList() {
    cards = [];

    // TODO: read from file here passwords
    cards.addAll([
      MyCard(fields: {
        "title": "G Mail",
        "E Mail": "email1",
        "Password": "pass1",
      }),
      MyCard(fields: {
        "title": "Instagram",
        "Username": "user1",
        "E Mail": "email2",
        "Password": "pass2",
      }),
    ]);
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getCardsList(),
      ),
    );
  }
}
