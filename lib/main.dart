import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:template/routes/f_router.dart';
import 'package:template/routes/f_router_setup.dart';

import 'module/home_page.dart';

void main() {
  FRouter().setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: FluroRouter.appRouter.generator,
      home: HomePage(),
    );
  }
}
