import 'dart:ffi';

import 'package:TODO/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
 static final int version =2;
 static final String dbname='Tasks';
 static var table = 'Task';

  static   Database? database;
static Future<void>InitDB()async{
  
  if(database==null)
  {
    try {
      String path=await getDatabasesPath()+'${dbname}.db';
      database=await openDatabase(path,version: version,
     onCreate:(db, version) async{
       await db.
       execute("CREATE TABLE ${table} (id INTEGER PRIMARY KEY AUTOINCREMENT"+
       ",title text,note text,isCompleted intger ,date text,startTime text,"+
       "endTime text ,color integer,remind intger ,repeat  text )");
     }, );
    } catch (e) {
      print('A7AA');
      print(e);
    }     
  }
}
static Future<dynamic>getall()async{
  try {
    
  var a= database!.query(table,);
  return a;  
  } catch (e) {
    print(e);
  }
  
}
static Future<void>update(Task task)async{
    try {
       int id2=await database!.rawUpdate('update ${table} set iscompleted= ? '+
       'where id= ?',[1,task.id]);
       print('upadatedsuccefull');
    } catch (e) {
      print(e);
    }
}
static Future<void>delete(Task task)async{
    try {
       int id2=await database!.delete(table,where: 'id=?',
       whereArgs: [task.id]);
       print('deleted succufully');
    } catch (e) {
      print(e);
    }
}
static Future<void>deleteall()async{
    try {
       int id2=await database!.delete(table);
       print('deleted succufully');
    } catch (e) {
      print(e);
    }
}
static Future<int>insert(Task task)async{
    try {
       int id2=await database!.insert(table, task.toMap());
       print('inserted correctly');
           return id2;
    } catch (e) {
      print(e);
      return-1;
    }
}
}

