
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksflutter_app/custom_edit_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'bloc/main_bloc.dart';

class LangScreen extends StatefulWidget {
  @override
  _LangScreenState createState() => _LangScreenState();
}


class _LangScreenState extends State<LangScreen> {

  MainBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(

      body:   Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(

    mainAxisAlignment: MainAxisAlignment.start,

    children: [

          Expanded(child: Text("To Do ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 19),)),

       InkWell(
           onTap: ()=>bloc.add(OpenAddTasks()),
           child: Text("+ Add New ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 19),)),



    ],

  ),
),

              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: listlang(),
              ),

            ],
          ),


    );
  }

  Widget listlang(){
    return Container(


      child: ListView.builder(
          itemCount: bloc.subusers.length ?? 0,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index){
            TextEditingController email =TextEditingController();

            return ListTile(
              title:bloc.subusers[index].expanded ?

                  CustomEditText(
                    isMandatoryField: false,
                    label:  'Lable',
                    controller: email,
                    suffixIcon: Icons.tab_rounded,
                    textcolor: Colors.black,

                    onsubmit:(txt){
                      bloc.add(OpenEdit(lable: email.text.toString(),id:bloc.subusers[index].id.toString() ));
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Tasks Name';
                      } else {

                      }
                      return null;
                    },
                  )

              : InkWell(
                  onTap: (){
                    setState(() {
                      bloc.subusers[index].expanded=true;
                    });
                    },
                  child: Text("${bloc.subusers[index].description}",style: TextStyle(color: Colors.black,decoration: bloc.subusers[index].completedAt ==null ?TextDecoration.none:TextDecoration.lineThrough,)))  ,
              trailing: InkWell(

                  onTap: (){
                    bloc.id= bloc.subusers[index].id.toString();
                    bloc.add(OpenAlert());
                  },
                  child: Icon(Icons.delete,color: Colors.red,)),
              leading:ToggleSwitch(
                minWidth: 30.0,
                cornerRadius: 20.0,
                activeBgColor: Colors.green,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                labels: ['C', 'N'],
                initialLabelIndex: bloc.subusers[index].completedAt ==null ?1:0,
                onToggle: (txt) {
                  bloc.subusers[index].completedAt ==null
                      ? bloc.add(OpenComplete(id: bloc.subusers[index].id.toString())):

                  bloc.add(OpenUncomplete(id: bloc.subusers[index].id.toString()));
                  print('switched to: $txt');
                },
              ),);
          }),
    );
  }

  int selectedRadio = -1;

  changeValue(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Future resendOtp() async {
    try{
      // var loginapi = new open.AuthenticationApi();
      // final response = await loginapi.apiAuthenticationResendOTPGet( );

    }catch(e){
      print("access OTP for you sir "+e.toString());
    }
  }
}
