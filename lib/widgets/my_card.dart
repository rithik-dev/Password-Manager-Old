import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/file_utils.dart';
import 'package:password_manager/screens/edit_details.dart';

class MyCard extends StatefulWidget {
  final Map fields;

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
          Text(
              widget.fields["Title"] == null
                  ? ""
                  : widget.fields["Title"].toUpperCase(), // null operator
              style: kCardTitleTextStyle),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  //TODO:allow user to edit credentials ..add new fields .. etc.
                  print("edit credentials here");
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => EditDetails()));

                  Map newFields = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditDetails(fields: widget.fields);
                      },
                    ),
                  );

                  if (newFields != null) {
                    List data = await FileUtils.readData();
                    data[int.parse(widget.fields['id'])] = newFields;
                    FileUtils.writeData(data);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  print("DELETING CARD AT INDEX : ${fields['id']}");
                  List tempFields = await FileUtils.readData();
                  tempFields.removeAt(int.parse(fields['id']));
                  FileUtils.writeData(tempFields);

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Card Successfully Deleted"),
                    duration: Duration(seconds: 1),
                  ));
                },
              ),
            ],
          )
        ],
      ),
      SizedBox(height: 10.0),
    ]);

    for (String key in fields.keys) {
      if (!(key == "Title" || key == "id"))
        cardColumns.add(
          ListTile(
            title: Text(key,
                style: TextStyle(
                    color: Colors.yellow, fontWeight: FontWeight.bold)),
            subtitle: Text(
              key == "Password" ? '***********' : fields[key],
              style: kCardContentTextStyle,
            ),
            trailing: IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.fields[key]));

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("$key Copied to Clipboard"),
                    duration: Duration(seconds: 1),
                  ));
                }),
          ),
        );
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
