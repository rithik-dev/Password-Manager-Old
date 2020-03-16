import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class FileUtils {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    print("path to file $path");
    return File('$path/db.txt');
  }

  static Future<File> writeData(List cards) async {
    final file = await _localFile;

    var jsonEncodedList = json.encode(cards);

    //TODO: encrypt data here

    // Write the file.
    return file.writeAsString('$jsonEncodedList');
  }

  static Future<List> readData() async {
    try {
      print("TRYING TO READ FILE");
      final file = await _localFile;

      final bool fileExists = await file.exists();

      print("FILE EXISTS : $fileExists");

      // Read the file.

      if (fileExists) {
        String contents = await file.readAsString();

//      print("contents from file $contents");
//      print(contents.runtimeType);

        var decodedContents = json.decode("""$contents""");

//        print("decoded contents from file $decodedContents");
//      print(decodedContents.runtimeType);

        return decodedContents;
      } else {
        await _localFile;
        return [];
      }
    } catch (e) {
      // If encountering an error, return;
      print("READ DATA ERROR : " + e.toString());
      return [e];
    }
  }
}
