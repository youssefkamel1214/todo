import 'package:TODO/db/db_helper.dart';
import 'package:TODO/models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController{
  final tasklist=<Task>[].obs;
 Rx<bool> loaded=false.obs;
 Rx< DateTime> selcteddate=DateFormat.yMd().parse( DateFormat.yMd().format( DateTime.now())).obs ;
  Future<void>deletealltasks()async{
    await DBHelper.deleteall();
    getTasks();
  }
  TaskController(){
   getTasks();
  }
void updatedate(DateTime aa)
{
  this.selcteddate.update((val) {
    this.selcteddate.value=aa;
  });
}

Future<void> getTasks()async{
    final List<Map<String,dynamic>> tasks=await DBHelper.getall();
    tasklist.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
    loaded.update((val) {
      loaded.value=true;
    });
  }
 Future<int> addTask({required Task task})async{
   print(task.title);
    return await DBHelper.insert(task);
  }
  Future<void> deleteTask(Task task)async{
         await DBHelper.delete(task);
        
         getTasks();
  }
  Future<void> markTaskcompleted(Task task)async{
         await DBHelper.update(task);
         getTasks();
  }
}
