
import 'package:TODO/controllers/task_controller.dart';
import 'package:TODO/models/task.dart';
import 'package:TODO/services/notification_services.dart';
import 'package:TODO/ui/size_config.dart';
import 'package:TODO/ui/theme.dart';
import 'package:TODO/ui/widgets/button.dart';
import 'package:TODO/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _title=TextEditingController();
  final TextEditingController _Note=TextEditingController();
   late NotifyHelper notifyHelper;

  DateTime _selctedted_date=DateTime.now();
  String _start_time=DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _end_time=DateFormat('hh:mm a').format(DateTime.now().add(Duration(minutes: 15))).toString();
int _selctet_remind=5;
List<int>remindlist=[5,10,15,20];
String _selctedted_Reapet='None';
List <String> Reapet_list=['None','Daily','Weakly','Mounthly'];
int _selcted_color=0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
      notifyHelper=NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
         leading: IconButton(onPressed:()=> Get.back(),
        icon: const Icon(Icons.arrow_back),
        color: Get.isDarkMode?Colors.white:Colors.black,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text('Flutter demo',style: Themes().titlestyle,),
        actions: [
           CircleAvatar(backgroundImage: AssetImage('images/person.jpeg'),radius: 25,),SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Center(child: Text('Add Task',style: Themes().subheadingstyle ,)),
              InputField(title: 'Title', note: 'enter ur text',textEditingController: _title,),
              InputField(title: 'Note', note: 'enter ur text',textEditingController: _Note,),
              InputField(title: 'Date', note: DateFormat.yMMMMd().format(_selctedted_date).toString(),
              widget: IconButton(onPressed: ()async{ await _getdateFromuser();},icon: Icon(Icons.calendar_today_outlined),),),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child:InputField(title: 'Start time', note: _start_time,widget: IconButton(onPressed: ()async{await _getTimeFromUser(isstarttime: true);},icon:const Icon(Icons.access_time_rounded),),) ),
                  Expanded(child:InputField(title: 'End time', note: _end_time,widget: IconButton(onPressed:  ()async{await _getTimeFromUser(isstarttime: false);},icon:const Icon(Icons.access_time_rounded),),) ),
                ],
              ),
              InputField(title: 'Remind', note: '${_selctet_remind}minutes early',widget: DropdownButton(items:
               remindlist.map<DropdownMenuItem<int>>((int e) => DropdownMenuItem(value: e,child: Text(e.toString(),style: const TextStyle(color: Colors.white),)) ).toList(),
              dropdownColor: Colors.black,
              borderRadius: BorderRadius.circular(15),
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 32,
              onChanged: (int? value) {
                setState(() {
                  _selctet_remind=value!;
                });
              },
              underline: Container(height: 0,),
               )
               ),
              InputField(title: 'Reapet', note: '${_selctedted_Reapet}',widget: DropdownButton(items:
               Reapet_list.map<DropdownMenuItem<String>>((String e) => DropdownMenuItem(value: e,child: Text(e,style: const TextStyle(color: Colors.white),)) ).toList(),
              dropdownColor: Colors.black,
              borderRadius: BorderRadius.circular(15),
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 32,
              onChanged: (String? value) {
                setState(() {
                  _selctedted_Reapet=value!;
                });
              },
              underline: Container(height: 0,),
               )
               ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('color',style: Themes().titlestyle,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(3,(index)=>
                    GestureDetector(onTap: (){
                      setState(() {
                        _selcted_color=index;
                      });
                    },child: Padding(padding: EdgeInsets.only(right: 10),
                        child: CircleAvatar(backgroundColor:index==0? primaryClr:index==1?pinkClr:orangeClr,
                        child:_selcted_color==index?Icon(Icons.done,size: 16,):null,))),)
                      
                    ,
                  )  
                ],),
                MyButton(label: 'Create Task', func: (){_addtasktodb();}),
        
              ],)
            ],
          ),
        ),
      ),
    );
  }
  bool _valditade_task(){
    if(_title.text.isEmpty||_Note.text.isEmpty)
      return false; 
    else 
     return true;
  }
  _getdateFromuser()async
  {
   DateTime?picked=await showDatePicker(context: context, initialDate: _selctedted_date, 
    firstDate: DateTime(DateTime.now().year), 
    lastDate:DateTime(2030) );
    if(picked==null)return;
    setState(() {
      _selctedted_date=picked;
    });
  }
  _getTimeFromUser({required bool isstarttime})async{
    TimeOfDay?picked=await showTimePicker(context: context, 
    initialEntryMode:TimePickerEntryMode.input ,
    initialTime: TimeOfDay.fromDateTime(
      isstarttime? DateTime.now():DateTime.now().add(Duration(minutes: 5))));
    if(picked==null)return;
    setState(() {
      if(isstarttime)
        _start_time=picked.format(context);
      else
      _end_time=picked.format(context);
    });
  }
  _addtasktodb()async{
    if(_valditade_task()==false)
    {
      print(_title.text+"\n"+_Note.text);
      Get.snackbar('error', 'you should full all fields',
      colorText: pinkClr,
      snackPosition:SnackPosition.BOTTOM,
      icon: const Icon(Icons.warning_amber_rounded,color: Colors.red,)
      );
          return;
    }
   var task2 = Task(title: _title.text, 
      note: _Note.text,color: _selcted_color,remind: _selctet_remind,
      repeat: _selctedted_Reapet,startTime: _start_time,endTime: _end_time,
      date:DateFormat.yMd().format(_selctedted_date),isCompleted: 0);
   var a=await TaskController().addTask(task: task2);
   task2.id=a;
      print('id is ${a}');
       var date=DateFormat.jm().parse(task2.startTime!);
            var aa=DateFormat('HH:mm').format(date);
            notifyHelper.scheduledNotification(
             int.parse(aa.toString().split(':')[0]),
             int.parse(aa.toString().split(':')[1]),
             task2);
    Get.back();
    return;
     
  }
}
