import 'package:TODO/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  final tasklist=<Task>[
    Task(color: 0,title: 'af',note: 'asf',isCompleted: 0,startTime: '8:18',endTime: '9:18')
    ,Task(color: 1,title: 'af1',note: 'asf',isCompleted: 0,startTime: '8:18',endTime: '9:18')
    ,Task(color: 2,title: 'af2',note: 'asf',isCompleted: 0,startTime: '8:18',endTime: '9:18')
  ];
  getTask(){
    
  }
}
