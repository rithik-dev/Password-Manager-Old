import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget {
  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  static Map fields = {};

  String tempKey;

  List<Widget> textFields = [
    TextField(
      onChanged: (value) {
        fields["Title"] = value;
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Title",
          labelText: "Title"),
    ),
    TextField(
      obscureText: true,
      onChanged: (value) {
        fields["Password"] = value;
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Password",
          labelText: "Password"),
    ),
  ];

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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: textFields,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (value) {
                        tempKey = value.trim();
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Field Name",
                          labelText: "Field Name"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        print("add new textfield now");
                        setState(() {
                          if (!(tempKey == null || tempKey == "")) {
                            textFields.add(
                              TextField(
                                onChanged: (value) {
                                  fields[tempKey] = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter $tempKey",
                                    labelText: tempKey),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        "ADD FIELD",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            if (!(fields["Title"] == null || fields["Title"] == "")) {
              //TODO:save the fields here to the file
              print(fields);
            }
          },
        ),
      ),
    );
  }
}

//class MyTextField extends StatelessWidget {
//  final String labelText;
//
//  MyTextField({this.labelText});
//
//  @override
//  Widget build(BuildContext context) {
//    return TextField(
//      onChanged: (value) {
//        print("value")
//      },
//      decoration: InputDecoration(
//          border: InputBorder.none,
//          hintText: "Enter ${this.labelText}",
//          labelText: this.labelText),
//    );
//  }
//}
