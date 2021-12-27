import 'dart:ffi';
import 'dart:ui';

import 'package:TODO/models/task.dart';
import 'package:TODO/ui/size_config.dart';
import 'package:TODO/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task,{Key? key, }) : super(key: key);
final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:    EdgeInsets.symmetric(
      horizontal:getProportionateScreenWidth(
        SizeConfig.orientation==Orientation.landscape?4:20)),
        margin:EdgeInsets.only(bottom:getProportionateScreenHeight(15) ) ,
      width: SizeConfig.orientation==Orientation.landscape?
      SizeConfig.screenWidth/2:SizeConfig.screenWidth,
      child: Container(
        padding:const EdgeInsets.all(12),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(16),
         color: _getBGClr(task.color),
       ) ,
        child:Row(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title!,style:GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16,                
              color: Colors.white
            )
          )),
                SizedBox(height: 15,),
                Row(crossAxisAlignment:CrossAxisAlignment.center ,
                children: [
                        Icon(Icons.access_time_filled_rounded,
                        color: Colors.grey[200],size: 20,),
                        const SizedBox(width: 15,),
                        Text('${task.startTime}-${task.endTime}',
                        style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 13,                
              color: Colors.white
            )
          ))

                ],)
                ,const SizedBox(height: 15,)
                ,Text(task.note!,style:GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 13,                
              color: Colors.white
            )
          ))
              ],
            ),
          )),
          Container(height: 60,
          width: .5,
          color: Colors.grey.withOpacity(.7),),
          RotatedBox(quarterTurns: 3,child: Text(task.isCompleted==0?'TODO':
          'Completed',style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
          ),),)
        ],
      ),),
    );
  }

  _getBGClr(int? color) {
    switch (color){
      case 0:return bluishClr;
      case 1:return pinkClr;
      case 2:return orangeClr;
      default:return bluishClr;
    } 
  }
}
