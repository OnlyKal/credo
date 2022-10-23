import 'dart:io';
import 'package:credo/CONFIG/func.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import '../EXPORTS/exports.files.dart';

void createFolders() async {
  var localPath = '/storage/emulated/0';
  await Permission.storage.request();
  var status = await Permission.storage.status;
  var fullBackup = Directory(localPath + '/CREDO/DB');

  if (status.isGranted) {
    if (await fullBackup.exists()) {
    } else {
      await fullBackup.create(recursive: true);
    }
  }
}

void localBackupDb() async {
  try {
    var dbPath = await getDatabasesPath();
    File fullDbpathFile = File(dbPath.toString() + '/credo.db');

    var localPath = '/storage/emulated/0';
    Directory destinationPath = Directory('$localPath/CREDO/DB/credo.db');

    var status = await Permission.storage.status;
    if (status.isGranted) {
      if (await fullDbpathFile.exists()) {
        await fullDbpathFile.copy(destinationPath.path).then((path) {
          // if (path.toString() == '/storage/emulated/0/CREDO/DB/credo.db') {
          //   messageSuccess('Backup est bien restauré..!');
          // } else {
          //   messageError('Restauration du backup a echoué..!!');
          // }
        });
      }
    }
  } catch (ex) {
    prt(ex.toString());
  }
}

Future localRestoreDb() async {
  User user = const User();
  dynamic userInfo;
  try {
    var dbPath = await getDatabasesPath();
    Directory fullDbpathFile = Directory('$dbPath/credo.db');
    var localPath = '/storage/emulated/0';
    File destinationPath = File('$localPath/CREDO/DB/credo.db');

    Permission.storage.request();
    var status = await Permission.storage.status;
    if (status.isGranted) {
      if (await destinationPath.exists()) {
        await destinationPath.copy(fullDbpathFile.path).then((path) {
          if (path
              .toString()
              .contains('/data/user/0/com.example.credo/databases/credo.db')) {
            userInfo = true;
          } else {
            messageError('Restauration du backup a echoué..!!');
             userInfo = false;
          }
        });
      } else {
        messageError("Aucune base de donnée disponible...!");
         userInfo = false;
      }
    }

    return userInfo;
  } catch (ex) {
    prt(ex.toString());
  }
}

void onlineDb() {}
