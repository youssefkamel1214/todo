import 'package:TODO/db/db_helper.dart';
import 'package:TODO/models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController{
  final tasklist=<Task>[].obs;
  Future<void>deletealltasks()async{
    await DBHelper.deleteall();
    getTasks();
  }
Future<void> getTasks()async{
    print('here');
    final List<Map<String,dynamic>> tasks=await DBHelper.getall();
    tasklist.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
    // print(tasks.length);
    // for (Map<String, dynamic> item in tasks) {
    //          tasklist.add(Task.fromMap(item));
    // }
    // print('aho${tasklist.length}');
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
