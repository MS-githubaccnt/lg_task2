import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/ssh.dart';
import '../widgets/alert.dart';
class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});
  @override
  _SettingsPageState createState()=>_SettingsPageState();
  }
class _SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context){
    LGSSHConnection connection=LGSSHConnection(); 
    bool connected=false;
    TextEditingController usernameController=TextEditingController();
    TextEditingController ipAdressController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    TextEditingController portNumberController=TextEditingController();
    TextEditingController numberOfRigsController=TextEditingController();
    tryConnect()async{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      await preferences.setString('ip', ipAdressController.text);
      await preferences.setString('username', usernameController.text);
      await preferences.setString('password', passwordController.text);
      await preferences.setString('portNumber', portNumberController.text);
      await preferences.setString('rigs', numberOfRigsController.text); }

    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:MediaQuery.of(context).size.width*0.7,
              margin:EdgeInsets.all(8),
              child: TextField(
                controller:ipAdressController ,
                keyboardType:TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:Colors.grey),
                  labelText: "IP-Address",
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(10)
                  )
                ),
              
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width*0.7,
              margin:EdgeInsets.all(8),
              child: TextField(
                controller:usernameController ,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:Colors.grey),
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(10)
                  )
                ),
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width*0.7,
              margin:EdgeInsets.all(8),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:Colors.grey),
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(10)
                  )
                ),
              
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width*0.7,
              margin:EdgeInsets.all(8),
              child: TextField(
                controller: portNumberController,
                keyboardType:TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:Colors.grey),
                  labelText: "Port Number",
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(10)
                  )
                ),
              
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width*0.7,
              margin:EdgeInsets.all(8),
              child: TextField(
                controller: numberOfRigsController,
                keyboardType:TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:Colors.grey),
                  labelText: "Number of Rigs",
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(10)
                  )
                ),
              
              ),
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height*0.045,
              
            ),
            TextButton(
              style: ButtonStyle(
                elevation:const WidgetStatePropertyAll(10),
                shape:WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
                ),
                padding:const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(16)),
                backgroundColor: const WidgetStatePropertyAll<Color>(Color.fromRGBO(69, 123, 157, 1)),
                foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white)
              ),
              onPressed: () async{
               //print("hi");
               tryConnect();
               bool answer=await connection.checkConnection();
               if(answer){
                showAlert(context, "Successful Connection");

               }else{
                 showAlert(context, "Unuccessful Connection");

               }

              },
              child: const Text('Connect',
              style: TextStyle(fontSize:24)),
            ),
            
          ],
        )),
    );

  }
}