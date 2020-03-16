import 'package:flutter/material.dart';
import 'package:password_manager/screens/my_passwords.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool sideNavBarOpened = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.format_list_bulleted),
              onPressed: () {
                sideNavBarOpened = !sideNavBarOpened;

                if (sideNavBarOpened) {
                  print("open side navbar");
                  //TODO: open side navbar (show logged in name on top)
                  //TODO: options : create strong password , my passwords , change password , logout
                  //TODO: exports password to xml file? , create xml file for passwords
                  //TODO: load passwords from xml file
                  //TODO: copy button to copy email/password directly to clipboard
                } else {
                  //TODO: close navbar here
                  print("Closed side navbar");
                }
              },
            ),
            title: Text('Password Manager'),
            centerTitle: true,
          ),

          //TODO: add search app bar ???

          body: MyPasswords(),
        ),
      ),
    );
  }
}
