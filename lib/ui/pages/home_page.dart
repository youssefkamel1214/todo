import 'package:TODO/controllers/task_controller.dart';
import 'package:TODO/models/task.dart';
import 'package:TODO/services/notification_services.dart';
import 'package:TODO/services/theme_services.dart';
import 'package:TODO/ui/pages/add_task_page.dart';
import 'package:TODO/ui/pages/notification_screen.dart';
import 'package:TODO/ui/theme.dart';
import 'package:TODO/ui/widgets/button.dart';
import 'package:TODO/ui/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:TODO/ui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selcteddate=DateTime.now();
  final TaskController _taskController=TaskController();
 late NotifyHelper notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.InitializationNotification();
    notifyHelper.reaqurstpermission();
  }
  @override
  Widget build(BuildContext context) {
   SizeConfig().init(context);     
      return Scaffold(
        backgroundColor: context.theme.backgroundColor,
      appBar: make_appbar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                   const SizedBox(height: 10,),
                    _add_Taskbar(),
                    const  SizedBox(height: 15,),
                    _add_Datebar(context),
                    SizedBox(height: 10,),
                    _show_Task(),

                ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Get.to(const AddTaskPage()),
        child:const Icon(Icons.edit),
        backgroundColor:primaryClr ,
      ),
    );
  }

  AppBar make_appbar(BuildContext context) {
    return AppBar(leading: IconButton(onPressed:(){
      ThemeServices().switchmode();
        NotifyHelper().displayNotification(title: "theme changed",
         body: '7aga bnt a7ba');
        //  NotifyHelper().sculdauled_notification();
      },
      icon:  Icon(Get.isDarkMode? Icons.wb_sunny_outlined:Icons.dark_mode_outlined),
      color: Get.isDarkMode?Colors.white:Colors.black,
    
      ),actions:const<Widget> [
        CircleAvatar(backgroundImage: AssetImage('images/person.jpeg'),
        radius: 25,),
         SizedBox(width: 10,)
      ],
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      );
  }

  Row _add_Taskbar() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Column(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(DateFormat.yMMMd().format(DateTime.now()).toString(),style: Themes().subheadingstyle,),
                     Text('Today',style: Themes().headingstyle,)
                     ],
                 ),
                 MyButton(label: '+Add Task', func: ()async{
                   await Get.to(const AddTaskPage());
                   _taskController.getTask();
                   })
      
      
               ],);
  }

  Widget _add_Datebar(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      width: 80,
      height: 100,
      initialSelectedDate:selcteddate ,
      selectionColor: primaryClr,
      selectedTextColor: Colors.white,
      monthTextStyle: GoogleFonts.lato(textStyle: const TextStyle(
          color:Colors.grey
          ,fontSize: 16 )),
           dayTextStyle: GoogleFonts.lato(textStyle: const TextStyle(
          color:Colors.grey
          ,fontSize: 20
          ,fontWeight:FontWeight.bold )),
           dateTextStyle: GoogleFonts.lato(textStyle: const TextStyle(
          color:Colors.grey
          ,fontSize: 18
          ,fontWeight:FontWeight.bold )),
      onDateChange: (date){
        setState(() {
          selcteddate=date;
        });
      },
    );
  }

  Widget _show_Task() {
    
    return Expanded(
      child: ListView.builder(scrollDirection:
       SizeConfig.orientation==Orientation.landscape?
       Axis.horizontal:Axis.vertical,
        itemCount: _taskController.tasklist.length,
        itemBuilder:(BuildContext context,index)
      {
        Task task = _taskController.tasklist[index];
        return  AnimationConfiguration.staggeredList(
          position: index,
          duration:Duration(milliseconds: 1375) ,
          child: FadeInAnimation(
            child: GestureDetector(onTap: ()=>showBottomSheet(context, task),
              child: TaskTile(task),
              ),
          ),
        );
      }),
    );
    // Expanded(
    // child:GestureDetector(onTap: ()=>showBottomSheet(context, task),
    //   child: TaskTile(task),
    // )
  //  Obx(
  //   (){
  //     if(_taskController.tasklist.isEmpty){
  //       return _notaskmsg();
  //     }
  //     else
  //       return Container(height: 0,);
      
  //   }
  // )
  }

  Widget _notaskmsg() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
             SizeConfig.orientation==Orientation.landscape? SizedBox(height: 6,):SizedBox(height: 220,),
              SvgPicture.asset('images/task.svg',height: 98,
              color: primaryClr.withOpacity(.5),
              semanticsLabel: 'task',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:  40.0,vertical: 10),
                child: Text('you dont have tasks\n add new task to your day pitch\n',style: Themes().subtitlestyle,textAlign: TextAlign.center,),
              ), 
              SizeConfig.orientation==Orientation.landscape? SizedBox(height: 120,):SizedBox(height: 180,),
            ],
          ),
        )
      ],
    );
  }
 showBottomSheet(BuildContext context,Task task){
   Get.bottomSheet(SingleChildScrollView(
     child: Container(

       child: Column(
         children: [
           Flexible(child:Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
           ) ,),
           SizedBox(height: 20,),
           task.isCompleted==1?Container():
           _buildBottomSheet(label: 'Task completed', onTap:()=> Get.back() ,
            clr: primaryClr),
            _buildBottomSheet(label: 'Delete Task', onTap:()=> Get.back() ,
            clr: primaryClr),
            Divider(color:Get.isDarkMode? Colors.grey:darkGreyClr,),
            _buildBottomSheet(label: 'Cancel', onTap:()=> Get.back() ,
            clr: primaryClr),
            SizedBox(height: 20,)
         ],
       ),
       padding: const EdgeInsets.only(top: 4),
       width: SizeConfig.screenWidth,
       color:Theme.of(context).backgroundColor ,
       height: (SizeConfig.orientation==Orientation.landscape)?
       task.isCompleted==1?SizeConfig.screenHeight*.6:SizeConfig.screenHeight*.8
       :task.isCompleted==1?SizeConfig.screenHeight*.38:SizeConfig.screenHeight*.45,
     ),
   ));
 }
  _buildBottomSheet({
      required String label,
      required Function() onTap,
      required Color clr,
      bool isClose =false
    }){
       return GestureDetector(onTap: onTap,
         child: Container(
           margin:  const EdgeInsets.symmetric(vertical: 4),
           height: 65,
           width: SizeConfig.screenWidth*.9,
           decoration: BoxDecoration(
             border: Border.all(
               width: 2,
               color: isClose?Get.isDarkMode?
               Colors.grey[600]!:Colors.grey[300]!
               :clr
             ),
             borderRadius: BorderRadius.circular(20),
             color: isClose?Colors.transparent:clr
           ),
         child: Center(child: Text(label,
         style:isClose? Themes().titlestyle:
         Themes().titlestyle.copyWith(color: Colors.white),
         ),),),
       ) ;  
  }
}
