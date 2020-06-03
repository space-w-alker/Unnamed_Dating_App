import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnameddatingapp/app_controller.dart';
import 'global_ui_elements/loading_view.dart';
import 'statics/route_generator.dart';
import 'services/authentication.dart';
import 'statics/constants.dart';

void main() {
  runApp(StreamProvider(
    initialData: null,
    create: (BuildContext context) {
      return Authentication.getUserStream();
    },
    builder: (context, child) {
      return ChangeNotifierProvider(
        create: (BuildContext context) {
          return AppController();
        },
        child: TopLevelWidget(),
      );
    },
    child: Text(""),
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DEFAULT_THEME,
      darkTheme: DARK_THEME,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.routegenerator,
    );
  }
}

class TopLevelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        MainApp(),
        Visibility(
          child: AppLoading(),
          visible: Provider.of<AppController>(context, listen: true).isLoading,
        ),
      ],
    );
  }
}
