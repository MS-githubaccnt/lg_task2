import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_application_1/entity/kml_entity.dart';
import 'package:flutter_application_1/entity/look_at.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../kml/kmls.dart';
import 'dart:async';
class LGSSHConnection{
  late String _ipAddress;
  late String _username;
  late String _password;
  String _numberOfRigs='3';
  late String _portNumber;
  late SSHClient? _client;
  _getConnection() async{
    SharedPreferences data=await SharedPreferences.getInstance();
     _ipAddress= data.getString('ip')??'localhost';
     _username= data.getString('username')??'lg';
     _password= data.getString('password')??'lg';
     _numberOfRigs= data.getString('rigs')??'3';
     _portNumber= data.getString('portNumber')??'22';
  }
  int rigs(){
    return int.parse(_numberOfRigs);
  }
   String generateBlank(String id) {
    return '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="$id">
  </Document>
</kml>
    ''';
  }
  Future<bool?> connectToLG() async {
    await _getConnection();
    try{
      _client=SSHClient(
        await SSHSocket.connect(_ipAddress,
         int.parse(_portNumber)),
        username: _username,
        onPasswordRequest:()=>_password,
        );
        return true;
      }catch(e){
        print("failed to connect ${e}");
        return false;
      }
      
  }
  checkConnection()async{
    
    bool? check=await connectToLG();
    await _disconnectLG();
    if(check==true){
      return true;
    }else{
      return false;
    }
  }
  _disconnectLG()async{
    if(_client!=null){
    _client!.close();
    await _client!.done;}
  }

  
Future<SSHSession?> _createCommandSession(String command)async{
  await connectToLG();
    try{
      if(_client==null){
        print("Initalise SSh CLient");
        return null;
      }else{
      final execResult=await _client!.execute(command);
      return execResult;
      }
    }catch(e){
      print('Error ${e}');
      return null;
    }
  }
  runCommand(String command)async{
    final session=await _createCommandSession(command);
    if(session!=null){
    await session.done;
   await _disconnectLG();
   }
  }
  sendKML(String kml)async{
    try{
    await runCommand("echo '$kml' > /var/www/html/kml1.kml && echo 'http://lg1:81/kml1.kml' > /var/www/html/kmls.txt");}
    catch(e){
    print("Error Sending KML $e");
    }
  }
  clearKml()async{
    try{
      await runCommand('echo "exittour=true" > /tmp/query.txt');
      await runCommand("echo > /var/www/html/kmls.txt");
      for(var i=2;i<=int.parse(_numberOfRigs);i++){
        String blankKml =generateBlank('slave_$i');
        await runCommand("echo '$blankKml' > /var/www/html/kml/slave_$i.kml");
      }
    }
    catch(e){
      print("Error in clearing KMLs");
    }

  }
  setLogo()async{
      try{
        //correct this
      var rig=(int.parse(_numberOfRigs)/2).floor()+2;
      print(rig);
      await runCommand("echo '$openLogoKML' > /var/www/html/kml/slave_${rig.toString()}.kml");

      print("ho gya connect"); }
      catch(e){
        print("broo");
        print(e);
      }
    }
  removeLogo()async{
      var rig=(int.parse(_numberOfRigs)/2).floor()+2;
      try{
        await runCommand("echo '$blankKml' > /var/www/html/kml/slave_${rig.toString()}.kml");

      }catch(e){
        print("Error removing Logos $e");
      }
    }
    createFile(String name, String content)async{
      final dir=await getApplicationDocumentsDirectory();
      final file=File('${dir.path}/$name');
      file.writeAsStringSync(content);
      return file;
    }
    useSftp(String kmlPath,String name)async{
      await connectToLG();
      if (_client!=null){
      final sftp=await _client!.sftp();
      //check
      final file=await sftp.open('/var/www/html/$name.kml',mode:SftpFileOpenMode.create|SftpFileOpenMode.write);
      await file.write(File(kmlPath).openRead().cast(),
      onProgress:(progress){
        print(progress);
      });
      await _disconnectLG();
      }
      else{
        print ("client error");
      }
    }
    sendKmlnew(KMLEntity kml)async{
      final fileName='${kml.name}.kml';
      final kmlFile=await createFile(fileName, kml.body) as File;
      await useSftp(kmlFile.path,kml.name);
      await runCommand('echo "http://lg1:81/$fileName" > /var/www/html/kmls.txt');
      // await runCommand('flytoview=${lookat}')
    }
    sendKmlandFly(KMLEntity kml,LookAtEntity lookat)async{
      await sendKmlnew(kml);
      await runCommand("echo 'flytoview=${lookat.linearTag}'>/tmp/query.txt");
    }
    
}