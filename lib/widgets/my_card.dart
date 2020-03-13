import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/screens/edit_details.dart';

class MyCard extends StatefulWidget {
  final Map fields;

  // email username password / custom fields?
  //  title password compulsory fields .. rest add custom fields

  //TODO: add edit icon functionality to change something
  //TODO: allow user to add different colors to different cards  (default background color: white?? )

  MyCard({@required this.fields});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  List<Widget> getCardBody(Map fields) {
    List<Widget> cardColumns = [];

    cardColumns.addAll([
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.fields["Title"].toUpperCase() ?? "", // null operator
              style: kCardTitleTextStyle),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //TODO:allow user to edit credentials ..add new fields .. etc.
              print("edit credentials here");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditDetails()));
            },
          )
        ],
      ),
      SizedBox(height: 10.0),
    ]);

    for (String key in fields.keys) {
      if (key != "Title") if (key == "Password") {
        cardColumns.add(Row(
          children: <Widget>[
            Text("$key : ***********", style: kCardContentTextStyle),
            IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.fields[key]));

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$key Copied to Clipboard"),
                  duration: Duration(seconds: 1),
                ));
              },
            )
          ],
        ));
      } else
        // if key is not password
        cardColumns.add(Row(
          children: <Widget>[
            Text("$key : ${fields[key]}", style: kCardContentTextStyle),
            IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.fields[key]));

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$key Copied to Clipboard"),
                  duration: Duration(seconds: 1),
                ));
              },
            )
          ],
        ));
    }

    return cardColumns;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {},
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: getCardBody(widget.fields),
              ),
            ),
          ),
        ),
      ),
    );
  }
}