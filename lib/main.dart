import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'NavigationPage.dart';
import 'bloc/main_bloc.dart';

void main() {

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavigationPage(),
    ),
  ));

}


