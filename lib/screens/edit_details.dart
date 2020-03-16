import 'package:flutter/material.dart';

Map editedFields = {};

class EditDetails extends StatefulWidget {
  final Map fields;

  EditDetails({@required this.fields});

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  List<Widget> textFields = [];
  String dropDownValue = "Email";
  String tempKey;
  List<String> dropDownFields = ['Email', 'Username', 'Phone', 'Link'];
  List<String> fieldsCreated = [];

  @override
  void initState() {
    makeTextFields();
    super.initState();
  }

  List<Widget> makeTextFields() {

    for (String key in widget.fields.keys) {
      if (key != "id") if (!fieldsCreated.contains(key))
        textFields
            .add(MyTextField(labelText: key, defaultValue: widget.fields[key]));
      fieldsCreated.add(key);
      editedFields[key] = widget.fields[key];
    }

    return textFields;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
//          leading: IconButton(
//            icon: Icon(Icons.format_list_bulleted),
//            onPressed: () {
//              print("side bar");
//            },
//          ),
          title: Text('Password Manager'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              Column(children: makeTextFields()),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: DropdownButton<String>(
                      value: dropDownValue,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownValue = newValue;
                        });
                      },
                      items: dropDownFields
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 10),
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
                        if (!fieldsCreated.contains(dropDownValue)) {
                          if (!(dropDownValue == null || dropDownValue == "")) {
                            print("ADDING NEW DROPDOWN FIELD $dropDownValue");
                            fieldsCreated.add(dropDownValue);
                            print("FIELDS CREATED : $fieldsCreated");
                            setState(() {
                              textFields.add(MyTextField(
                                  labelText: dropDownValue, defaultValue: ""));
                            });
                          } else
                            print("DROPDOWN VALUE NULL OR EMPTY");
                        } else {
                          print("ERROR ADDING NEW FIELD");
                        }
                      },
                      child: Text(
                        "ADD FIELD",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (tempValue) {
                        tempKey = tempValue.trim();
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Custom Field Name",
                          labelText: "Custom Field Name"),
                    ),
                  ),
                  SizedBox(width: 10),
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
                        if (!fieldsCreated.contains(tempKey)) {
                          if (!(tempKey == null || tempKey == "")) {
                            print("ADDING NEW CUSTOM FIELD");
                            fieldsCreated.add(tempKey);
                            print("FIELDS CREATED : $fieldsCreated");
                            setState(() {
                              textFields.add(MyTextField(
                                  labelText: tempKey, defaultValue: ""));
                            });
                            tempKey = "";
                          }
                        } else {
                          print("ERROR ADDING NEW FIELD");
                        }
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
            if (!(editedFields["Title"] == null ||
                editedFields["Title"] == "" ||
                editedFields["Password"] == "" ||
                editedFields["Password"] == null)) {
              //TODO:save the fields here to the file

              print("SAVED TO FILE : $editedFields");

              Navigator.pop(context, editedFields);

              editedFields = {};
            }
          },
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String labelText;
  final String defaultValue;

  MyTextField({this.labelText, this.defaultValue});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        controller: TextEditingController()..text = this.defaultValue,
        onChanged: (value) {
          editedFields[this.labelText] = value;
        },
        obscureText: this.labelText == "Password",
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter ${this.labelText}",
            labelText: this.labelText),
      ),
      trailing: (this.labelText == "Title" || this.labelText == "Password")
          ? null
          : IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
//          delete field here
                print("delete ${this.labelText}");
                //FIXME: does not animate the change :(
                editedFields.remove(this.labelText);
              },
            ),
    );
  }
}
