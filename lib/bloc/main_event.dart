part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class UserHome extends MainEvent {}

class OpenBilling extends MainEvent {}

class OpenAddTasks extends MainEvent {}


class OpenLang extends MainEvent {}
class OpenDelete extends MainEvent {

  String id;
  OpenDelete({this.id});
}

class OpenEdit extends MainEvent {

  String id,lable;
  OpenEdit({this.id,this.lable});
}
class OpenAlert extends MainEvent {}
class OpenComplete extends MainEvent {
  String id;
  OpenComplete({this.id});
}
class OpenUncomplete extends MainEvent {
  String id;
  OpenUncomplete({this.id});
}

class CreateFolder extends MainEvent {

  String mobileno;
  CreateFolder({this.mobileno});
}
class CreateAccount extends MainEvent {}
class OpenVerificationSuccessPage extends MainEvent {}

class CreateUser extends MainEvent {}




