import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksflutter_app/model/ToDoList.dart';

import '../CIBHelper.dart';
import 'main_state.dart';
part 'main_event.dart';

enum MainStates {
  LoggedOUT,
  LoggedERROR,
  LoggedLOADING,
  ManageBilling,
  Dashboard,
}

class MainBloc extends Bloc<MainEvent, MainState> {
  var msg = "";
  String id = "";

  Map apiResponse = {};
  var repliedMailsCount = 0;
  var unreadMailsCount = 0;
  bool isAuthorized = false;

  bool loadingEmails = false;

  List<Todolist> subusers = List();

  final stateStreamController =StreamController<String>();

  MainBloc( ) : super(InitialState());
  // MainBloc() : super(initialState());
  StreamSink<String> get sinkdat => stateStreamController.sink;
  Stream<String> get getdata => stateStreamController.stream;

  init() {
this.add(OpenLang());
  }
  CIBHelper cibHelper = CIBHelper.getInstance();

  @override
  Stream<MainState> mapEventToState(MainEvent event,) async* {
    if (event is UserHome) {
     } else if(event is OpenLang){
      yield LoggedLOADING();
      var response = await cibHelper.getAllSubUsers();
      if(response != null) {
        subusers = response;
        yield Category();
      }else{
        msg="No Data";
        yield ResponseERROR();

      }

        } else if(event is CreateFolder){
      yield LoggedLOADING();
      var response = await cibHelper.moveFolder(event.mobileno);
      if(response['status'] >= 200 && response['status'] <= 500) {
this.add(OpenLang());
      }else{
        msg="No Data";
        yield ResponseERROR();

      }

    } else if(event is OpenDelete){
      yield LoggedLOADING();
      var response = await cibHelper.removeUserAccounts(id);
      if(response['status'] >= 200 && response['status'] <= 500) {
        this.add(OpenLang());
      }else{
        msg="No Data";
        yield ResponseERROR();

      }

    }
    else if(event is OpenAlert){
      msg='Are You Sure Want to Delete ?';
      yield Alert();
    } else if(event is OpenEdit){
      yield LoggedLOADING();
      var response = await cibHelper.edit(event.lable,event.id);
      if(response['status'] >= 200 && response['status'] <= 500) {
        this.add(OpenLang());
      }else{
        msg="No Data";
        yield ResponseERROR();

      }
    }else if(event is OpenUncomplete){
      yield LoggedLOADING();
      var response = await cibHelper.uncompleted(event.id);
      if(response['status'] >= 200 && response['status'] <= 500) {
        this.add(OpenLang());
      }else{
        msg="No Data";
        yield ResponseERROR();

      }
    }else if(event is OpenComplete){
      yield LoggedLOADING();
      var response = await cibHelper.completed(event.id);
      if(response['status'] >= 200 && response['status'] <= 500) {
        this.add(OpenLang());
      }else{
        msg="No Data";
        yield ResponseERROR();

      }
    }else if(event is OpenAddTasks){
      yield AddTasks();
    }
  }
}










