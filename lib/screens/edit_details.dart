import 'package:flutter/material.dart';

class EditDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () {
              print("side bar");
            },
          ),
          title: Text('Password Manager'),
          centerTitle: true,
        ),
        body: Text("EDIT"),
      )
    );
  }
}
