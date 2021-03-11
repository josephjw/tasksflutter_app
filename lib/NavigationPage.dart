import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ListScreen.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_state.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPage createState() => _NavigationPage();
}



class _NavigationPage extends State<NavigationPage> {
  MainBloc bloc;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    bloc = BlocProvider.of<MainBloc>(context);
    bloc.init();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      child: SafeArea(child: Scaffold(
        body: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state == Category()) {
              return LangScreen();
            }  else if (state == AddTasks()) {
              return  AlertDialog(
                title: Text("Enter Folder Name",style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),
                ),
                content:TextField(

                  controller: _controller,
                  onSubmitted: (text) => print(_controller.text),
                  decoration: InputDecoration(
                    hintText: "Enter Tasks Name",
                    border: OutlineInputBorder(

                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        bloc.add(CreateFolder(mobileno: _controller.text.toString()));
                      },
                      child: Text("Ok"))
                ],

              );
            }else if (state == Alert()) {
              return Scaffold(
                body: AlertDialog(
                  title: Text("Alert"),
                  content: Text(
                      bloc.msg == null ? "Unknown Error" : bloc.msg),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          bloc.add(OpenDelete(id: bloc.id));
                        },
                        child: Text("Ok"))
                  ],
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: CircularProgressIndicator()),
                  ),
                ],
              );
            }
          },
        ),
      )),
    );
  }

  String getAppbarHead() {
    if (bloc.state == OpenOtp()) {
      return "ABC Logistics";
    }  else {
      return "ABC Logistics";
    }
  }
}
