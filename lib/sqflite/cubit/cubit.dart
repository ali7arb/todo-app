import 'package:TodoApp/sqflite/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../screens/archived.dart';
import '../screens/done.dart';
import '../screens/tasks.dart';

class ToDoCubit extends Cubit<TodoStates> {
  ToDoCubit() : super(TodoInitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  int currentIndex = 0;
  IconData icon = Icons.edit;
  bool isBottomSheetShow = false;
  List<Widget> screens = [
    const TasksScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];
  List<String> title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(TodoChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // ignore: avoid_print
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          // ignore: avoid_print
          print('table created');
        }).catchError((error) {
          // ignore: avoid_print
          print('Error when Creating Table${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDB(database);
        // ignore: avoid_print
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(TodoCreateDBStates());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        // ignore: avoid_print
        print('$value insert done!');
        emit(TodoInsertDBStates());
        getDataFromDB(database);
      }).catchError((error) {
        // ignore: avoid_print
        print(error.toString());
      });
      return Future.value();
    });
  }

  void getDataFromDB(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(TodoGetDBStates());
    });
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    icon = icon;

    emit(TodoChangeBottomSheetState());
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status=? WHERE id =?',
      [
        status,
        id,
      ],
    ).then((value) {
      getDataFromDB(database);
      emit(TodoUpdateDBStates());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id=?', [id]).then((value) {
      getDataFromDB(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
