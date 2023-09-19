import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_cancer_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(initialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    ' New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void changeindex(int index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }

  Database? database;
  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archiveTasks =[];


  void createDatabase()  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT)')
            .then((value) {
          print('tables created');
          emit(CreateDBState());
        }).catchError((error) {
          print('error when creating table${error.toString()}');
        });
      },
      onOpen: (database) {
        getData(database);
        print('database opened');
      },
    ).then((value) {
      database=value;
      emit(CreateDBState());
    } );
  }

   insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
 await database?.transaction((txn) async {
      txn.rawInsert('INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(InsertDBState());
        getData(database);
      }).catchError((error) {
        print('error when inserting new task${error.toString()}');
      });
     return null;
    });
  }

  void getData(database)  {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(GetDBLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
           {
             value.forEach((element){
               if(element['status']=='new')
               {
                 newTasks.add(element);
               }
               else if(element['status']=='done')
               {
                 doneTasks.add(element);
               }
               else archiveTasks.add(element);

             });

            emit(GetDBState());
          }
        });
  }
  void updateDate({
    required String status, required int id,
  })async{
     database?.rawUpdate(
    'UPDATE tasks SET status = ? WHERE id = ?',
    ['$status', id],
     ).then((value) {
       getData(database);
      emit(UpdateDBState());
     });
  }

  void DeleteData({
     required int id,
  })async{
     database?.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
         .then((value) {
       getData(database);
      emit(DeleteDBState());
     });
  }

  bool isBottomSheet=false;
  IconData icon=Icons.edit;
  void changeBottomShhet({
  required bool isShow,
  required IconData sheeticon,
}){
    isBottomSheet=isShow;
    icon=sheeticon;
    emit(BottomSheetBarState());

}
bool isDark = false;
 void changeMode(){
   isDark = !isDark;
   emit(ChangeModeState());
 }
}
