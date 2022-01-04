import 'package:TODO/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key,required this.payload}) : super(key: key);
 final String payload;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload='';
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
     _payload=widget.payload;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed:(){
          Get.back();
        },
        icon:  Icon(Icons.arrow_back_ios,
        color: Get.isDarkMode? Colors.white:darkGreyClr,),
      
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(_payload.split('|')[0],
        style:  TextStyle(color:Get.isDarkMode? Colors.black:Colors.white),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10,),
            Column(
              children: const [
                 Text('aywa ana hona',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                 SizedBox(height: 15,),
                 Text('abn gzma')
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(child: 
            Container( 
              padding: const EdgeInsets.symmetric(horizontal:  30,vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal:  30,),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                         color: primaryClr,),
                       
                        child: SingleChildScrollView(child:
                         Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               const make_row(iconData: Icons.text_format,text:  'Title',),
                               const SizedBox(height: 20,),
                               Text(_payload.split('|')[0]),
                               const SizedBox(height: 20,),
                               const make_row(iconData: Icons.description,text:'Description',),
                               const SizedBox(height: 20,),
                               Text(_payload.split('|')[1]),
                               const SizedBox(height: 20,),
                               const make_row(iconData: Icons.calendar_today_outlined,text:'Date',),
                               const SizedBox(height: 20,),
                               Text(_payload.split('|')[2]),

                             ],
                         ),),
            )
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

class make_row extends StatelessWidget {
  const make_row({
    Key? key,
    required this.iconData,
    required this.text
  }) : super(key: key);
 final IconData iconData;
 final String text;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(iconData,size: 30,color: Colors.white,),
       SizedBox(width: 20,),
      Text(text,style: TextStyle(color: Colors.white,fontSize: 20),)
    ],);
  }
}
