import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';

class MyCard extends StatefulWidget {
  final Map fields;

  // email username password / custom fields?

  //TODO: add edit icon to change something
  //TODO: allow user to add different colors to different cards  (default background color: white?? )

  MyCard({@required this.fields});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  List<Widget> getCardBody(Map fields) {
    List<Widget> cardColumns = [];

    cardColumns.addAll(
        [
          Row(
            children: <Widget>[
              Text(widget.fields["title"].toUpperCase(),
                  style: kCardTitleTextStyle),
            ],
          ),
          SizedBox(height: 10.0),
        ]
    );

    for (String key in fields.keys) {
      if (key != "title") cardColumns.add(Text("$key : ${fields[key]}"));
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

//Padding(
//padding: const EdgeInsets.all(20.0),
//child: Column(
//children: getCardBody(widget.fields),
//),
//);

