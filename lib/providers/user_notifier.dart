import 'package:flutter/material.dart';
import 'package:provider_demo/sqlflite_database/database_helper.dart';

import '../model/user.dart';

class ListNotifier extends ChangeNotifier{

  ListNotifier(){
    getLocalDatabaseUserList();
  }

  List<User> list=[];


  DatabaseHelper databaseHelper =  DatabaseHelper();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  User singleUser = User();

  void deleteElement(int index){
    list.removeAt(index);
    notifyListeners();
  }
  void deleteFromDb(int index){
    databaseHelper.deleteUser(index);
  }

  void insertUser(User user){
    formKey.currentState!.save();
    list.add(user);
    singleUser = User();
    notifyListeners();
  }

  void clear(){
    list.clear();
    notifyListeners();
  }

  void insertUserTOLocalDatabase(User user){
    formKey.currentState!.save();
    databaseHelper.insertUser(user).then((value) => {
      print("user Data Add to database $value"),
    });
    getLocalDatabaseUserList();
    singleUser = User();
    notifyListeners();
  }
  void getLocalDatabaseUserList()async{
    list.clear();

    list=await databaseHelper.getUserList();
    notifyListeners();
  }

  void updateUserOfLocalDb(User user) async{
     await databaseHelper.updateUser(user).then((value) => {
       print("user Data update to database ${user.id}"),
     });
     list=await databaseHelper.getUserList();
     notifyListeners();
  }

  void undoUser(int index, User user){
    list.insert(index, user);
    notifyListeners();
  }

  void undoUserToDb(User user){
     databaseHelper.insertUserFromUndo(user).then((value) => {
       print("user Data update to database ${user.id}"),
    });
    getLocalDatabaseUserList();
  }




}