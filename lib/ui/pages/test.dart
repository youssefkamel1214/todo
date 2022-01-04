import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class test extends StatefulWidget{
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
       body: Center(child: FlatButton(child: Text('asfsa'),onPressed: (){
         Get.bottomSheet(
           SingleChildScrollView(
             child: Column(),
           )
         );
       },),),
     );
  }
}