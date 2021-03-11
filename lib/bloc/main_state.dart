
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
 class MainState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];


}

// ignore: must_be_immutable
class UserHomeInit extends MainState {
 String name,lable;
 UserHomeInit(this.name,this.lable);

}
class OnBoard extends MainState {}
class Login extends MainState {
 bool flag;
 String msg;
 Login({this.flag,this.msg});


}
class OpenOtp extends MainState {}
class LoggedLOADING extends MainState {}
class LoggedERROR extends MainState {}
class ResponseERROR extends MainState {}
class Category extends MainState {}
class AddTasks extends MainState {}

class Alert extends MainState {}


class InitialState extends MainState {}





