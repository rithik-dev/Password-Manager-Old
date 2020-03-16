import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:password_manager/constants.dart' show key;

class FileUtils {
  static final cryptor = new PlatformStringCryptor();
  static String encrypted, decrypted;

  static const int LEVELS_OF_ENCRYPTION = 5;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    print("PATH TO FILE : $path/db.txt");
    return File('$path/db.txt');
  }

  static Future<File> writeData(List cards) async {
    final file = await _localFile;

    var jsonEncodedList = json.encode(cards);

    //TODO: encrypt data here
    // 5 levels of encryption
    for (int i = 0; i < LEVELS_OF_ENCRYPTION; i++) {
      encrypted = await cryptor.encrypt(jsonEncodedList, key);
      jsonEncodedList = encrypted;
    }

    // Write the file.
    return file.writeAsString('$encrypted');
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

        //TODO: decrypt contents here
        try {
          for (int i = 0; i < LEVELS_OF_ENCRYPTION; i++) {
            decrypted = await cryptor.decrypt(contents, key);
            contents = decrypted;
          }
        } on MacMismatchException {
          // unable to decrypt (wrong key or forged data)
          print("ERROR : UNABLE TO DECRYPT");
          decrypted = "";
        }

        var decodedContents = json.decode("""$decrypted""");

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
