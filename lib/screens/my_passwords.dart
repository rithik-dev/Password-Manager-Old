import 'package:flutter/material.dart';
import 'package:password_manager/file_utils.dart';
import 'package:password_manager/screens/add_details.dart';
import 'package:password_manager/widgets/my_card.dart';

class MyPasswords extends StatefulWidget {
  @override
  _MyPasswordsState createState() => _MyPasswordsState();
}

class _MyPasswordsState extends State<MyPasswords> {

  List cardsDataFromDB = [];
  List<Widget> cards = [];

  void deleteCard(int index){
    getFileData();
    setState(() {
      cardsDataFromDB.removeAt(index);
    });
    FileUtils.writeData(cardsDataFromDB);
  }

  @override
  void initState() {
    // TODO: implement initState
//    setState(() {
    getFileData();
//    });
    super.initState();
  }

//  @override
//  void initState() {
  //read from DB here passwords and generate list cardsDataFromDB

//    getFileData();

//    FileUtils.readData();

//    cardsDataFromDB = [
//      {
//        "Title": "Gmail",
//        "Email": "email1",
//        "Password": "pass1",
//      },
//      {
//        "Title": "Instagram",
//        "Username": "user1",
//        "Email": "email2",
//        "Password": "pass2",
//      }
//    ];

//    super.initState();
//  }

  Future<void> getFileData() async {
    cardsDataFromDB = await FileUtils.readData();
    print("READ FROM FILE (initial) : $cardsDataFromDB");
  }

  List<Widget> getCardsList() {
    getFileData();
    cards = [];
    for (Map cardData in cardsDataFromDB) {
      cards.add(MyCard(fields: cardData));
    }
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
          onPressed: () async {
            Map newFields = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddDetails();
                },
              ),
            );

            if (newFields != null) {
              getFileData();
              print("CARDS DATA INITIAL $cardsDataFromDB");

              newFields['id'] = cardsDataFromDB.length.toString();

              cardsDataFromDB.add(newFields);

              print("CARDS DATA FINAL $cardsDataFromDB");

              // write to file

              FileUtils.writeData(cardsDataFromDB);
            }

//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => AddDetails()));
          },
          child: Icon(Icons.add, size: 30.0),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
