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
import 'package:loading_indicator/loading_indicator.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

 
  
  final TaskController _taskController=Get.find<TaskController>();
 late NotifyHelper notifyHelper;
  
  @override
  Widget build(BuildContext context) {
    notifyHelper=NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification(); 
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
                    Obx(()=> _add_Datebar(context)),
                    SizedBox(height: 10,),
                    Obx(()=>_taskController.loaded.value?  _show_Task():CircularProgressIndicator()),

                ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
        await Get.to(const AddTaskPage());
        _taskController.getTasks();
        },
        child:const Icon(Icons.edit),
        backgroundColor:primaryClr ,
      ),
    );
  }


  AppBar make_appbar(BuildContext context) {
    return AppBar(leading: IconButton(onPressed:(){
      ThemeServices().switchmode();
        //  NotifyHelper().sculdauled_notification();
      },
      icon:  Icon(Get.isDarkMode? Icons.wb_sunny_outlined:Icons.dark_mode_outlined),
      color: Get.isDarkMode?Colors.white:Colors.black,
    
      ),actions:<Widget> [
        IconButton(onPressed: ()async=> await _taskController.deletealltasks()
        , icon:Icon(Icons.delete,color: Get.isDarkMode?Colors.white:darkGreyClr,)),
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
                   await _taskController.getTasks();
                   })
      
      
               ],);
  }

  Widget _add_Datebar(BuildContext context) {
  return DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate:_taskController.selcteddate.value ,
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
        onDateChange:  (date){
          _taskController.updatedate(date);
        },
     
    );
  }
 Future<void> _OnRefeash()async {
   _taskController.getTasks();
 }
  Widget _show_Task() {
    return Expanded(
      child: Obx((){
        if(_taskController.tasklist.isEmpty)
                return _notaskmsg();
        return RefreshIndicator(
          onRefresh:() => _OnRefeash(),
          child: ListView.builder(
            physics:const AlwaysScrollableScrollPhysics(),
            scrollDirection: SizeConfig.orientation==Orientation.landscape?
            Axis.horizontal:Axis.vertical,
            itemCount: _taskController.tasklist.length,
            itemBuilder:( context,index)
          {
          return Obx((){
            Task task = _taskController.tasklist[index];
            int differ = DateFormat.yMd().parse(task.date!).difference(_taskController.selcteddate.value).inDays;
            bool weakly=(differ%7==0)&&task.repeat=='Weakly';
            bool mounthly=(DateFormat.yMd().parse(task.date!).day==_taskController.selcteddate.value.day)
            &&task.repeat=="Mounthly";
            if(!(task.repeat=='Daily'
            ||weakly
            ||mounthly
            ||_taskController.selcteddate.value==DateFormat.yMd().parse(task.date!)))
            return Container();
            (task.date);
             return  AnimationConfiguration.staggeredList(
              position: index,
              duration:Duration(milliseconds: 500) ,
              child: SlideAnimation(
                horizontalOffset: 300,
                child: FadeInAnimation(
                  child: GestureDetector(onTap: ()=>showBottomSheet(context, task),
                    child: TaskTile(task),
                    ),
                ),
              ),
            );}
           );
          }),
        );
      },
      ),
    );
  }

  Widget _notaskmsg() {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => _OnRefeash(),
          child: SingleChildScrollView(
            physics:const AlwaysScrollableScrollPhysics(),
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
          ),
        )
      ],
    );
  }
 showBottomSheet(BuildContext context,Task task){
   Get.bottomSheet(Container(
     child: SingleChildScrollView(
       child: Column(mainAxisSize: MainAxisSize.min,
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
           _buildBottomSheet(label: 'show task', 
           onTap:()=>Get.to(NotificationScreen(payload: '${task.title}|${task.note}|${task.startTime}|'))
           , clr: primaryClr),
           task.isCompleted==1?Container():
           _buildBottomSheet(label: 'Task completed', onTap:(){
           notifyHelper.cancelnotifcition(task);
           _taskController.markTaskcompleted(task);
           Get.back();
           } ,
            clr: primaryClr),
            _buildBottomSheet(label: 'Delete Task', onTap:(){
            notifyHelper.cancelnotifcition(task);
            _taskController.deleteTask(task);
            Get.back();
            } ,
            clr: Colors.red[300]!),
            Divider(color:Get.isDarkMode? Colors.grey:darkGreyClr,),
            _buildBottomSheet(label: 'Cancel', onTap:()=> Get.back() ,
            clr: primaryClr),
            SizedBox(height: 20,)
         ],
       ),
     ),
     padding: const EdgeInsets.only( top:4),
     width: SizeConfig.screenWidth,
     color:Theme.of(context).backgroundColor ,
     height: (SizeConfig.orientation==Orientation.landscape)?
     task.isCompleted==1?SizeConfig.screenHeight*.6:SizeConfig.screenHeight*.8
     :task.isCompleted==1?SizeConfig.screenHeight*.38:SizeConfig.screenHeight*.45,
   )
   );
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
           height: 53,
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
