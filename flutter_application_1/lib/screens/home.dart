import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_application_1/entity/kml_entity.dart';
import 'package:flutter_application_1/kml/kmls.dart';
import 'package:flutter_application_1/services/ssh.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{
  LGSSHConnection connection=LGSSHConnection(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: TextButton(onPressed: (){
                print("Set Logo");
                connection.setLogo();
              },
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
               child: const Text('Set Logo',
               style: TextStyle(fontSize: 24),)),
          ),
            
            Container(
               margin: EdgeInsets.all(8),
              child: TextButton(onPressed: (){
                print("Clear Logo");
                connection.removeLogo();
                
              },
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
               child: const Text('Remove Logo',
               style: TextStyle(fontSize: 24),
               )),
            ),
             Row(
              spacing:20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Container(
                       margin: EdgeInsets.all(8),
                      child: TextButton(onPressed: (){
                        connection.sendKmlandFly(KMLEntity(name: "kmlone", content: kmlone),look_at);
                      },
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
                        child: Text("KMl 1",
                        style: TextStyle(fontSize:24))
                        ),
                    ),
                    Container(
                       margin: EdgeInsets.all(8),
                      child: TextButton(onPressed: (){
                        connection.sendKmlnew(KMLEntity(name: "kml_new", content: kmltwo));
                                   
                      },
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
                                     child: Text("KML 2",
                                     style: TextStyle(fontSize: 24),)),
                    ),
             ]
             ),
            Container(
               margin: EdgeInsets.all(8),
              child: TextButton(onPressed: ()async{
                await connection.clearKml();
              },
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
               child: Text("Clear KML",
               style: TextStyle(fontSize: 24),)
              ),
            )
        ],
      )
    );
  }
  
}